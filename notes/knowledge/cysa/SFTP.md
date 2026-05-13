# SFTP — Secure File Transfer Protocol

## What it is

In **The Witcher 3**, when Geralt needs to move a sealed letter from Novigrad to Vizima without the Eternal Fire's spies steaming it open at every waystation, he doesn't ride the main road. He hires a courier who knows the underground tunnel beneath St. Gregory's Bridge — one encrypted passage, one trusted key, one identity check at the door. The letter never touches open air. That's exactly what SFTP does — it's the underground courier route for files, with the gate guard checking your sigil before you ever step inside.

**Plain English:** SFTP is how you move files between machines without anyone in the middle reading or tampering with them. It looks like FTP from the user's seat — `put`, `get`, `ls` — but the whole conversation runs inside an SSH tunnel.

**Technical definition:** Secure File Transfer Protocol (also called SSH File Transfer Protocol) is a file-transfer and remote-filesystem protocol that operates as a subsystem of **SSH (Secure Shell)** on **TCP/22**. It provides authenticated, encrypted file access, transfer, and management over a single channel. It is **not** FTPS (which is FTP wrapped in TLS on ports 989/990) and it is **not** FTP-over-SSL. SFTP is its own protocol that happens to share a verb vocabulary with FTP.

Key properties:
- **Port:** TCP/22 (same as SSH)
- **Auth:** password, public key, or both (key-based is the standard for service accounts)
- **Encryption:** whatever the negotiated SSH cipher suite gives you — AES-GCM, ChaCha20-Poly1305, etc.
- **Integrity:** built into the SSH transport layer (MACs on every packet)

## Why it matters

SFTP is the boring, omnipresent plumbing of every enterprise. Payroll exports drop to a partner's SFTP server every Friday at 23:00. Backup jobs push tarballs to a DR site over SFTP. Vendors hand you a key pair and a server name and say "drop the SBOM there." The SOC sees SFTP in three contexts and you need to triage all three correctly:

1. **Legitimate batch jobs** — 95% of SFTP traffic in your environment.
2. **Insider data theft** — someone uploads the customer database to a personal SFTP server on a VPS.
3. **C2 and exfiltration over an encrypted channel** — malware uses SFTP to blend with normal admin traffic, because port 22 is almost always allowed outbound for ops staff.

**Exam relevance:** CS0-003 Objective 1.3 covers tools and techniques for determining malicious activity. SFTP shows up under network indicators, [[Packet capture]] interpretation, [[Log analysis]] correlation, and **command and control** detection. CompTIA expects you to know SFTP runs on **TCP/22**, that you cannot decrypt the payload from a packet capture without the keys, and that detection pivots to **metadata** — destination, volume, timing, JA3/JA3S-style fingerprints (the SSH equivalent is HASSH).

## Key facts

### Protocol mechanics — what's on the wire

| Layer | What's happening | What you can see |
|---|---|---|
| TCP/22 | Connection setup | Source/dest IP, ports, timing |
| SSH transport | Key exchange, cipher negotiation | Client/server version banners, HASSH fingerprint |
| SSH user auth | Password or pubkey | Auth success/fail in sshd logs |
| SSH connection | Channel multiplexing | Channel opened (one per SFTP session) |
| SFTP subsystem | File ops: OPEN, READ, WRITE, CLOSE, REMOVE | **Encrypted — not visible in pcap** |

The trap: in a packet capture, after the SSH handshake completes, **you see encrypted bytes and nothing else**. You will not see filenames, file sizes, or directory paths in Wireshark. You see flow direction and volume. That's it.

### SFTP vs the lookalikes

> **CompTIA exam trap:** SFTP, FTPS, and FTP-over-SSH are three different things. **SFTP** = SSH subsystem, TCP/22, single channel. **FTPS** = FTP with TLS, control on TCP/21 (explicit) or TCP/990 (implicit), data on TCP/989 or ephemeral. **FTP** = plaintext, TCP/20 (data) and TCP/21 (control), never use it. If the question shows port 22 and says "secure file transfer," answer SFTP. If it shows port 990 or 21 with TLS, answer FTPS.

| Protocol | Port(s) | Auth | Encrypted? | Notes |
|---|---|---|---|---|
| FTP | 21/20 | Password (plaintext) | No | Legacy, avoid |
| FTPS | 21 or 990, 989, ephemeral | Cert + password | TLS | Multiple ports = firewall pain |
| SFTP | 22 | Pubkey or password | SSH | One port, one channel |
| SCP | 22 | Pubkey or password | SSH | Older, less featureful, mostly deprecated |

### Detecting malicious SFTP — pivot to metadata

You cannot see file contents. You can see:

- **Destination reputation** — pivot the dest IP through [[VirusTotal]], [[AbuseIPDB]], and [[WHOIS]]. A 23-day-old domain on a Lithuanian VPS receiving 4GB of SFTP traffic from your finance subnet at 02:00 is your incident.
- **Volume anomalies** — baseline SFTP egress per host. A workstation that normally pushes 12MB/day suddenly pushing 8GB is the alert. [[User behavior analysis]] tools (UEBA) catch this.
- **Timing** — scheduled jobs are boring and predictable. Ad-hoc 03:00 transfers from a sales laptop are not.
- **Destination outside the partner allowlist** — your SFTP partners should be a known short list. Anything else is suspect.
- **[[Impossible travel]]** — the same SSH key authenticating from Frankfurt and São Paulo 12 minutes apart means the key is compromised.
- **HASSH fingerprint mismatch** — legitimate clients (WinSCP, FileZilla, OpenSSH, Java JSch) have predictable HASSH hashes. Custom malware SSH clients fingerprint differently.

