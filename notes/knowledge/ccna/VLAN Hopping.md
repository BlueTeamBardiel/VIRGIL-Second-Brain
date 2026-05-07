# VLAN hopping

## What it is
Imagine a building where different departments have separate locked floors, but a clever visitor tricks the elevator into thinking they're a floor manager — suddenly they can reach floors they were never authorized to enter. VLAN hopping is exactly this: an attacker on one VLAN manipulates switch behavior to send traffic into a different, logically isolated VLAN without authorization. It exploits two mechanisms — switch spoofing and double tagging — to bypass the network segmentation VLANs are designed to enforce.

## Why it matters
In a segmented enterprise network, the guest Wi-Fi VLAN and the internal finance VLAN are kept separate for obvious reasons. An attacker on the guest network who successfully executes a double-tagging VLAN hop could inject frames directly into the finance VLAN, bypassing firewall rules that assume inter-VLAN traffic travels through a router. This effectively nullifies segmentation as a security control without the attacker ever touching a routing device.

## Key facts
- **Switch spoofing**: The attacker configures their NIC to negotiate a trunk link (using DTP — Dynamic Trunking Protocol), causing the switch to treat their port as a trunk and forward all VLAN traffic to them.
- **Double tagging**: The attacker sends a frame with two 802.1Q headers; the outer tag matches the attacker's native VLAN (stripped by the first switch), and the inner tag routes the frame into the target VLAN on the next switch.
- **Double tagging is one-way only** — responses cannot return to the attacker via the same method, limiting it to injection attacks (e.g., UDP floods, DoS).
- **Mitigation**: Disable DTP on all access ports (`switchport nonegotiate`), explicitly set the native VLAN to an unused VLAN ID, and never assign user ports to VLAN 1.
- Native VLAN mismatches between switches are the root enabler of double-tagging attacks.

## Related concepts
[[802.1Q Trunking]] [[Network Segmentation]] [[Spanning Tree Protocol]]