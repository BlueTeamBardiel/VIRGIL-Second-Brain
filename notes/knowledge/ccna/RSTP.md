# RSTP

## What it is

Respawn timers in Call of Duty used to be brutal — 30-50 seconds of staring at the killcam. RSTP is the patch that cut that down to about 1 second. Same game, same purpose (keep the network loop-free), just way faster recovery.

**Rapid Spanning Tree Protocol (IEEE 802.1w)** is the evolution of legacy STP. Switches in a redundant Layer 2 topology need a way to agree on which links to use and which to block, otherwise broadcast frames loop forever and melt the network. RSTP keeps that loop-prevention logic but rebuilds the convergence engine to react in roughly **1 second** instead of the painful **30-50 seconds** legacy STP took to recover from a topology change.

It was later folded into **IEEE 802.1D-2004**, which is why "STP" on any modern managed switch is almost certainly RSTP under the hood.

## Why it matters

A Layer 2 loop is the networking equivalent of two mirrors facing each other in Minecraft with a redstone signal bouncing between them — it never stops, and it brings the whole server down. Without spanning tree, any redundant cable between switches becomes a guaranteed outage.

The convergence speed matters because every second of reconvergence is a second of partial outage. With legacy STP, plugging in a new switch or losing a link could mean nearly a minute of dropped VoIP calls, frozen video, and angry tickets. RSTP makes that flicker barely noticeable.

But fast convergence also means fast hijacking if you don't lock things down. The same election process that picks a root bridge can be exploited — a rogue switch with a **superior Bridge ID** wins the election, and suddenly all inter-switch traffic flows through the attacker's box. That's a **Root Bridge Attack**, and it's why hardening controls like BPDU Guard and Root Guard exist.

## Key facts

### The protocol itself
- **IEEE 802.1w**, later rolled into **802.1D-2004**.
- Converges in **~1 second** vs. legacy STP's **30-50 seconds** — like the difference between Elden Ring's instant respawn at a Site of Grace versus running back from the bonfire.
- Default spanning tree behavior on modern managed switches.
- Eliminates Layer 2 switching loops on redundant topologies.

### Port roles (three of them)
- **Root Port** — the port with the best path to the root bridge. The "follow the leader" port.
- **Designated Port** — the chosen forwarder for a given segment. One per segment, like the squad leader in Helldivers 2 calling in stratagems for that area.
- **Alternate / Backup Port** — the bench player. Already knows the playbook, ready to swap in instantly if the active port dies. This is the secret to RSTP's speed: backups are pre-computed, not discovered after the fact.

### Port states (simplified from STP's four)
- **Discarding** — drops frames, doesn't learn MACs. Replaces STP's blocking and listening states.
- **Learning** — building the MAC table but not yet forwarding.
- **Forwarding** — fully passing traffic.
- Cutting the state list from 4 to 3 is part of how RSTP shaves the convergence time.

### BPDU Guard (Layer 2 hardening)
- Bouncer at the door: any port configured with BPDU Guard that receives a **BPDU** (the spanning tree control message) gets shut down immediately.
- Meant for access ports facing end users — your laptop should never be sending BPDUs. If it does, someone plugged in a switch they shouldn't have, or worse, a rogue device trying to join the spanning tree election.

### Root Guard (Layer 2 hardening)
- Prevents a port from accepting a **superior BPDU** that would crown a new root bridge through that port.
- Protects against the **Root Bridge Attack**: an attacker plugs in a switch with a manipulated Bridge ID low enough to win the election, then becomes the central transit point for inter-switch traffic — a Watch Dogs-style man-in-the-middle on the entire Layer 2 fabric.
- Where BPDU Guard says "no BPDUs allowed at all," Root Guard says "BPDUs fine, but you're not allowed to be the boss."

## Related concepts
- [[Spanning Tree Protocol (STP)]]
- [[Bridge Protocol Data Units (BPDU)]]
- [[Bridge ID and Root Bridge Election]]
- [[BPDU Guard]]
- [[Root Guard]]
- [[Layer 2 Loop Prevention]]
- [[MSTP (Multiple Spanning Tree Protocol)]]
- [[PortFast]]
- [[Layer 2 Attacks]]