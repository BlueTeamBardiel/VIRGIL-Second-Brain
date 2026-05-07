# Cisco Discovery Protocol and Link Layer Discovery Protocol

## What it is

When you join a Discord server for the first time, the member list immediately shows you who's online, what game they're playing, and their status — without you asking anyone. CDP and LLDP are that member list, but for network gear. Every device on the link constantly broadcasts a little "hey, I'm here, here's what I am" packet, and every neighbor caches it.

**CDP (Cisco Discovery Protocol)** is the Cisco-proprietary version — think of it like the PlayStation Network party system: works flawlessly between PlayStations, doesn't talk to Xbox. It runs at Layer 2, so it doesn't care about IP addressing at all; it just shouts onto the wire.

**LLDP (Link Layer Discovery Protocol)** is the open IEEE 802.1AB standard — the cross-platform equivalent. It's what lets a Juniper switch, an Aruba access point, and a Cisco router all see each other on the same map. Same idea, vendor-neutral.

Both protocols send periodic multicast frames out every active interface. Neighbors listen, build a table, and you get a free topology map without ever logging into another device.

## Why it matters

Walking into an unlabeled wiring closet without CDP/LLDP is like loading into Escape from Tarkov with no map and no compass — you have ports, you have cables, and you have no idea what's on the other end. Run `show cdp neighbors` and suddenly you have the offline map: every connected switch, router, IP phone, and which port goes where.

Operationally this is huge for:
- **Troubleshooting**: confirm which switchport that misbehaving phone is plugged into without crawling under a desk.
- **Documentation**: auto-generate topology diagrams.
- **VoIP**: LLDP-MED tells an IP phone which VLAN to use and how much PoE it can draw — the phone literally boots up and negotiates its own config.

The flip side: these protocols are leaky by design. A CDP packet on an untrusted port hands an attacker your platform, IOS version, native VLAN, and management IP on a silver platter. It's the equivalent of your character in Cyberpunk 2077 broadcasting their full cyberware loadout to every netrunner in range. Disable it on edge ports facing users or the internet.

## Key facts

### CDP — the Cisco-only party chat

- **Layer 2, Cisco proprietary.** No IP needed; it rides directly on Ethernet.
- **Multicast MAC**: `01:00:0c:cc:cc:cc` — the "Cisco family" address.
- **Enabled by default** on most Cisco IOS gear. It's the chatty roommate who introduces themselves to everyone.
- **Timer**: advertisement every **60 seconds**.
- **Holdtime**: **180 seconds** before a silent neighbor is purged from the cache (3x the timer — miss three pings and you're out).
- **Advertised info**: device ID, port ID, capabilities, platform, software version, IP addresses, duplex mode, **VTP domain**. The VTP domain bit is unique to CDP — LLDP doesn't carry it.
- **Works on**: Cisco routers, switches, IP phones, printers.
- **Capability codes** in `show cdp neighbors`: R = Router, B = Bridge, S = Switch, H = Host, I = IP Phone. Like class icons on a scoreboard.
- **Commands**:
  - `cdp run` — global on/off (configured in global config).
  - `cdp enable` / `no cdp enable` — per-interface toggle.
  - `cdp timer <seconds>` — change advertisement interval.
  - `cdp holdtime <seconds>` — change cache lifespan.
  - `show cdp neighbors` — the roster.
  - `show cdp neighbors detail` — the full character sheet (adds IP addresses and IOS version).

### LLDP — the cross-platform standard

- **IEEE 802.1AB**, vendor-neutral. Works between any compliant gear.
- **Multicast MAC**: `01:80:c2:00:00:0e` — part of the IEEE bridge-reserved range.
- **Disabled by default** on most Cisco devices. You have to invite it to the party.
- **Timer**: advertisement every **30 seconds** (twice as chatty as CDP).
- **Holdtime**: **120 seconds** cache lifetime (4x the timer).
- **Reinit delay**: default **2 seconds** — a brief cooldown before LLDP restarts on an interface, so it doesn't thrash on flapping links.
- **LLDP-MED** (Media Endpoint Discovery) extension carries voice-VLAN, location, and **PoE negotiation** info — this is how IP phones auto-configure.
- **Commands**:
  - `lldp run` — global enable.
  - `lldp transmit` and `lldp receive` — per-interface, and notice they're **separate**: you can listen without speaking, useful for stealthier deployments.
  - `lldp timer <seconds>` — advertisement interval.
  - `lldp holdtime <seconds>` — cache lifespan.
  - `lldp reinit <seconds>` — reinit delay.
  - `show lldp neighbors` and `show lldp neighbors detail`.

### Side-by-side cheatsheet

| | CDP | LLDP |
|---|---|---|
| Standard | Cisco proprietary | IEEE 802.1AB |
| Default state | On | Off (on Cisco) |
| Timer | 60s | 30s |
| Holdtime | 180s | 120s |
| MAC | 01:00:0c:cc:cc:cc | 01:80:c2:00:00:0e |
| VTP domain | Yes | No |
| PoE negotiation | No | Yes (via MED) |
| Multi-vendor | No | Yes |

## Related concepts

[[VLAN Trunking Protocol (VTP)]]
[[Power over Ethernet (PoE)]]
[[Voice VLAN]]
[[Layer 2 multicast]]
[[Network reconnaissance and information disclosure]]
[[802.1Q trunking]]
[[Network topology discovery]]