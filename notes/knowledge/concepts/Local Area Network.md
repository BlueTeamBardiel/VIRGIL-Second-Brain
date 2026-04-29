# Local Area Network

## What it is
Think of a LAN like the internal plumbing of a single building — water flows freely between rooms, but you need to leave the building to reach a neighbor's pipes. A Local Area Network is a privately scoped network connecting devices within a limited geographic area (a home, office, or campus) using Ethernet or Wi-Fi, typically governed by a single administrative authority. All devices share a common IP address range and can communicate directly without routing through an external gateway.

## Why it matters
In 2017, the NotPetya malware devastated corporate networks by exploiting lateral movement within LANs — once inside a single endpoint, it used SMB protocol vulnerabilities (EternalBlue) to propagate to every reachable host on the same network segment within minutes. This demonstrates why LAN segmentation via VLANs and internal firewalls is a critical defense-in-depth control, not just a perimeter problem.

## Key facts
- LANs typically operate within RFC 1918 private address space: 10.0.0.0/8, 172.16.0.0/12, and 192.168.0.0/16
- ARP (Address Resolution Protocol) operates exclusively at the LAN layer, making it a prime target for ARP poisoning/spoofing attacks
- Broadcast domains define LAN boundaries — switches forward broadcasts to all ports; routers do not, which is why VLANs can logically subdivide a physical LAN
- 802.1Q VLAN tagging is the standard mechanism to segment a LAN without deploying separate physical infrastructure
- Network sniffing tools like Wireshark can capture all LAN traffic on a hub or when an attacker has compromised a switch via ARP poisoning — encryption (TLS) remains essential even inside trusted LANs

## Related concepts
[[VLAN]] [[ARP Poisoning]] [[Network Segmentation]] [[SMB Protocol]] [[Broadcast Domain]]