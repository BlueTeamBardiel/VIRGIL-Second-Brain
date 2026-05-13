# FTP — File Transfer Protocol

## What it is

In **Factorio**, you watch a freight train pull into the unloading station hauling iron plates. The cargo wagons sit on the rails in plain sight, the inserters scoop the contents into chests, and anyone with a deconstruction planner standing nearby can see exactly what's moving, where it came from, and where it's going. No encryption, no cover, no fog of war. The biters could be watching the whole supply line and you'd never know — the protocol that runs your rail network doesn't care who's looking. That's exactly what FTP does: shovels files between hosts over the network with the cargo, the manifest, and the credentials all riding in cleartext on the wire.

**Plain English:** FTP is an old file transfer protocol from 1971 that sends usernames, passwords, and file contents as readable text. Anyone with a packet capture between the two endpoints reads the whole conversation.

**Technical definition:** File Transfer Protocol is an application-layer protocol (RFC 959) using TCP **port 21** for the control channel and **port 20** for active-mode data transfers. Authentication and data both transit unencrypted. FTP supports two connection modes — **active** (server initiates the data connection back to the client) and **passive** (client initiates both connections, server picks a high port for data). Active mode breaks NAT and most modern firewalls; passive mode is the default in 2026.

## Why it matters

For CySA+ CS0-003 Objective 1.3, FTP is one of those protocols the exam expects you to spot in a packet capture, recognize as malicious-activity-adjacent, and know exactly why it shows up in incident timelines. Attackers love FTP for the same reason network admins still tolerate it: it's everywhere, it's simple, and nobody's monitoring it closely. Threat actors stage FTP servers as **exfiltration drop sites** and **malware staging hosts** because the protocol blends in with legitimate legacy traffic and the credentials are trivial to brute force or sniff.

In real SOC work, FTP shows up in three flavors of alert: an internal host beaconing to an external FTP server on port 21 (likely [[exfiltration]] or C2 staging), a credentialed scan flagging an FTP server with anonymous login enabled (a public file-share waiting to host a phish), and a Wireshark capture during IR where the analyst pulls a cleartext password out of a TCP stream in thirty seconds.

The exam will not ask you to memorize RFC 959. It will ask you to interpret a packet capture, identify a protocol by port, recognize why it's risky, and pick the right hardened replacement.

## Key facts

### Port and protocol mechanics

| Port | Protocol | Purpose | Encryption |
|---|---|---|---|
| **21/TCP** | FTP control | Authentication, commands (USER, PASS, RETR, STOR) | None |
| **20/TCP** | FTP active-mode data | File payload | None |
| **High TCP (passive)** | FTP passive-mode data | File payload | None |
| **989, 990/TCP** | [[FTPS]] (FTP over TLS) | Encrypted control + data | TLS |
| **22/TCP** | [[SFTP]] (SSH File Transfer) | Encrypted file transfer over SSH | SSH |
| **69/UDP** | [[TFTP]] (Trivial FTP) | Network device configs, PXE boot | None, no auth |

**SFTP is not FTPS.** SFTP rides on SSH (port 22) and is a completely different protocol. FTPS is FTP wrapped in TLS. CompTIA will swap these in answer choices.

### FTP commands you should recognize in a capture

- **USER** — submits the username (cleartext)
- **PASS** — submits the password (cleartext, ASCII, readable)
- **RETR** — retrieves a file from server to client (download)
- **STOR** — stores a file from client to server (upload — common in exfil)
- **LIST / NLST** — directory listing
- **PASV** — request passive mode
- **QUIT** — close session

In [[Wireshark]], filter `ftp` and the right pane gives you a human-readable transcript. `Follow → TCP Stream` reconstructs the entire session. If credentials crossed that connection, you have them.

### Why FTP is a CySA+ red flag

1. **Cleartext credentials.** Any analyst with [[packet capture]] access between client and server sees `USER admin` and `PASS S3cret!` on consecutive lines. This is the textbook example for teaching why encryption matters.
2. **Anonymous login.** Many FTP servers ship with `anonymous` / blank-password enabled. Common in legacy file shares, almost always misconfigured.
3. **Bounce attacks.** The FTP `PORT` command can be abused to make the server scan or attack a third party (RFC 2577 mitigations exist, but legacy servers are still vulnerable).
4. **Exfiltration channel.** Attackers point compromised hosts at attacker-controlled FTP servers and use STOR to push out staged data. The traffic looks like "legacy file sync" to anyone not paying attention.
5. **Malware staging.** Public FTP servers with anonymous write access become free hosting for second-stage payloads. The phishing email contains an embedded link to `ftp://compromised-server[.]example/payload.exe`.
6. **Brute-force surface.** FTP has no built-in rate limiting. Attackers hammer port 21 with credential lists and the server happily answers every attempt.

### How it shows up in detection

**SIEM rules** ([[SIEM]] correlation) typically flag:
- Outbound TCP/21 from any internal host that isn't a known file-server admin
- High-volume STOR commands from a single internal source
- FTP authentication success following multiple failures (brute-force breakthrough)
- Anonymous login events on internet-facing FTP servers

**[[EDR]]** sees the client side — a process like `ftp.exe`, `WinSCP.exe`, or a [[PowerShell]] cmdlet (`Send-FtpFile`, `System.Net.WebClient`) initiating outbound port 21. PowerShell that wraps FTP into a one-liner is a classic [[living-off-the-land]] signal.

