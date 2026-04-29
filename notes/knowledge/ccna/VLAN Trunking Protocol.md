# VLAN Trunking Protocol

## What it is
Think of VTP like a franchise headquarters that automatically pushes menu updates to every restaurant location — one change propagates everywhere instantly. VLAN Trunking Protocol (VTP) is a Cisco proprietary Layer 2 messaging protocol that automatically synchronizes VLAN configuration (additions, deletions, renames) across all switches in a VTP domain. It operates over trunk links and uses a revision number system to determine which switch holds the authoritative configuration.

## Why it matters
An attacker with physical or logical access to a trunk port can introduce a rogue switch advertising a higher VTP revision number, instantly overwriting the entire network's VLAN database — effectively erasing network segmentation and potentially collapsing production traffic. This attack requires no credentials; a higher revision number alone triggers synchronization. Defenders mitigate this by setting edge switches to **VTP Transparent mode** or disabling VTP entirely in favor of manual VLAN configuration.

## Key facts
- VTP operates in three modes: **Server** (can create/modify VLANs), **Client** (receives updates, cannot modify), and **Transparent** (forwards VTP advertisements but ignores them locally)
- The **revision number** is the critical attack vector — any switch advertising a higher revision number in the same VTP domain will overwrite peers' VLAN databases
- VTP version 3 adds support for extended VLANs (1006–4094) and introduces a **primary server** concept, reducing rogue-switch risk
- VTP advertisements travel over **802.1Q** or **ISL trunk links** only — not access ports
- A misconfigured switch added to a production network has caused real-world outages by resetting VLAN databases to revision zero, wiping all VLAN definitions

## Related concepts
[[VLAN Hopping]] [[802.1Q Trunking]] [[Network Segmentation]]