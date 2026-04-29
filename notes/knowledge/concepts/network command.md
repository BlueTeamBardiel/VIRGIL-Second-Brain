# network command

## What it is
Like a dispatcher radioing instructions to field agents, network commands are the specific syntax-driven instructions used to configure, query, and troubleshoot network infrastructure from a command-line interface. They allow administrators — and attackers — to inspect connections, map topology, and manipulate routing behavior directly from a terminal.

## Why it matters
During a post-breach investigation, a SOC analyst running `netstat -ano` on a compromised Windows host discovered an established connection to an unknown external IP on port 4444 — a classic Metasploit reverse shell indicator. Without fluency in network commands, the attacker's persistence mechanism would have gone undetected during triage.

## Key facts
- **`netstat -ano`** displays active TCP/UDP connections with associated process IDs (PIDs), critical for identifying unauthorized outbound connections
- **`nslookup` / `dig`** query DNS records; attackers abuse these for DNS reconnaissance and defenders use them to detect DNS hijacking
- **`tracert` (Windows) / `traceroute` (Linux)** maps the hop-by-hop path to a destination, useful for detecting BGP hijacking or unexpected routing changes
- **`arp -a`** displays the local ARP cache; poisoned entries (duplicate MACs for different IPs) are a red flag for ARP spoofing / Man-in-the-Middle attacks
- **`ipconfig /all` (Windows) / `ifconfig` / `ip a` (Linux)** reveal interface configurations including MAC addresses, DHCP lease info, and DNS server assignments — all useful during incident triage

## Related concepts
[[ARP Poisoning]] [[DNS Reconnaissance]] [[Port Scanning]] [[Netstat]] [[Network Enumeration]]