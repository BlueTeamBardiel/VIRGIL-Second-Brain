# Ethernet hub

## What it is
Like a megaphone in a crowded room — everyone hears everything, whether it was meant for them or not. An Ethernet hub is a Layer 1 networking device that receives an incoming electrical signal on one port and blindly rebroadcasts it out every other port simultaneously, with no awareness of MAC addresses or destinations.

## Why it matters
Hubs make passive network sniffing trivially easy: an attacker plugging a laptop into any hub port receives every frame traversing that network segment in plaintext. This is why legacy hub-based networks are considered catastrophically insecure for environments handling sensitive data — a single compromised endpoint becomes a full packet capture point for the entire segment, no ARP spoofing required.

## Key facts
- Hubs operate at **OSI Layer 1 (Physical)** — they have zero intelligence about addressing, unlike switches (Layer 2) or routers (Layer 3)
- All devices on a hub share a single **collision domain**, meaning only one device can transmit at a time without causing a collision (CSMA/CD applies)
- A hub creates a **single broadcast domain** — every connected device sees every frame, making Wireshark-based eavesdropping passive and undetectable
- Hubs are largely **obsolete in modern networks**, replaced by switches, but still appear in legacy OT/SCADA environments and are a frequent exam distractor
- Unlike ARP spoofing on a switched network, sniffing on a hub requires **no active attack** — making it harder to detect via IDS anomaly detection

## Related concepts
[[Network Switch]] [[Passive Sniffing]] [[Collision Domain]] [[OSI Model]] [[Promiscuous Mode]]
