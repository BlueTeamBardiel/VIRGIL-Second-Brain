# 11. VLANs

## What it is

A single switch running VLANs is like a Discord server with multiple channels — physically it's one server, but #general and #raids are completely separate conversations. People in #general can't hear what's said in #raids unless someone (a moderator with cross-channel powers) explicitly bridges them.

A **VLAN** (Virtual LAN) takes one physical switch and slices it into multiple logical switches. Ports assigned to VLAN 10 behave as if they live on an entirely different switch from ports in VLAN 20, even though they're millimeters apart on the same chassis.

This is **Layer 2 segmentation** — it works on MAC addresses and frames. It's the partner to **subnetting**, which is Layer 3 segmentation working on IP addresses. The convention is a clean 1:1 mapping: one VLAN = one subnet. VLAN 10 might be 10.0.10.0/24, VLAN 20 might be 10.0.20.0/24.

The core mechanic: every VLAN is its own **broadcast domain**. Broadcasts (ARP requests, for example) flooded inside VLAN 10 never escape into VLAN 20. Frames stay inside their VLAN unless a router intervenes.

## Why it matters

Without VLANs, every device plugged into a switch shares one giant broadcast domain — the network equivalent of every player in Among Us being forced into one open mic, including the impostors. Add 200 devices and ARP storms drown the whole thing.

VLANs let you:

- **Separate trust zones** on the same hardware — guest Wi-Fi on VLAN 50 can't sniff finance traffic on VLAN 10, even though both connect to the same switch.
- **Shrink broadcast domains** so flooding stays local.
- **Group users logically** instead of physically — Beatrice in marketing and Dante in marketing can be on opposite sides of the building and still share a VLAN.

The catch: VLANs isolate by default. If VLAN 10 needs to talk to VLAN 20, you need a router (or Layer 3 switch) — this is **inter-VLAN routing**.

## Key facts

### VLAN ID ranges (12-bit field, 0–4095)

Like loot rarity tiers in a looter shooter — some IDs are usable, some are locked by the system.

- **0** — reserved, can't use it
- **1–1001** — normal usable range (VLAN 1 is the default everything-lives-here VLAN)
- **1002–1005** — reserved for legacy Token Ring / FDDI ghosts
- **1006–4094** — extended usable range
- **4095** — reserved
- **802.1Q max** — 4096 total VLANs because the VID field is 12 bits

### Access ports vs Trunk ports

Two flavors of switchport, like the difference between a single-class character and a multiclass build.

- **Access port** — belongs to exactly one VLAN, carries **untagged** frames. The endpoint (your laptop, a printer) has no idea VLANs exist.
- **Trunk port** — carries traffic for many VLANs simultaneously by **tagging** each frame with its VLAN ID. Used between switches, or switch-to-router.

### 802.1Q tagging

The tag is the loadout sticker slapped on each frame so the receiving switch knows which VLAN it belongs to.

- **IEEE 802.1Q** — the standard tagging protocol. Open standard, universal.
- **Tag size** — 4 bytes inserted into the Ethernet frame
- **TPID** — 0x8100, signals "this is a tagged frame"
- **TCI** — contains PCP (priority, 3 bits), DEI (drop eligible, 1 bit), and VID (12-bit VLAN ID)
- **ISL** — Cisco-proprietary alternative, deprecated. Don't use it.

### Native VLAN

The one VLAN on a trunk that gets to skip the dress code — its frames travel **untagged**.

- Default native VLAN is **VLAN 1**
- Native VLAN must **match on both ends** of the trunk, or you get VLAN hopping risk and frames landing in the wrong VLAN
- Used for legacy traffic and protocols like CDP/DTP that run before tagging exists

### Inter-VLAN routing — Router on a Stick (ROAS)

One physical link doing the job of many — like Link in Tears of the Kingdom Fuse-ing several weapons into one stick. The router has one cable, but logically presents one interface per VLAN via **subinterfaces**.

- Physical interface has **no IP address** — it's just the carrier
- Subinterface naming: `GigabitEthernet0/0.10` for VLAN 10
- All subinterfaces share the **same MAC address** (it's the same physical NIC)
- `encapsulation dot1q 10` tags traffic for VLAN 10 on that subinterface
- `encapsulation dot1q 10 native` marks VLAN 10 as the native (untagged) VLAN

### Switch configuration commands

**Access port setup:**
- `switchport mode access` — lock the port to access mode
- `switchport access vlan 10` — put it in VLAN 10
- Assigning a port to a VLAN that doesn't exist yet **auto-creates** the VLAN

**Trunk port setup:**
- `switchport mode trunk` — configure as trunk
- `switchport trunk encapsulation dot1q` — use 802.1Q (only needed on switches that also support ISL)
- `switchport trunk native vlan 99` — change native VLAN (best practice: not VLAN 1)

**Allowed VLAN list on a trunk** — like a guest list at the door:
- `switchport trunk allowed vlan 10,20,30` — exact list
- `switchport trunk allowed vlan add 40` — add to current list
- `switchport trunk allowed vlan remove 20` — remove from current list
- `switchport trunk allowed vlan all` — let everyone in (1–4094)
- `switchport trunk allowed vlan none` — block everyone

### Verification commands

- `show vlan brief` — VLAN database and which access ports belong to which VLAN. Trunk ports don't show up here.
- `show interfaces trunk` — verifies trunk status, native VLAN, allowed VLANs, and which VLANs are actively forwarding
- `show mac address-table` — learned MACs with their VLAN association, so you can confirm a device landed in the right VLAN

## Related concepts

[[Subnetting]] · [[Broadcast Domain]] · [[Spanning Tree Protocol]] · [[DTP and VTP]] · [[Inter-VLAN Routing]] · [[Layer 3 Switching]] · [[Voice VLAN]] · [[Private VLANs]] · [[VLAN Hopping Attack]] · [[802.1Q]]