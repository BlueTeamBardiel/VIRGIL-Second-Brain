# VLANs: Segmenting LANs at Layer 2

## What it is

A switch without VLANs is like a public lobby in *Escape from Tarkov* — every player in the queue can hear every other player, regardless of which raid they're loading into. One person yells "anyone got a Bitcoin?" and the whole lobby hears it. That's a broadcast domain: a Layer 2 switch floods broadcast frames (destination MAC `ffff.ffff.ffff`) out every port except the one they came in on. Doesn't matter what subnet you assigned the host — Layer 2 doesn't care about your IP plan.

VLANs (Virtual LANs) carve that single noisy lobby into separate instanced raids. One physical switch becomes multiple virtual switches, each with its own isolated broadcast domain. Hosts in VLAN 10 cannot hear broadcasts from VLAN 20, even if they're plugged into ports right next to each other.

A common beginner trap: "I'll just put them in different subnets, that'll separate them." No. Subnetting is a Layer 3 concept. Broadcasts at Layer 2 don't read IP headers — they flood everywhere on the same switch fabric until a VLAN boundary stops them.

## Why it matters

Broadcast traffic scales like Among Us emergency meetings — fine with 10 crewmates, catastrophic with 500. Without VLANs, every ARP request, every DHCP discover, every chatty IoT device floods every port. Performance tanks, and worse, every host can attempt to talk to every other host at Layer 2, which is a security nightmare.

VLANs give you the segmentation of buying separate physical switches without actually buying separate physical switches. Finance traffic, guest WiFi, VoIP phones, and printers can all share the same hardware while staying in their own lanes — like party chat channels in Call of Duty: people in the Domination party can't hear people in the Search & Destroy party even though they're on the same servers.

But isolation has a cost: hosts in different VLANs **cannot** talk to each other without a Layer 3 device stepping in. VLANs separate networks completely; routing is what stitches them back together when you want it.

## Key facts

### VLAN ranges and storage
- **VLAN 1** is the default, created automatically. Every port lives here until you say otherwise. Treat it like the spawn zone — functional, but you don't want sensitive stuff parked there.
- **Normal range: 2–1001** — stored in `vlan.dat` in flash memory. Persists across reboots.
- **Reserved: 1002–1005** — locked for FDDI and Token Ring, protocols so old they're basically lore items.
- **Extended range: 1006–4094** — stored only in running-config. Forget to `copy run start` and they're gone like an unsaved Elden Ring run before a boss fight.

### Access vs. trunk ports
- **Access ports** belong to exactly one VLAN. Frames leaving an access port have no VLAN tag — the switch strips it. Hosts never see 802.1Q headers; your laptop has no idea VLANs even exist.
- **Trunk ports** carry traffic for multiple VLANs simultaneously, like a server backbone in an MMO carrying chat from every zone at once. To keep VLANs from blurring together, the switch tags every frame on the way out.

### 802.1Q tagging
The IEEE 802.1Q standard inserts a 4-byte tag between the source MAC and the EtherType — like a Discord server label slapped onto every message so the receiving switch knows which channel it belongs to.

- **TPID (Tag Protocol Identifier):** 16 bits, value `0x8100`. The "hey, I'm a VLAN tag" marker.
- **Priority (PCP):** 3 bits, values 0–7. Class of Service for QoS — VoIP gets priority 5, your torrent traffic gets 0.
- **CFI:** 1 bit, almost always 0. Vestigial Token Ring compatibility nobody touches.
- **VLAN ID:** 12 bits → 0–4095 raw, but 1–4094 usable.

### The native VLAN
- One VLAN on a trunk travels **untagged**. That's the native VLAN.
- Default native VLAN is 1.
- Any untagged frame arriving on a trunk is assumed to belong to the native VLAN.
- **Security best practice:** change the native VLAN to an unused, unassigned ID. Leaving it as VLAN 1 is the networking equivalent of using "password" as your password — it opens the door to VLAN hopping attacks where an attacker double-tags frames to jump VLANs.

### Inter-VLAN routing options

**Router-on-a-Stick (ROAS)**
One physical router interface, multiple sub-interfaces (one per VLAN), connected to the switch via a single trunk link. Like running an entire Helldivers 2 squad's traffic through one Pelican dropship — it works, but everything bottlenecks through that single link, and the router's CPU handles every packet in software. Fine for small setups, painful at scale.

**Multilayer Switch (Layer 3 switch)**
Switching and routing fused into the same box. Instead of sub-interfaces, you create **Switched Virtual Interfaces** (`interface vlan 10`) that act as default gateways for hosts in that VLAN. Routing happens in hardware via an ASIC — dedicated silicon, not general-purpose CPU. This is the difference between software-rendered graphics and a dedicated GPU: orders of magnitude faster, scales to enterprise traffic, and no single trunk bottleneck.

## Related concepts
[[802.1Q Trunking]]
[[VLAN Hopping Attacks]]
[[DTP and VTP]]
[[Inter-VLAN Routing]]
[[Switched Virtual Interfaces (SVI)]]
[[Spanning Tree Protocol]]
[[Broadcast Domains vs Collision Domains]]
[[Private VLANs]]
[[Voice VLANs]]
[[Access Control Lists]]