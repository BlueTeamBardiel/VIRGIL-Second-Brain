# LAN

## What it is
Think of a LAN like the wiring inside a single office building — everything connected shares the same hallway, so a shout is heard by everyone on that floor. A Local Area Network (LAN) is a collection of devices connected within a confined geographic area (home, office, campus) sharing the same network infrastructure, typically via Ethernet or Wi-Fi. Traffic within a LAN stays local and doesn't need to traverse the public internet.

## Why it matters
An attacker who gains a foothold on any single device inside a LAN can immediately launch ARP poisoning attacks to intercept traffic between other hosts — something impossible from the outside. This is why network segmentation and VLANs exist: to break a flat LAN into isolated zones so a compromised workstation can't sniff traffic from the finance server sitting twenty feet away.

## Key facts
- **Default trust problem:** Devices on the same LAN often receive implicit trust, making lateral movement trivially easy without micro-segmentation controls.
- **Broadcast domain:** A traditional LAN is a single broadcast domain — ARP requests, DHCP discovery, and other broadcasts reach every device, enabling reconnaissance.
- **Speed:** LANs typically operate at 100 Mbps, 1 Gbps, or 10 Gbps — far faster than WAN links, making internal data exfiltration extremely fast once access is gained.
- **802.3 (Ethernet) and 802.11 (Wi-Fi)** are the two dominant IEEE standards governing LAN connectivity.
- **VLAN segmentation** (IEEE 802.1Q) is the primary defense for dividing a physical LAN into multiple logical broadcast domains, containing breach impact.

## Related concepts
[[VLAN]] [[ARP Poisoning]] [[Network Segmentation]] [[Broadcast Domain]] [[Lateral Movement]]