### Log sources that matter

| Source | What it tells you |
|---|---|
| `sshd` syslog / journald | Auth attempts, key fingerprints, source IPs, session duration |
| Firewall / NetFlow / IPFIX | Bytes in/out per flow, dest IP, duration |
| EDR ([[Endpoint detection and response]]) | Process that invoked the SFTP client (sftp.exe, WinSCP.exe, psftp.exe, scripted Python paramiko) |
| [[SIEM]] correlation | Stitch sshd auth + NetFlow volume + EDR process tree into one timeline |
| Zeek / Suricata | SSH protocol metadata, HASSH, version strings, connection state |

### Detection playbook — what queries to run

In your SIEM:

```
event.dataset:zeek.ssh AND destination.ip NOT IN partner_sftp_allowlist
| stats sum(network.bytes) by source.ip, destination.ip
| where sum_bytes > 100000000
```

In sshd logs, hunt for:
- Authentication from a service account outside its normal subnet
- Public key auth where the key fingerprint isn't in your inventory
- Sessions longer than 4 hours from a "batch job" account (real batch jobs finish and disconnect)
- Repeated failed auth followed by success — possible key spray or stolen credential

### When SFTP is actually the malware

[[Command and control]] over SSH/SFTP is real. Tools that do this:

- **Cobalt Strike** with an SSH beacon (port 22, looks like admin traffic)
- **Custom Go/Rust implants** using `golang.org/x/crypto/ssh`
- **Linux backdoors** that drop an `authorized_keys` entry and exfil via SCP/SFTP nightly

Detection pivots:
- EDR sees `bash -c` or `powershell.exe` spawning an SFTP client to a non-corporate destination
- The destination isn't in your asset inventory, isn't your DR site, isn't a known partner
- The transfer is one-way and outbound (real admin work is bidirectional)
- The process that called SFTP isn't a human's shell — it's a service, a scheduled task, or a child of a suspicious parent

### SFTP server hardening — the blue-team checklist

- **Disable password auth** — keys only (`PasswordAuthentication no` in `sshd_config`)
- **ChrootDirectory** per user — they see their dropbox, nothing else
- **AllowGroups sftp-users** — explicit allowlist
- **Match Group sftp-users / ForceCommand internal-sftp** — no shell access, SFTP subsystem only
- **MaxAuthTries 3, LoginGraceTime 30** — kill brute force
- **fail2ban / CrowdSec** on the public-facing server
- **Log every session** to SIEM with full key fingerprint
- **Rotate keys** annually; revoke on offboarding immediately

> **CompTIA exam trap:** SFTP is not "FTP with a password." Password-only SFTP on a public-facing server is brute-forceable like any SSH service. Default-credential SFTP is how partner-portal breaches start. Key-based auth is the answer.

### Tooling — what you'll actually touch

| Tool | Use |
|---|---|
| [[Wireshark]] | Confirm SSH handshake, extract version banner, identify HASSH |
| Zeek | Long-term SSH protocol logging |
| [[Strings]] on a captured binary | Find hardcoded SFTP server addresses or keys in malware |
| [[Python]] + paramiko | Build a honeypot SFTP server to study attacker behavior |
| [[PowerShell]] (`Posh-SSH`) | Hunt for SFTP client processes on Windows endpoints |
| [[Cuckoo Sandbox]] / [[Joe Sandbox]] | Detonate a suspicious binary and watch for outbound SSH/SFTP |
| [[Regular expressions]] in SIEM | Match SFTP-specific log strings (`subsystem request for sftp`) |

## SOC reality

- The 3am alert: "Anomalous outbound TCP/22 from `FINANCE-LT-082` to `45.61.x.x`, 2.3GB transferred, no prior history." Your first move is **not** to block — it's to pull NetFlow for the last 30 days on that host and check if this is a real first-time event or just a tuned-out repeat.
- The L1 question is always: "Is this the partner allowlist?" The allowlist is your single best filter. If you don't have one, build it before you do anything else this quarter.
- The CISO question is always: "What was in the file?" You cannot answer this from network telemetry. You answer it from the endpoint — file access logs, DLP, EDR file-write events on the source host leading up to the transfer. *I learned this the hard way at 4am once: pcap of an SFTP exfil is useless without the matching endpoint context. Always pull both.*
- Never promise "we blocked the exfil." You blocked the **session**. The first 2.3GB is already gone. Containment is stopping the next session; recovery is figuring out what was in the first one.
- Handoff: L1 confirms anomaly and partner-list miss → L2 pulls endpoint forensics and identifies the file set → IR lead decides notification → legal handles partner/regulatory disclosure if PII left the building.

## Related concepts

[[SSH]] · [[FTPS]] · [[Packet capture]] · [[Wireshark]] · [[Command and control]] · [[Data exfiltration]] · [[NetFlow]] · [[Zeek]] · [[SIEM]] · [[Endpoint detection and response]] · [[User behavior analysis]] · [[Impossible travel]] · [[WHOIS]] · [[AbuseIPDB]] · [[VirusTotal]] · [[Log analysis]] · [[Public key infrastructure]] · [[Insider threat]]

*Source: VIRGIL knowledge base — 2026-05-11*