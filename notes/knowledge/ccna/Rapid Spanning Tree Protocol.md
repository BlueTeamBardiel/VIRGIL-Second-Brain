# Rapid Spanning Tree Protocol

## What it is

When a Counter-Strike 2 player gets killed mid-round, the team doesn't wait 50 seconds before reacting — someone immediately rotates to cover the gap. Classic STP is the opposite: when a link dies, switches sit in silence counting down timers like they're waiting for a respawn wave. RSTP (802.1w) is the version where teammates actively call out the rotation in voice chat and move *now*.

Both protocols solve the same fundamental problem: Ethernet frames have no TTL field (unlike IP packets), so a Layer 2 loop will replicate frames forever, melting CPUs and saturating links with broadcast storms while MAC tables flap between ports. STP and RSTP build a loop-free logical tree by blocking redundant paths, but RSTP does it dramatically faster by replacing passive timers with an active proposal/agreement handshake between neighbors.

**Classic STP** elects a Root Bridge, then every other switch picks one Root Port toward it, and each segment elects one Designated Port. Everything else gets blocked. When topology changes, ports crawl through Listening → Learning → Forwarding with 15-second waits at each stage.

**RSTP** keeps the same election logic but rebuilt the state machine and convergence mechanics from scratch. Instead of waiting for Max Age to expire, switches negotiate directly: "I propose I become the designated port on this link" / "Agreed, you go ahead." Convergence drops from 30–50 seconds to 1–3 seconds, often sub-second.

## Why it matters

Thirty seconds of network downtime every time a switch reboots or a cable gets bumped is the equivalent of every player on your Apex Legends squad freezing in place when one teammate disconnects. Modern networks run VoIP calls, trading systems, video streams, and game servers — none of them tolerate a half-minute blackout. RSTP is essentially mandatory on any switch deployed this decade.

It also matters for security. Attackers who plug rogue switches into access ports can advertise themselves as the Root Bridge and reroute traffic through their device — a Watch Dogs 2-style network hijack. RSTP doesn't stop this on its own, but it's the foundation that Root Guard, BPDU Guard, and Loop Guard sit on top of.

## Key facts

### The convergence gap (the whole reason RSTP exists)

- **STP convergence: 30–50 seconds.** Blocking → Listening (15s Forward Delay) → Learning (15s Forward Delay) → Forwarding. If waiting on Max Age too, add 20 more seconds.
- **RSTP convergence: 1–3 seconds**, often faster on point-to-point full-duplex links. The proposal/agreement handshake replaces the timer countdown.
- RSTP uses **active failure detection** — neighbors notice missing BPDUs after 3 hellos (~6 seconds) instead of waiting Max Age.
- RSTP performs **localized convergence**. A topology change near the edge doesn't flood TCNs across the whole network like STP does.

### Port states — RSTP collapsed the list

**STP has 5 states:** Disabled, Blocking, Listening, Learning, Forwarding. Like a fighting game with too many startup frames.

- *Disabled*: admin shutdown or error — port is dead.
- *Blocking*: no forwarding, no MAC learning, but still listens to BPDUs.
- *Listening*: 15 seconds of processing BPDUs, no MAC learning.
- *Learning*: 15 seconds of building MAC table, no frame forwarding.
- *Forwarding*: actually carries traffic.

**RSTP has 3 states:** Discarding, Learning, Forwarding. Discarding rolls Disabled/Blocking/Listening into one — if it's not learning or forwarding, it's discarding.

### Port roles

**STP roles:** Root, Designated, Non-Designated (Blocked).

**RSTP roles:** Root, Designated, **Alternate**, **Backup** — the two new ones are the secret sauce.

- **Alternate Port**: a pre-computed backup to the Root Port. Like having a second loadout already configured in Escape from Tarkov — when your Root Port dies, the Alternate takes over instantly without re-electing anything.
- **Backup Port**: a pre-computed backup to a Designated Port on the *same* segment (only happens with hubs/shared media).

### Link types decide RSTP's speed

