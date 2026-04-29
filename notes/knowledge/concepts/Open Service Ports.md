# Open Service Ports

## What it is
Think of a building with 65,535 numbered doors — every open door is a service waiting to accept visitors, but each unlocked door is also an opportunity for an uninvited guest. A port is a logical communication endpoint on a networked device; when a service is actively listening on that port, it is considered "open" and will respond to incoming connection requests via TCP or UDP.

## Why it matters
During the 2017 WannaCry ransomware outbreak, attackers exploited SMB services running on TCP port 445 left open and exposed to the internet — a configuration that should never exist on production networks. A single misconfigured firewall rule allowing external access to that port enabled lateral movement across hundreds of thousands of machines globally. Proper port management and network segmentation would have contained or prevented the spread entirely.

## Key facts
- **TCP port scanning** uses SYN packets to probe responsiveness; an open port replies SYN-ACK, a closed port replies RST, and a filtered port drops the packet silently
- **Well-known ports** are 0–1023 (e.g., HTTP:80, HTTPS:443, SSH:22, RDP:3389, DNS:53); memorizing these is essential for Security+ and CySA+
- **Nmap** is the industry-standard tool for open port discovery; `nmap -sS -p-` performs a full stealth SYN scan across all 65,535 ports
- **Attack surface reduction** means closing or blocking every port not explicitly required — this is the principle of least functionality applied to networking
- **RDP (port 3389)** exposed to the internet is one of the most commonly exploited misconfigurations found in breach investigations; it should be restricted behind a VPN or MFA gateway

## Related concepts
[[Network Scanning]] [[Attack Surface]] [[Firewall Rules]] [[Nmap]] [[Principle of Least Functionality]]