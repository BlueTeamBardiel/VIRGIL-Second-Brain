# Active Reconnaissance

## What it is
Like a burglar who walks up to your house, jiggles the doorknob, and peers through windows — rather than just watching from across the street — active reconnaissance involves directly interacting with a target system to gather intelligence. It is the process of probing a target network or host using tools that generate traffic and touch the target, such as port scanners, ping sweeps, and service enumeration utilities. Unlike passive recon, active recon leaves traces in logs and can trigger IDS/IPS alerts.

## Why it matters
During a red team engagement against a financial firm, an attacker runs `nmap -sV` against the exposed IP range and discovers an unpatched FTP service on port 21 running vsftpd 2.3.4 — a version with a known backdoor. This single active scan, taking under 60 seconds, reveals the exact entry point used to compromise the network. Defenders monitoring for SYN floods or abnormal port sweep patterns can detect and respond to this phase before exploitation begins.

## Key facts
- **Nmap** is the canonical active recon tool; the `-sS` (SYN scan) flag sends half-open TCP connections to avoid full handshakes
- Active recon **violates the law** against unauthorized targets — it generates packets that physically reach the victim's infrastructure (CFAA implications)
- **Banner grabbing** (e.g., `telnet target.com 80`, then `HEAD / HTTP/1.0`) is a simple active technique that reveals service version info
- Port scanning categories: **open, closed, filtered** — filtered ports indicate a firewall is dropping/rejecting packets
- On Security+/CySA+, active recon is distinguished from passive recon by the key criterion: **does your traffic touch the target?**

## Related concepts
[[Passive Reconnaissance]] [[Port Scanning]] [[Enumeration]] [[Nmap]] [[OSINT]]