# Host Discovery

## What it is
Like a postal worker walking a neighborhood and knocking on every door to see which houses are occupied before delivering mail, host discovery is the process of identifying which IP addresses on a network have live, responding machines. It is the reconnaissance phase that precedes deeper scanning, determining the attack surface before probing for open ports or vulnerabilities.

## Why it matters
During a penetration test or a real intrusion, attackers run host discovery first to avoid wasting time scanning dead IP space — a subnet with 254 addresses might only have 12 active hosts. Defenders use the same technique during asset inventory audits to find unauthorized rogue devices that shouldn't be on the network, like an employee's personal Raspberry Pi acting as a backdoor.

## Key facts
- **ICMP Echo Requests (ping)** are the simplest host discovery method, but many firewalls block them, making them unreliable in hardened environments.
- **Nmap's default host discovery** sends ICMP echo, TCP SYN to port 443, TCP ACK to port 80, and an ICMP timestamp request — a multi-protocol approach to improve accuracy.
- **ARP scanning** is the most reliable method on local subnets because ARP cannot be filtered at Layer 3; every live host must respond to resolve IP-to-MAC mappings.
- **TCP SYN ping** (Nmap flag `-PS`) sends a SYN packet — a SYN/ACK or RST response confirms the host is alive without completing the full handshake.
- Performing host discovery **without port scanning** in Nmap uses the `-sn` flag (previously `-sP`), a common exam scenario distinguishing discovery from enumeration.

## Related concepts
[[Port Scanning]] [[Network Enumeration]] [[Passive Reconnaissance]] [[ARP Spoofing]] [[Nmap]]