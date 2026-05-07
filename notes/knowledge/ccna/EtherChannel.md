# EtherChannel

## What it is

A four-person Helldivers 2 squad pushing one objective — they move as a unit, the game treats them as "the team," and if one player goes down the squad keeps fighting with reduced firepower. EtherChannel does the same thing to switch ports: it bundles multiple physical links between two switches into a single logical link that everything upstream — including Spanning Tree — sees as one port.

Without bundling, if you ran four cables between two switches hoping for 4 Gbps of throughput, STP would look at three of them, scream "LOOP!" and shut them down to blocking state. You'd pay for four links and use one. EtherChannel sidesteps this by telling STP "these four ports are actually one port, calm down." All four links forward traffic, no loop forms, and you get the combined bandwidth.

The trick that makes loops impossible: when a broadcast frame enters the channel, the sending switch picks exactly one physical port to send it out. The receiving switch knows that frame came in on the channel, so it will never flood it back out any other port in that same channel. No echo, no loop.

## Why it matters

Four 1 Gbps links bonded together give you 4 Gbps of logical bandwidth and four times the resilience — losing one cable just drops you to 3 Gbps, like a teammate dying mid-raid but the run continues. Without EtherChannel, that same failure scenario means STP reconverges, ports transition states, and traffic stalls for seconds.

It also collapses your config workload. Instead of configuring VLANs, trunking, security, and QoS on four separate interfaces and praying they match, you configure the port channel once and the members inherit it. One source of truth, fewer typos at 2 AM.

## Key facts

**The basics**
- The logical interface is called a **port channel**, abbreviated **Po** (e.g., Po1, Po2, Po3) — like a guild tag that wraps all the individual members.
- The `channel-group` command on a physical interface enlists it into a port channel.
- EtherChannel does **not** replace STP. STP still runs, it just sees the Po interface instead of the members. STP cost is recalculated from the combined bandwidth.
- `show etherchannel summary` is the go-to command for "is this thing actually up and who's in it?"

**Negotiation protocols**

Think of these like matchmaking modes in Counter-Strike — both players need compatible queue settings or the lobby never starts.

### LACP (IEEE 802.3ad standard, vendor-neutral)
- **Active**: actively sends LACP packets, looking for a partner.
- **Passive**: listens only, forms a channel only if the other side is active.
- Active + Active → ✅ forms
- Active + Passive → ✅ forms
- Passive + Passive → ❌ both sides waiting, neither talks, dead silence.

### PAgP (Cisco proprietary)
- **Desirable**: actively sends PAgP packets (the "active" equivalent).
- **Auto**: listens only.
- Desirable + Desirable → ✅ forms
- Desirable + Auto → ✅ forms
- Auto + Auto → ❌ no channel.

### Static (mode `on`)
- No negotiation at all. Both sides are forced into the channel. If one side is `on` and the other is running LACP/PAgP, it breaks badly — like force-loading into a Souls invasion with mismatched versions.

**Load balancing**
- Per-**flow**, not per-frame. A single conversation between Host A and Host B always pins to the same physical link — this preserves frame ordering.
- A hash algorithm maps each flow to a member port. Methods: `src-mac`, `dst-mac`, `src-dst-mac`, `src-ip`, `dst-ip`, `src-dst-ip`.
- One chatty server talking to one client won't magically use all four links — it picks one and rides it. To actually spread load, you need many flows.
- `show etherchannel load-balance` reveals the current hash method; `port-channel load-balance` changes it.

**Why per-flow matters**: if frames from one TCP session sprayed across four links round-robin, they'd arrive out of order and TCP would melt down retransmitting. Pinning a flow to one link is the boring-but-correct answer.

## Related concepts

[[Spanning Tree Protocol]] · [[LACP]] · [[PAgP]] · [[Trunking]] · [[Link Aggregation]] · [[Switch Port Configuration]] · [[Broadcast Domains]] · [[Layer 2 Loops]]