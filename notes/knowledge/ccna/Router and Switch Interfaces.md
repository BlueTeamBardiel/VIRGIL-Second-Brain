# Router and Switch Interfaces

## What it is

A network interface is the loadout slot on your router or switch — the physical port plus the firmware/driver logic behind it that lets the device actually talk to the network. The port is the gun; the configuration is how it's tuned.

Cisco names interfaces in a `TYPE SLOT/PORT` format. So `GigabitEthernet 0/1` means "the Gigabit Ethernet interface in slot 0, port 1." The type tells you the maximum speed class, the slot tells you which line card or module it lives on, and the port is the physical jack.

Common types:
- `Ethernet 0/0` — 10 Mbps (the original, now obsolete — the equivalent of bringing a bolt-action to Warzone)
- `FastEthernet 0/1` — 100 Mbps (legacy, but still alive in older gear)
- `GigabitEthernet 0/0` — 1000 Mbps (the modern standard)
- 10 Gigabit Ethernet — 10000 Mbps (datacenter / uplink territory)
- `Serial 0/0` — legacy WAN interface, the dial-up-era relic you still see on CCNA lab diagrams

## Why it matters

Two interfaces connecting to each other are like two players queuing into the same Counter-Strike 2 lobby — if one is on a 60Hz monitor and the other is on 240Hz with different settings, the match still happens but someone is going to feel like they're playing underwater. Speed and duplex have to agree, or the link either won't form or will form badly and silently corrupt your day.

Mismatches are some of the most painful issues to troubleshoot because the link light is green, ping mostly works, but throughput tanks and CRC errors quietly pile up. Knowing how interfaces negotiate — and when to override that negotiation — is the difference between "the network is slow" tickets and a network that just works.

## Key facts

### Speed tiers
- **Ethernet**: 10 Mbps — obsolete
- **Fast Ethernet**: 100 Mbps — legacy
- **Gigabit Ethernet**: 1000 Mbps — current standard
- **10 Gigabit Ethernet**: 10000 Mbps — uplinks and servers
- Connected interfaces **must operate at the same speed** to communicate. No mixing tiers — it's like trying to co-op Helldivers 2 across incompatible regions.

### Duplex
- **Half-duplex**: traffic flows one direction at a time. Like push-to-talk on a Discord voice channel — only one person transmits at once, and if two people key up simultaneously, you get a collision.
- **Full-duplex**: simultaneous send and receive. Like a normal Discord call where everyone can talk over each other freely. **No collision risk.**
- Half-duplex has **high collision risk** and uses **CSMA/CD** (Carrier Sense Multiple Access with Collision Detection) — listen before you talk, back off if you crash into someone.

### Autonegotiation
- Enabled by default on most modern Cisco equipment.
- Both sides exchange info about supported speeds and duplex modes, then agree on:
  - The **fastest speed both support** (negotiates *down* to the slowest common speed)
  - **Full-duplex** if both support it
- **Fast Link Pulse (FLP)** carries negotiation on older interfaces; **Next Page** messages handle negotiation on newer ones with more capabilities to advertise.
- If autonegotiation **fails on older gear**, the interface falls back to **10 Mbps half-duplex** — the safe-but-sad default.

### Mismatches (the silent killers)
- **Speed mismatch**: two interfaces hardcoded to different speeds — link likely won't come up at all.
- **Duplex mismatch**: one side full, the other half. The full-duplex side transmits whenever it wants; the half-duplex side thinks that's a collision.
  - Causes **late collisions** on the half-duplex side
  - Produces **asymmetric performance** — fine in one direction, packet loss in the other
  - **CRC error counter** climbs on the half-duplex side. That's your forensic fingerprint.
- **Mixing manual speed with auto duplex** is the classic footgun: if you hardcode speed but leave duplex on auto, the auto side can't detect the partner's duplex and defaults to half — instant mismatch.

### Configuration commands
Entering interface config mode:
```
interface gigabitethernet 0/0
```
Then:
- `description UPLINK_TO_CORE` — human label, like renaming your Minecraft world so you remember what it is
- `speed 1000` — hardcode 1000 Mbps
- `speed auto` — enable autonegotiation for speed
- `no speed auto` — disable speed autonegotiation
- `duplex full` / `duplex half` / `duplex auto`
- `no duplex auto` — disable duplex autonegotiation
- `shutdown` — disable the interface (admin down)
- `no shutdown` — bring it up. **Routers default to shutdown**, so a fresh router interface is dark until you `no shut` it.

### Verification commands
- `show interfaces gigabitethernet 0/0` — full detail dump for one interface (counters, errors, speed, duplex, MTU)
- `show interfaces brief` — summary table of all interfaces, the at-a-glance scoreboard
- `show interfaces status` — administrative + operational status
- `show interfaces description` — just the labels, useful when you actually wrote good descriptions
- `clear counters` — zero out error counters on all interfaces. Run this *before* a test so you know any new CRCs came from your test, not from last Tuesday.

## Related concepts
[[Ethernet Frames]]
[[CSMA/CD]]
[[Cisco IOS CLI Modes]]
[[Switchport Configuration]]
[[VLAN and Trunking]]
[[Cabling and Media Types]]
[[Auto-MDIX]]
[[Interface Troubleshooting and CRC Errors]]