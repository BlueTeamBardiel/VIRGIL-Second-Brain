# Networking

## What it is
Like a postal system where every house has an address, every device needs a unique identifier and a set of rules for how letters get routed, opened, and read. Networking is the interconnection of computing devices using protocols that govern how data is addressed, transmitted, routed, and received across physical or wireless media. It forms the foundational layer upon which every security control — and every attack — operates.

## Why it matters
In a classic lateral movement attack, a threat actor who compromises a single workstation uses network protocols like SMB and ARP to discover other hosts, move credentials, and pivot deeper into the environment. Without understanding subnetting, port behavior, and protocol communication patterns, a defender cannot distinguish malicious east-west traffic from legitimate business traffic — making detection nearly impossible.

## Key facts
- The OSI model has 7 layers; most attacks and defenses map to Layer 3 (Network/IP), Layer 4 (Transport/TCP-UDP), and Layer 7 (Application)
- TCP uses a 3-way handshake (SYN → SYN-ACK → ACK); a half-open flood of SYNs without completing the handshake is a SYN flood DoS attack
- IPv4 addresses are 32-bit; IPv6 are 128-bit — security tools and firewall rules must account for both or IPv6 becomes a blind spot
- CIDR notation (e.g., /24) defines network boundaries; improper subnetting can expose internal hosts to unnecessary network paths
- Ports 0–1023 are well-known (e.g., 443=HTTPS, 22=SSH, 53=DNS); unexpected open ports on a host are a key indicator of compromise or misconfiguration

## Related concepts
[[OSI Model]] [[TCP/IP Protocol Suite]] [[Network Segmentation]] [[Firewall]] [[Port Scanning]]