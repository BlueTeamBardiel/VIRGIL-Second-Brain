# System Network Configuration Discovery

## What it is
Like a burglar casing a building by checking which doors exist, which floors are occupied, and how the security cameras connect — attackers enumerate a compromised host's network settings to understand where they are and where they can go. Precisely, this is the technique (MITRE ATT&CK T1016) where adversaries query local network configuration data — IP addresses, routing tables, DNS settings, ARP caches, and proxy configurations — to map the environment and plan lateral movement.

## Why it matters
During the SolarWinds breach, threat actors used network discovery commands on compromised hosts to identify internal subnets and segment boundaries before moving laterally toward high-value targets. Defenders monitoring for unusual execution of `ipconfig`, `netstat`, or `route print` in bulk — especially from service accounts — can detect this reconnaissance phase before the attacker escalates.

## Key facts
- Common commands used: `ipconfig /all` (Windows), `ifconfig`/`ip addr` (Linux), `netstat -r`, `arp -a`, and `nslookup`
- MITRE ATT&CK classifies this under **Discovery (TA0007)**, tactic T1016
- Attackers use this to find dual-homed hosts — machines with multiple NICs that bridge network segments, making them pivot points
- DNS configuration queries can reveal internal domain names and nameserver architecture, aiding spear-phishing and further reconnaissance
- Detection strategy: baseline normal script/process behavior; alert on enumeration commands spawned by unusual parent processes (e.g., `cmd.exe` spawned by a web server process)

## Related concepts
[[Lateral Movement]] [[Network Scanning]] [[Living Off the Land Binaries (LOLBins)]] [[ARP Poisoning]] [[Internal Reconnaissance]]