**Packet capture analysis** in Wireshark:
- `ftp.request.command == "PASS"` — surfaces every password attempt
- `ftp-data` — isolates the data channel for file carving
- `tcp.port == 21 and tcp.flags.syn == 1` — connection attempts

### Hardened replacements

| Use case | Replace FTP with |
|---|---|
| Interactive file transfer | [[SFTP]] (port 22) |
| Automated server-to-server | SFTP or [[FTPS]] |
| Web-facing file drop | [[HTTPS]] with signed URLs |
| Network device config push | [[SCP]] or vendor management plane (never TFTP across untrusted segments) |

If you find FTP in a 2026 environment, the question isn't "should we replace it" — it's "what's blocking the migration and who owns the legacy app." That conversation is an **inhibitor to remediation** in CySA+ language: legacy systems, vendor lock-in, or a business process built on a hardcoded FTP path nobody wants to refactor.

### CompTIA exam traps

> **CompTIA exam trap:** SFTP vs FTPS. SFTP is **SSH File Transfer Protocol**, runs over port 22, single connection. FTPS is **FTP over TLS**, runs over 989/990 (implicit) or 21 with AUTH TLS (explicit), uses separate control and data channels. They are not interchangeable and the exam will offer both as answers.

> **CompTIA exam trap:** TFTP is not "FTP but smaller." TFTP uses UDP/69, has **no authentication at all**, and is used for network device firmware, PXE boot, and IP phone configs. If a question describes "unauthenticated file transfer for network appliances," the answer is TFTP, not FTP.

> **CompTIA exam trap:** Active vs passive mode. **Active** mode = server connects back to client on port 20 (breaks client-side NAT/firewalls). **Passive** mode = client opens both connections (works through NAT, but requires server-side firewall to allow a range of high ports). CompTIA loves asking which mode works through which firewall configuration.

> **CompTIA exam trap:** Port 20 is FTP **data** in active mode only. Port 21 is always the control channel. A capture showing only port 21 traffic with no data is a session that authenticated but transferred nothing — possibly a recon scan or a failed exfil attempt.

### Tool-driven analysis

When FTP shows up in IR, the analyst toolkit looks like this:

- **[[Wireshark]] / tcpdump** — capture and follow the TCP stream, extract credentials and transferred files
- **[[Strings]]** — run against carved file payloads to surface readable indicators
- **[[VirusTotal]]** — hash any extracted binary, check reputation
- **[[Hashing]]** (SHA-256) — fingerprint the transferred file for IOC sharing
- **[[Sandboxing]]** ([[Cuckoo Sandbox]], [[Joe Sandbox]]) — detonate the binary in isolation, watch its network callouts
- **[[WHOIS]] / [[AbuseIPDB]]** — pivot on the destination IP, check registration age and reported abuse
- **[[Regular expressions]]** — grep FTP logs for credential patterns, filename patterns, abnormal STOR volumes
- **[[Python]] / [[PowerShell]]** — automate log parsing, IOC extraction, and SIEM enrichment

## SOC reality

- The 3am alert reads `Outbound FTP connection from FINANCE-WKSTN-04 to 185.x.x.x:21, STOR commands observed, 240MB transferred over 18 minutes`. L1 acknowledges, pulls the user, checks if it's a known business process. It isn't. Escalate to L2 with PCAP attached.

- L2 pulls the PCAP into Wireshark, follows the TCP stream, finds `USER backupsvc / PASS Spring2024!` in cleartext, and the file list shows `customer_export_2026Q1.csv`. That's a real exfil. IR lead gets paged.

- The CISO's first three questions, in order: *"What left the building, what's the regulatory clock, and is the channel still open?"* "We saw FTP traffic" is not an answer. "STOR commands transferred 240MB of customer PII to an IP registered in [country] 11 days ago, the connection is severed, host is isolated, forensic image in progress" is an answer.

- Never tell leadership "we've contained it" until the host is off the network, the credential is rotated, the egress firewall rule is in place, and the threat hunt has confirmed no other beacons. *An isolated host is not a contained incident. An incident is contained when you know the full blast radius, not when one alert went quiet.*

- Handoff chain: L1 (triage and scope) → L2 (PCAP analysis, IOC extraction) → IR team (containment, forensic acquisition, chain of custody) → Legal (regulatory notification clock — GDPR 72h if EU data, state laws if US PII) → Executive (business impact, customer notification decision).

- The migration ticket to kill FTP and move to SFTP has been open for 14 months. The legacy vendor charges $40k for the protocol upgrade. The change board tabled it three times. *This is what inhibitors to remediation look like in the wild — the protocol that just leaked your data was a known risk on someone's spreadsheet.*

## Related concepts

[[SFTP]] · [[FTPS]] · [[TFTP]] · [[Wireshark]] · [[Packet capture]] · [[Exfiltration]] · [[Command and control]] · [[SIEM]] · [[EDR]] · [[Cleartext protocols]] · [[Living-off-the-land]] · [[Anonymous authentication]] · [[Inhibitors to remediation]] · [[Chain of custody]] · [[Network segmentation]] · [[Egress filtering]] · [[Data loss prevention]]

*Source: VIRGIL knowledge base — 2026-05-11*