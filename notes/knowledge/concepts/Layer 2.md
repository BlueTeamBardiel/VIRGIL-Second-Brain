# Layer 2

## What it is
Think of Layer 2 like the postal system inside a single office building — it doesn't know about the outside world, it just delivers envelopes between desks using employee badge numbers (MAC addresses), not home addresses. Formally, Layer 2 is the **Data Link Layer** of the OSI model, responsible for node-to-node delivery within the same local network segment using MAC addresses and framing.

## Why it matters
ARP Spoofing is a classic Layer 2 attack where an adversary broadcasts fake ARP replies, poisoning the ARP cache of victims to associate the attacker's MAC address with a legitimate IP — enabling a man-in-the-middle position before any Layer 3 encryption even has a chance to protect traffic. This is why switches with **Dynamic ARP Inspection (DAI)** enabled can silently drop malicious ARP packets, stopping the attack at the hardware level.

## Key facts
- Layer 2 operates using **MAC addresses** (48-bit, hardware-burned identifiers), not IP addresses
- **Switches** are the primary Layer 2 devices; they forward frames based on a MAC address table (CAM table)
- **CAM table overflow attacks** flood a switch with fake MACs, forcing it to behave like a hub and broadcast all traffic
- **VLANs** segment Layer 2 broadcast domains — VLAN hopping (via double tagging or switch spoofing) is a common exam scenario
- Layer 2 protocols include **Ethernet, 802.11 (Wi-Fi), PPP, and STP** (Spanning Tree Protocol, which itself can be attacked via rogue root bridge election)

## Related concepts
[[ARP Spoofing]] [[MAC Flooding]] [[VLAN Hopping]] [[Dynamic ARP Inspection]] [[OSI Model]]