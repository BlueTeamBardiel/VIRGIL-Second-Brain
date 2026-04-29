# Active Scanning

## What it is
Like a burglar walking up to every house on the street, jiggling doorknobs and peering through windows — active scanning is when an attacker (or defender) deliberately sends packets to a target network to discover live hosts, open ports, running services, and vulnerabilities. Unlike passive reconnaissance, it generates traffic that touches the target and can be logged or detected.

## Why it matters
Before the 2017 Equifax breach, attackers actively scanned for systems running a vulnerable version of Apache Struts (CVE-2017-5638). Defenders who ran their own active scans with tools like Nessus would have found the same exposed endpoint first — illustrating why organizations must scan themselves before attackers do. Active scanning is both the attacker's first move and the defender's essential hygiene.

## Key facts
- **MITRE ATT&CK T1595** categorizes Active Scanning under Reconnaissance, with sub-techniques including port scanning (T1595.001) and vulnerability scanning (T1595.002)
- **Nmap** is the canonical tool; a full TCP connect scan (`-sT`) completes the three-way handshake, while a SYN scan (`-sS`) sends only the SYN to reduce noise
- Active scanning is **detectable** — IDS/IPS systems flag characteristic patterns like sequential port sweeps, ICMP echo storms, and banner-grabbing attempts
- **Credentialed vs. uncredentialed scans**: credentialed vulnerability scans log into targets to inspect configuration details, producing far fewer false negatives than uncredentialed scans
- On Security+/CySA+: active scanning falls under the **reconnaissance phase** of the cyber kill chain and is considered an **active** (not passive) threat intelligence technique

## Related concepts
[[Passive Reconnaissance]] [[Vulnerability Scanning]] [[Network Enumeration]] [[Port Scanning]] [[MITRE ATT&CK Framework]]