# VLAN Trunking Protocol

## What it is

A shared Google Doc where every editor's changes auto-save to everyone else's copy — except the rule is "whoever saved most recently wins, no matter what they wrote." That's VTP in one breath.

VLAN Trunking Protocol is a Cisco-proprietary Layer 2 messaging protocol that automatically synchronizes the VLAN database across every switch in the same VTP domain. Add VLAN 50 on one switch, and seconds later every other switch in the domain knows about VLAN 50 too. The synchronization rides exclusively on trunk links — 802.1Q or the older ISL — and never crosses access ports.

The mechanism that decides "whose VLAN list is the truth" is a single integer: the **configuration revision number**. Whichever switch advertises the highest number wins, and every peer in the domain overwrites its local VLAN database to match. No vote, no quorum, no signature check. Just a number.

## Why it matters

The revision number is also the entire attack surface, and it requires zero credentials to exploit.

Drag a lab switch out of a closet, set its VTP domain to match the production domain, jack the revision number up to something obscene like 2,147,483,647, plug it into a trunk port, and walk away. Every switch in that domain — including the core — wipes its VLAN database and replaces it with whatever this rogue switch is advertising. VLANs disappear. Ports orphan. The network folds in on itself like the bad ending of Watch Dogs where ctOS gets weaponized against the city that built it.

This is why VTP is the protocol most network engineers love to disable on sight. Convenience feature, catastrophic failure mode.

## Key facts

### Modes
- **Server mode** — can create, modify, and delete VLANs; originates and forwards advertisements. The "edit access" tier in the shared doc.
- **Client mode** — receives updates and applies them, but cannot make local VLAN changes. Read-only collaborator that still trusts whatever shows up.
- **Transparent mode** — ignores incoming advertisements for its own VLAN database but still forwards them downstream. The router in your group chat who relays memes without reading them.

### Versions
- **VTP v1 / v2** — supports the standard VLAN range (1–1005) only.
- **VTP v3** — supports extended VLANs (1006–4094) and introduces a **primary server** concept, where only one designated server can actually push updates. This is Cisco's belated attempt to put a lock on the door after a decade of "highest number wins" causing outages.

### Transport
- VTP advertisements travel over **802.1Q** and **ISL** trunk links.
- VTP advertisements **do not** travel over access ports — access ports carry user traffic only, no VTP frames.

### The revision number, again, because this is the whole game
- Every VLAN change on a server bumps the revision number by 1.
- Any switch in the same domain seeing a higher revision number overwrites its own database.
- A switch joining a domain with a higher revision number than the current master can nuke the entire domain's VLAN config. This is not a bug or an edge case — it is documented, intended behavior.

### Mitigations
- Set edge switches to **VTP Transparent mode** so they never accept incoming VLAN updates from rogue gear.
- **Disable VTP entirely** (`vtp mode off` on supported platforms) and manage VLANs manually or via automation. This is the cleanest answer for most modern networks.
- Treat any switch coming off the shelf or out of a lab as radioactive — wipe the VTP domain and reset the revision number to 0 before it touches a trunk.

## Related concepts
[[802.1Q]]
[[ISL]]
[[DTP]]
[[VLAN]]
[[Trunk Links]]
[[Switch Spoofing Attacks]]
[[Native VLAN]]
[[Cisco Proprietary Protocols]]