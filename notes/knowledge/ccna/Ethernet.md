# Ethernet

## What it is
Think of Ethernet like a neighborhood street where everyone can hear cars passing — any device on the same segment can see traffic meant for others. Precisely, Ethernet is a Layer 2 (Data Link) wired networking standard that uses MAC addresses to deliver frames between devices on the same local network segment. It governs how data is packaged, addressed, and transmitted over physical media like twisted-pair or fiber cable.

## Why it matters
On a hub-based or misconfigured switched network, an attacker running Wireshark in **promiscuous mode** can perform passive sniffing, capturing plaintext credentials from protocols like Telnet or FTP traversing the same segment. Even on modern switches, ARP poisoning attacks can redirect traffic through the attacker's machine, turning a "private" switched network back into that open neighborhood street.

## Key facts
- Ethernet frames contain a **destination MAC**, **source MAC**, EtherType field, payload (46–1500 bytes), and a CRC for error checking
- Standard Ethernet operates at Layer 2; **switches** use MAC address tables to forward frames — unlike hubs, which broadcast to all ports
- Maximum Transmission Unit (MTU) for standard Ethernet is **1500 bytes**; jumbo frames extend this to ~9000 bytes
- **802.1Q VLAN tagging** adds a 4-byte tag to Ethernet frames, enabling logical network segmentation — critical for isolating sensitive traffic
- VLAN hopping attacks (switch spoofing, double tagging) exploit Ethernet trunk negotiation to access VLANs an attacker shouldn't reach

## Related concepts
[[ARP Poisoning]] [[MAC Flooding]] [[VLAN]] [[Network Sniffing]] [[Switch Security]]