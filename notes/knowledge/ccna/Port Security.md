# Port Security

## What it is

The bouncer at a Discord voice channel that only lets in people on the approved list — and slaps a ban on the whole channel if some rando tries to slip in. Port Security is a Layer 2 feature on Cisco switches that limits how many unique MAC addresses can talk through a single switch port, and decides what to do when someone breaks the rule.

The switch watches the source MAC of every frame entering a port. If the port has only seen MACs it's allowed to see, traffic flows. The moment an unexpected MAC shows up — or the count exceeds the configured maximum — the violation action kicks in.

By default, a port-security-enabled port allows exactly **one** MAC address. One device, one port, one identity.

## Why it matters

Switches are trusting by nature. They learn MAC addresses on the fly, the same way Among Us crewmates assume everyone in the lobby is who they say they are. Attackers exploit that trust two ways:

- **MAC flooding** — the attacker blasts the switch with frames containing thousands of fake source MACs. The MAC address table (CAM table) fills up. Once full, the switch fails open: it starts flooding unicast frames out every port like a dumb hub. Now the attacker sniffs traffic meant for other hosts. Confidentiality: gone.
- **DHCP exhaustion** — the attacker sends a flood of DHCP DISCOVER messages, each with a different spoofed MAC. The DHCP server hands out leases until the pool is empty. Legitimate clients can't get an IP. Availability: gone.

Port Security shuts both attacks down at the source. The switch refuses to learn the 50,000th fake MAC because you told it the port only gets one. The fake DISCOVER flood dies before it reaches the DHCP server.

It's the difference between a Helldivers 2 stratagem beacon that anyone can throw and one keyed to your Super Destroyer only.

## Key facts

### Where it works
- Only runs on **access** or **trunk** ports — ports with a defined personality.
- Does **not** work on ports running DTP (dynamic auto / dynamic desirable). The port has to commit to a role first; Port Security won't babysit a port that's still figuring out what it wants to be.

### Limits and learning
- **Default max MAC addresses per port: 1.** One seat at the table.
- MACs can be configured statically, learned dynamically, or learned **sticky**.
- **Sticky learning** = the switch dynamically learns a MAC and writes it into running-config as a static secure entry. Like a game auto-saving your loadout — but only to RAM. You still have to `write memory` (or `copy run start`) for it to survive a reboot. Skip that and your "permanent" config evaporates on power cycle.

### Aging types
Two ways a learned MAC can expire and free up a slot:
- **Absolute aging** — MAC expires after X minutes no matter what. Like a Cyberpunk 2077 quickhack timer; it ticks down whether the target is active or not.
- **Inactivity aging** — MAC only expires if no frames have been seen from it for X minutes. Like AFK kick timers in MMOs — staying active keeps you in.

### Violation modes (what happens when the rule breaks)
| Mode | Port state | Drops frames | SNMP trap / syslog | Counter increments |
|---|---|---|---|---|
| **Shutdown** (default) | err-disabled | Yes | Yes | Yes |
| **Restrict** | up | Yes | Yes | Yes |
| **Protect** | up | Yes | **No** | No |

- **Shutdown** — nuclear option. Port goes err-disabled. Needs manual `shutdown` / `no shutdown` to come back, or automatic recovery configured.
- **Restrict** — port stays up, only the bad frames die, you get logs and SNMP traps so you know it happened. Like a CS2 anti-cheat that shadow-bans the cheater while telling the admins.
- **Protect** — silent dropper. No logs, no traps. You won't know it triggered unless you go looking.

### Recovering err-disabled ports
- Manual: `shutdown` then `no shutdown` on the interface.
- Automatic: `errdisable recovery cause psecurity` tells the switch to auto-revive port-security err-disables.
- `errdisable recovery interval <seconds>` sets the cooldown timer before recovery — the respawn timer.

### Useful show commands
- `show port-security interface <int>` — status, violation mode, max MACs, current count, aging config. The character sheet for that port.
- `show port-security address` — every secure MAC the switch knows about, learned or static, and which port owns it. The full guest list.

## Related concepts
- [[MAC flooding attack]]
- [[DHCP exhaustion attack]]
- [[DHCP snooping]]
- [[Dynamic ARP Inspection]]
- [[DTP and switchport modes]]
- [[CAM table]]
- [[err-disable recovery]]
- [[Sticky MAC]]
- [[802.1X port-based authentication]]