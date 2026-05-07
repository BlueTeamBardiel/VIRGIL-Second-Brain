# VLAN + DTP + VTP Lab

## What it is

A switched LAN out of the box is one giant Discord server where every message pings @everyone. VLANs are how you split that chaos into separate channels — sales-chat, eng-chat, finance-chat — so broadcast traffic only reaches the people who belong there. Same physical switch, separate Layer 2 broadcast domains.

Once you have VLANs, two more protocols show up to "help":

- **DTP (Dynamic Trunking Protocol)** is Cisco's auto-matchmaking system for trunk links between switches. Two switch ports negotiate, "want to carry all VLANs between us?" and if both agree, a trunk forms. It's the Tinder of switch ports — and like Tinder, leaving it on by default is how you end up matched with strangers.
- **VTP (VLAN Trunking Protocol)** is the shared Google Doc for your VLAN database. One switch is the "owner" (server), the rest are "viewers" (clients) that auto-sync whenever the doc changes. Convenient, until someone with edit access gets compromised — or worse, a newer doc shows up and silently overwrites the old one.

## Why it matters

VLANs are a security boundary. The moment that boundary leaks, the whole segmentation story falls apart — like Among Us when someone vents into a room they shouldn't be in. DTP and VTP, left at defaults, are exactly how attackers vent.

Two specific attacks make this real:

- **VLAN hopping via DTP**: an attacker plugs a laptop into an access port, sends crafted DTP frames pretending to be a switch, and negotiates a trunk. Suddenly their laptop sees every VLAN on that switch. Game over.
- **VTP revision number hijack**: any rogue switch with a higher VTP revision number can overwrite the VLAN database across the whole domain. Plug in a switch you found in a closet, accidentally wipe every VLAN in production. This is the networking equivalent of an Elden Ring invader showing up with a save file that overwrites yours.

## Key facts

### VLANs

- A VLAN is a Layer 2 broadcast domain. Hosts in different VLANs can't talk without a router or L3 switch — same building, different dimensions, like the Upside Down.
- **VLAN 1 is the default management VLAN** and the one every unconfigured port lands in. Treat it like the lobby of an MMO — public, crowded, and not where you do anything sensitive.
- VLAN 1 should never carry user or management traffic, and should be **pruned from all trunks** so it doesn't traverse switch-to-switch links.

### DTP (Dynamic Trunking Protocol)

- DTP auto-negotiates trunk links. Modes pair up: `dynamic auto`, `dynamic desirable`, `trunk`, `access`. If either side is `desirable` and the other isn't `access`, you get a trunk.
- **VLAN hopping**: attacker sends spoofed DTP frames from a host port, switch happily forms a trunk, attacker now sees all VLANs. It's basically speedrunning past the segmentation.
- **Mitigation**: `switchport nonegotiate` on every access port. This kills DTP frames entirely. Pair with `switchport mode access` so the port can't be coerced into trunking.

### Native VLAN and Double-Tagging

- The **native VLAN** on a trunk is the one VLAN whose frames go untagged. By default it's VLAN 1 — same VLAN as every default access port. That's the bug.
- **Double-tagging attack**: attacker sends a frame with two 802.1Q tags. The first switch strips the outer tag (matching the native VLAN), then forwards the still-tagged frame to the next switch, which honors the inner tag and delivers it to a VLAN the attacker shouldn't reach. One-way, but enough for recon or a poisoned payload.
- **Fix #1**: change the native VLAN away from VLAN 1 to something unused (e.g., VLAN 999, the "do not enter" room).
- **Fix #2**: explicitly tag the native VLAN with `vlan dot1q tag native`. No frame on the trunk is ever untagged again, double-tagging dies.

### VTP (VLAN Trunking Protocol) Modes

- **Server mode**: can create, modify, and delete VLANs. Changes propagate. The DM of the campaign — what they say, goes.
- **Client mode**: receives and applies updates from servers. Cannot create VLANs locally. The players — they follow the DM's world.
- **Transparent mode**: ignores incoming VTP updates for its own database, but forwards them along the trunk. Maintains its own local VLAN config. The lore-keeping NPC who lets messages pass through but doesn't care what they say.
- **Transparent is the safest mode** for any environment where you care about security, because it's immune to revision-number attacks.

### VTP Revision Number Exploit

- Every VLAN database change increments the revision number. Higher revision wins — automatically, no questions asked.
- A rogue switch (or a returned-from-the-lab switch nobody wiped) with a higher revision number plugged into the domain will **overwrite the VLAN database on every VTP client**. Your production VLANs vanish.
- This is why "transparent everywhere" is a common hardening choice. No revision contest if nobody's playing.

### Hardening Checklist (the actual lab takeaway)

- `switchport mode access` + `switchport nonegotiate` on every user-facing port.
- Move native VLAN off VLAN 1, tag it explicitly.
- Prune VLAN 1 from trunks. Don't use it for management — use a dedicated management VLAN.
- Set unused ports to a black-hole VLAN and shut them down. Empty ports are loaded guns.
- Run VTP transparent mode (or VTPv3 with proper auth) unless you have a strong operational reason otherwise.

## Related concepts

[[802.1Q Tagging]]
[[Trunk Ports vs Access Ports]]
[[Inter-VLAN Routing]]
[[Switch Port Security]]
[[Spanning Tree Protocol]]
[[Private VLANs]]
[[VTPv3]]
[[Yersinia]]
[[Layer 2 Attacks]]
[[Network Segmentation]]