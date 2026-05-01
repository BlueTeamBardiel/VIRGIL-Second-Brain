# Dynamic & VLAN Trunking Protocol

## What it is
Imagine a hotel intercom system that automatically negotiates which floors each phone can reach — DTP and VTP work the same way between switches. **DTP (Dynamic Trunking Protocol)** auto-negotiates whether a switch port operates as a trunk (carrying multiple VLANs) or an access port, while **VTP (VLAN Trunking Protocol)** propagates VLAN configuration changes across all switches in a management domain automatically.

## Why it matters
An attacker on a standard access port can send crafted DTP frames to convince the switch to negotiate a trunk link — a **VLAN hopping** attack — suddenly gaining access to traffic across all VLANs on that segment. This is why penetration testers specifically look for ports left in `dynamic auto` or `dynamic desirable` mode, as they silently accept trunk negotiation without administrator awareness.

## Key facts
- **DTP modes**: `access` (never trunk), `trunk` (always trunk), `dynamic auto` (passive, accepts trunking), `dynamic desirable` (actively negotiates trunking) — only `access` is safe on user-facing ports
- **VLAN hopping** exploits DTP by double-tagging 802.1Q frames or forcing trunk negotiation; mitigated by disabling DTP with `switchport nonegotiate`
- **VTP revision number vulnerability**: a rogue switch with a higher revision number injected into a VTP domain can overwrite the entire VLAN database on all switches in that domain
- **VTP modes**: Server (read/write), Client (read-only), Transparent (local only, doesn't propagate) — Transparent mode isolates a switch from VTP domain poisoning
- Native VLAN mismatches on trunk ports create a secondary VLAN hopping vector; best practice is to assign native VLAN to an unused VLAN ID

## Related concepts
[[VLAN Segmentation]] [[802.1Q Tagging]] [[Network Access Control]]


<!-- merged from: Dynamic Trunking Protocol.md -->

# Dynamic Trunking Protocol


