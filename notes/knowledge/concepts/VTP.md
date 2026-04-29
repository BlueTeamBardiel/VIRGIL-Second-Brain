# VTP

## What it is
Think of VTP like a gossip network in an office — one person updates the seating chart, and that change propagates to every desk automatically. VLAN Trunking Protocol (VTP) is a Cisco proprietary Layer 2 protocol that synchronizes VLAN configurations across all switches in a VTP domain, so administrators only need to configure VLANs on one device and changes replicate automatically.

## Why it matters
A classic attack scenario: an attacker connects a rogue switch with a higher VTP revision number to a trunk port. Because VTP trusts whoever has the highest revision number, the rogue switch overwrites the entire VLAN database on all switches in the domain — effectively wiping out network segmentation and potentially collapsing traffic isolation between sensitive VLANs. This can expose financial systems to guest network traffic in seconds.

## Key facts
- VTP operates in three modes: **Server** (can create/modify/delete VLANs), **Client** (receives updates, cannot modify), and **Transparent** (forwards VTP advertisements but maintains its own local VLAN database)
- The **revision number** is the attack vector — a switch with revision number 0 will be overwritten by any device advertising revision number 1 or higher
- **VTP version 3** adds password hashing and a "primary server" concept, significantly reducing the rogue-switch attack surface compared to v1/v2
- Mitigation: reset the revision number to 0 before connecting a new switch (change domain name then change back), or use **VTP Transparent mode** on edge ports
- VTP only synchronizes VLAN existence and names — it does **not** configure which ports belong to which VLAN; that remains a per-switch task

## Related concepts
[[VLAN Hopping]] [[Trunk Ports]] [[Network Segmentation]] [[802.1Q]]