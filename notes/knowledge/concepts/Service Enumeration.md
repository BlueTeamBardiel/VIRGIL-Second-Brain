# Service enumeration

## What it is
Like a locksmith walking a building's perimeter and jotting down every door, keyhole type, and lock model before picking anything — service enumeration is the systematic process of querying a target system to discover which services are running, on which ports, and what versions they are. It transforms a vague IP address into a detailed map of potential attack surfaces.

## Why it matters
During the 2017 WannaCry outbreak, attackers relied on knowing that SMB (port 445) was exposed and running a vulnerable version — exactly the kind of intelligence service enumeration provides. Defenders use the same technique proactively: running Nmap scans against their own infrastructure to find forgotten services (a legacy FTP daemon, an unpatched SSH version) before attackers do.

## Key facts
- **Nmap** is the canonical tool; `-sV` flag performs version detection while `-A` enables OS detection, version detection, and script scanning simultaneously
- **Banner grabbing** (via Netcat or Telnet) pulls service banners that often reveal software name and version — a quick manual alternative to full scans
- Service enumeration is part of the **reconnaissance/scanning phase** of the cyber kill chain and the MITRE ATT&CK "Discovery" tactic (T1046 - Network Service Scanning)
- Common high-value enumeration targets: port 22 (SSH), 80/443 (HTTP/S), 445 (SMB), 3389 (RDP), 1433/3306 (databases)
- **SNMP enumeration** (UDP port 161) using default community strings like "public" can reveal entire network topologies and device configs — a frequently tested Security+ scenario

## Related concepts
[[Port scanning]] [[Banner grabbing]] [[Network reconnaissance]] [[Vulnerability scanning]] [[OSINT]]