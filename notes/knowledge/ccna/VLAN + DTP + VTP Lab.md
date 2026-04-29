# VLAN + DTP + VTP Lab

## What it is
Think of VLANs as color-coded hallways in an office building where departments can't wander into each other's corridors — DTP is the contractor who automatically agrees to connect hallways without asking permission, and VTP is the manager who broadcasts the floor plan to every switch on the network. Precisely: VLANs segment Layer 2 broadcast domains; DTP (Dynamic Trunking Protocol) auto-negotiates trunk links between switches; VTP (VLAN Trunking Protocol) propagates VLAN configuration across a switched domain from a central server switch.

## Why it matters
An attacker on a guest network can craft DTP frames to negotiate a trunk link with an adjacent switch — a **VLAN hopping** attack — instantly gaining access to traffic on every VLAN the trunk carries. VTP is equally dangerous: injecting a spoofed VTP advertisement with a higher revision number can wipe an entire network's VLAN database, causing a widespread outage used as cover for other attacks.

## Key facts
- **DTP should be disabled** on all access ports with `switchport nonegotiate` — leaving it enabled is the prerequisite for VLAN hopping via switch spoofing.
- **VTP revision number exploitation**: A rogue switch with a higher VTP revision number will overwrite the legitimate VLAN database on all VTP clients in the domain.
- **VTP modes**: Server (creates/modifies VLANs), Client (receives updates), Transparent (forwards but ignores updates) — Transparent mode is the safest for security-sensitive environments.
- **Double-tagging attack** exploits the native VLAN on trunk ports; always change the native VLAN away from VLAN 1 and tag it explicitly.
- VLAN 1 is the default management VLAN and should be **pruned from all trunks** and never used for user or management traffic.

## Related concepts
[[VLAN Hopping]] [[Network Segmentation]] [[Trunk Port Security]]