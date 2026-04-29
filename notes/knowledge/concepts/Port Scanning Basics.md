# Port Scanning Basics

## What it is
Like a burglar walking down a street trying every door and window to see which ones open, port scanning sends packets to a range of TCP/UDP ports on a target host to discover which services are listening and potentially accessible. It is a reconnaissance technique used to map the attack surface of a system by identifying open, closed, or filtered ports.

## Why it matters
Before the 2017 Equifax breach, attackers performed reconnaissance to identify exposed services — open ports running unpatched software were the entry point. Defenders use port scanning proactively (via tools like Nmap) to find and close unnecessary open ports before attackers do, a practice called attack surface reduction.

## Key facts
- **SYN scan (half-open scan)** sends a SYN packet and listens for SYN-ACK without completing the handshake — stealthier and faster than a full TCP connect scan
- **Port states**: *Open* (service listening), *Closed* (no service, host responds), *Filtered* (firewall drops packets, no response)
- **Well-known ports** are 0–1023 (e.g., 22=SSH, 80=HTTP, 443=HTTPS, 3389=RDP); registered ports are 1024–49151
- **Nmap** is the industry-standard scanning tool; the `-sS` flag performs a SYN scan, `-sU` targets UDP ports
- **UDP scanning** is significantly slower than TCP scanning because closed UDP ports may not respond at all, requiring timeout-based detection

## Related concepts
[[TCP Three-Way Handshake]] [[Firewall Rule Configuration]] [[Network Reconnaissance]] [[Service Enumeration]] [[Nmap Usage]]