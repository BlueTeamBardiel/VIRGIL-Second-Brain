# network scanning

## What it is
Like a locksmith walking down a hallway and jiggling every doorknob to see which rooms are unlocked, network scanning systematically probes hosts and ports to discover what's alive, what services are running, and what vulnerabilities might be exposed. It's the reconnaissance phase where an attacker (or defender) maps the attack surface before striking or hardening.

## Why it matters
Before the 2013 Target breach, attackers performed internal network scanning after pivoting through an HVAC vendor's credentials, identifying POS systems and lateral movement paths to the cardholder data environment. Defenders use the same technique — scheduled scans with tools like Nmap or Nessus — to find rogue devices and misconfigured services before attackers do.

## Key facts
- **Nmap** is the de facto standard; key flags include `-sS` (SYN/stealth scan), `-sV` (version detection), `-O` (OS fingerprinting), and `-p-` (all 65,535 ports)
- A **SYN scan** sends a SYN packet but never completes the three-way handshake, making it quieter than a full TCP connect scan and less likely to appear in application logs
- **ICMP ping sweeps** identify live hosts; blocking ICMP entirely can hide hosts but breaks legitimate network diagnostics (dual-edged)
- Port states returned by scanners: **open**, **closed**, and **filtered** — filtered usually indicates a firewall is dropping or rejecting packets
- Unauthorized scanning against systems you don't own violates the **Computer Fraud and Abuse Act (CFAA)** in the US; always obtain written permission before scanning

## Related concepts
[[port enumeration]] [[vulnerability scanning]] [[reconnaissance]] [[firewall evasion]] [[network topology discovery]]