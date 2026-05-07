# Dynamic Trunking Protocol and VLAN Trunking Protocol

## What it is

DTP and VTP are two Cisco-proprietary protocols that automate the boring parts of switch configuration — and in doing so, create some of the most infamous footguns in network security.

**DTP (Dynamic Trunking Protocol)** is the matchmaking service between two switch ports. When you plug a cable between two switches, DTP handles the awkward "so… are we a trunk or just a regular access link?" conversation automatically. Think of it like the auto-party-invite system in Helldivers 2 — two players show up on the same planet, and the game tries to figure out if they should team up. Each port has a "preference" (dynamic desirable, dynamic auto, trunk, access, nonegotiate), and the result depends on both sides.

**VTP (VLAN Trunking Protocol)** is shared cloud saves for your VLAN database. Instead of manually creating VLAN 50 on every single switch in your network, you make it once on a VTP Server and the change syncs across the whole domain — like editing a shared Google Doc, where every switch in the domain pulls the latest version. The version number is what decides whose copy is "newest."

## Why it matters

DTP is a security disaster waiting to happen. A port left in `dynamic desirable` or `dynamic auto` will happily negotiate a trunk with anything that asks nicely. Plug a laptop running Yersinia into a wall jack, send a crafted DTP frame, and now you're trunked into every VLAN on the switch. This is the real-world version of glitching out of the map in a speedrun — you weren't supposed to be there, but the system handed you the keys.

VTP is even scarier when misconfigured. Because switches accept any VLAN database with a higher revision number, a single switch dropped in with a bumped revision and an empty VLAN list can wipe VLANs across the entire domain. Connect a "fresh" switch to your network without resetting its VTP state and you can blackhole production in seconds. There's a reason most experienced engineers run VTP in `transparent` mode or `off` and pretend it doesn't exist.

## Key facts

### DTP — port modes and outcomes

DTP frames are sent to multicast MAC `01:00:0c:cc:cc:cc`. The mode you set on each side determines the outcome — like champion select pairings in a MOBA, some combos work, others don't.

- **`access`** — never becomes a trunk, sends no DTP frames. The "I'm AFK, leave me alone" mode.
- **`trunk`** — always a trunk, still sends DTP frames. Forced trunk, but politely announces itself.
- **`nonegotiate`** — forces trunk status and sends zero DTP frames. The silent, antisocial trunk. Required when the neighbor isn't Cisco.
- **`dynamic desirable`** — actively sends DTP proposals trying to form a trunk. The extrovert.
- **`dynamic auto`** — listens for proposals but won't initiate. The introvert who'll hang out if invited.

Outcome combos worth memorizing:

- `dynamic auto` + `dynamic auto` = **Access** (two introverts, nobody talks, no trunk forms)
- `dynamic desirable` + `dynamic auto` = **Trunk**
- `trunk` + `dynamic desirable` = **Trunk**
- `switchport nonegotiate` suppresses DTP frame transmission entirely.
- `switchport mode access` locks the port as access, no DTP.
- `switchport mode trunk` locks the port as trunk, but DTP still gets sent.

**The attack:** any access port left in `dynamic desirable` or `dynamic auto` can be tricked into becoming a trunk by a rogue device. The fix is `switchport mode access` plus `switchport nonegotiate`.

### VTP — the shared VLAN save file

VTP synchronizes VLANs **1 through 4094** across switches in the same VTP domain. Advertisements carry three things: the **configuration revision number**, the **VLAN database**, and the **management domain name**. A switch only updates its database if the incoming revision number is higher than its own — this is the entire mechanic, and the entire vulnerability.

**VLAN storage rules** (this trips people up):

- VLANs **1–1005** → stored in NVRAM (`vlan.dat`).
- VLANs **1006–4094** (extended VLANs) → stored only in **running-config**, not NVRAM, unless you're on VTPv3.

**VTP modes** — like difficulty settings, each one changes what the switch is allowed to do:

- **Server** — receives, sends, stores config in NVRAM. Can create/modify VLANs locally. The DM of the domain.
- **Client** — receives and forwards advertisements, stores config in RAM only. **Cannot create or modify VLANs locally** — it's read-only. Like being a viewer in a Twitch stream.
- **Transparent** — ignores incoming advertisements (doesn't sync), but forwards them through. Stores its own local config in NVRAM. Can create VLANs locally. The "I'll pass the message along but I'm doing my own thing" mode.
- **Off** — neither sends nor receives advertisements, stores config in NVRAM. Total opt-out.

Only **Server** and **Transparent** can create VLANs locally.

### VTP versions

- **VTPv1** — baseline. No extended VLANs. No hidden VLAN digest.
- **VTPv2** — adds Token Ring support and hidden VLAN digest. **Still does not support extended VLANs (1006–4094).** Incompatible with VTPv1 — they cannot coexist in the same domain.
- **VTPv3** — finally supports the extended VLAN range 1006–4094, and adds the `off` mode. The version you actually want if you're running VTP at all.

## Related concepts

[[VLAN Hopping]]
[[802.1Q Trunking]]
[[Native VLAN]]
[[Switch Spoofing Attack]]
[[Yersinia]]
[[Spanning Tree Protocol]]
[[Port Security]]
[[CDP and LLDP]]
[[Private VLANs]]