- **Point-to-point (full-duplex)**: proposal/agreement handshake works. Sub-second convergence. This is your normal switch-to-switch fiber or copper run.
- **Shared (half-duplex)**: RSTP **downgrades to STP behavior**. Half-duplex is the giveaway that a hub might be involved, and hubs can't do the handshake.
- **Edge port (PortFast)**: connects to an end device (laptop, server, printer). Skips Listening/Learning entirely and goes straight to Forwarding. Safe because end devices don't send BPDUs — but if one ever shows up, **BPDU Guard** err-disables the port. PortFast still listens for BPDUs; it just doesn't wait around if none arrive.

### Path cost — the new formula

RSTP/802.1D-2004 uses **20,000,000,000 ÷ bandwidth (bps)**. The old 802.1D-1998 numbers are tiny by comparison and break down at gigabit speeds.

| Speed | Old STP cost | RSTP cost |
|-------|--------------|-----------|
| 10 Mbps | 100 | 2,000,000 |
| 100 Mbps | 19 | 200,000 |
| 1 Gbps | 4 | 20,000 |
| 10 Gbps | 2 | 2,000 |
| 100 Gbps | — | 200 |

Root Path Cost is the sum of all port costs from a switch back to the Root Bridge. Lower wins.

### Election logic (same in both)

- **Root Bridge** = lowest Bridge ID. Bridge ID = 2-byte priority + 6-byte MAC. Default priority is **32768** on Cisco. Tiebreaker is lowest MAC.
- **Root Port** = one per non-root switch, lowest Root Path Cost toward root.
- **Designated Port** on each segment: lower Root Path Cost wins → tiebreaker lower Sender Bridge ID → final tiebreaker lower Sender Port ID.
- Root Bridge's own ports are always Designated with cost 0.

### BPDUs

- Sent to multicast MAC **01:80:C2:00:00:00**. Never routed — pure Layer 2.
- Hello timer default: **2 seconds** (same in STP and RSTP).
- Forward Delay: **15 seconds** (RSTP keeps this for STP backwards compatibility, even though it doesn't really use it).
- Max Age: **20 seconds**.
- RSTP BPDUs add **Proposal flag**, **Agreement flag**, and **Port Role bits** to the format.
- If an RSTP switch receives a legacy STP BPDU on a port, it **downgrades that port to STP mode** automatically — like a co-op game dropping to the lowest player's framerate.

### Topology change triggers

- Link failure, new switch added, or a non-edge port moving to Forwarding.
- A *Root Bridge* port moving to Forwarding does **not** trigger TC (it's expected behavior at startup).

### Protection features (the security layer)

- **Root Guard**: stops a port from accepting superior BPDUs. If a rogue switch tries to claim Root Bridge, the port goes into **Root Inconsistent** state. Like a gatekeeper boss in Dark Souls — your old gear works fine, but you can't escalate past this point.
- **Loop Guard**: if a port stops receiving BPDUs (suggesting a unidirectional link failure), it blocks rather than transitioning to Forwarding. Prevents the silent-loop scenario.
- **BPDU Guard**: pairs with PortFast. If any BPDU arrives on a PortFast edge port, the port is err-disabled. End-user laptops shouldn't be sending BPDUs — if one is, something is very wrong.
- **BPDU Filter**: completely stops a port from sending or receiving BPDUs. Use carefully — it disables STP's protection on that port.

### Cisco enable commands

- `spanning-tree mode rapid-pvst` — RSTP per VLAN.
- `spanning-tree mode pvst+` — legacy STP per VLAN.

### Why loops are catastrophic at L2

- Ethernet frames have no TTL — they loop forever.
- **Broadcast storms** flood the network and pin switch CPUs.
- **MAC flapping**: the same MAC appears on multiple ports as the looped frame circulates, corrupting the CAM table.

## Related concepts

[[Spanning Tree Protocol (802.1D)]]
[[MST - Multiple Spanning Tree Protocol (802.1s)]]
[[PortFast and BPDU Guard]]
[[Root Guard and Loop Guard]]
[[Bridge Protocol Data Units (BPDU)]]
[[Root Bridge Election]]
[[EtherChannel and LACP]]
[[Layer 2 Loop Prevention]]
[[VLAN Trunking and 802.1Q]]
[[Unidirectional Link Detection (UDLD)]]