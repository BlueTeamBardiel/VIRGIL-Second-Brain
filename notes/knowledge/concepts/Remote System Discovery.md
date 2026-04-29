# Remote System Discovery

## What it is
Like a burglar casing a neighborhood — peering at house numbers, noting which lights are on, and mapping driveways before picking a target — remote system discovery is an attacker's systematic survey of a network to identify live hosts, open ports, and active services. Formally, it is the technique (MITRE ATT&CK T1018) of enumerating networked systems to build a target map before lateral movement or exploitation.

## Why it matters
During the 2020 SolarWinds supply chain attack, threat actors used remote system discovery after initial access to silently enumerate internal hosts using tools like `net view` and `ping` sweeps — identifying high-value targets like domain controllers before escalating privileges. Defenders who monitored for unusual ICMP bursts or mass SMB enumeration from a single host could have detected the reconnaissance phase early and contained the breach.

## Key facts
- **MITRE ATT&CK T1018** specifically covers remote system discovery; it is a sub-technique of the Discovery tactic, distinct from network scanning (T1046)
- Common tools used: `net view`, `nltest`, `ping` sweeps, `nmap`, PowerShell `Test-Connection`, and ARP cache queries (`arp -a`)
- Attackers query **NetBIOS, LDAP, DNS, and Active Directory** to discover hosts without triggering port-based IDS signatures
- Defenders detect it by alerting on **high-volume ICMP, SMB enumeration from workstations, or unusual AD LDAP queries** from non-admin accounts
- On Security+/CySA+ exams, remote system discovery is often paired with **passive vs. active reconnaissance** — active scans (nmap) generate noise; passive methods (ARP cache, AD queries) are stealthier

## Related concepts
[[Network Scanning]] [[Lateral Movement]] [[Active Directory Enumeration]] [[MITRE ATT&CK Framework]] [[Intrusion Detection Systems]]