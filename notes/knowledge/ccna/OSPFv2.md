# OSPFv2

## What it is

In Mass Effect, every Spectre and Council species shares full intel through the galactic comm buoy network — the Citadel knows what's happening on Tuchanka, Palaven knows what's burning on Earth, and every relay node has the same star map. No one whispers "ask the krogan, they might know." Everyone has the whole picture. That's OSPFv2. Every router knows the full topology, not just "go ask the next hop."

OSPFv2 (Open Shortest Path First version 2) is a **link-state interior gateway protocol (IGP)**. "Interior" means it runs inside a single autonomous system — one organization's network, the way Alliance comms run inside Alliance space. Routers flood each other with Link-State Advertisements (LSAs) describing their directly connected links, every router assembles an identical map of the AS, and then each one independently runs **Dijkstra's shortest path first algorithm** to compute the best route to every destination.

It runs **directly on top of IP as protocol number 89** — no TCP, no UDP, no middleman. Think of it like a direct mass relay jump instead of routing through three star systems and a customs checkpoint: less overhead, but OSPF has to handle its own reliability — acknowledgments, retransmissions, sequencing, all in-house.

## Why it matters

Static routes are like hardcoded GPS directions — the moment a road closes, you're driving into a lake. OSPF reacts to topology changes in seconds because every router already has the full map; it just recomputes Dijkstra and reroutes traffic. That's the difference between a respawn timer and a permanent kill.

But OSPF without authentication is a Watch Dogs side mission waiting to happen. An attacker who plops a rogue router on the segment can inject malicious LSAs, advertise themselves as the best path to everything, and silently funnel traffic through their box. **Route injection** is OSPF's version of an Among Us imposter calling an emergency meeting and rewriting the rules. MD5 authentication is the fix.

## Key facts

### Areas and topology

- **Area 0 is the backbone** and is mandatory. It's the central hub of the Tower of Fantasy — every other zone teleports through it.
- **All non-backbone areas must touch Area 0**, either directly or via a virtual link. No shortcuts between Area 1 and Area 2 without going through 0.
- Areas exist to limit LSA flooding scope — without them, a 5,000-router network would melt under flood traffic like a Helldivers 2 bug breach with no stratagems.

### Multicast and transport

- **224.0.0.5** — "AllSPFRouters." The general guild chat channel; every OSPF router listens here.
- **224.0.0.6** — "AllDRouters." Private channel only the DR and BDR care about.
- **IP protocol number 89** — OSPF rides directly on IP, no transport layer. Like sending a UDP-style fire-and-forget but at an even lower layer.

### Neighbor states (the handshake speedrun)

OSPF routers go through seven states before they're fully synced. It's the matchmaking-to-loaded-into-the-lobby pipeline:

1. **Down** — Haven't heard a peep.
2. **Init** — Got a Hello, but they haven't acknowledged me yet (one-sided DM).
3. **2-Way** — We've both seen each other's Hellos. On multi-access links, DR/BDR election happens here.
4. **ExStart** — Deciding who talks first (master/slave for DBD exchange).
5. **Exchange** — Trading Database Description packets — basically swapping inventory lists.
6. **Loading** — Requesting the LSAs you don't have yet, like downloading the missing texture pack.
7. **Full** — Databases are identical. You're queued and ready.

### DR and BDR election

- On **multi-access networks** (Ethernet segments where many routers share a wire), full-mesh adjacencies would explode: 10 routers = 45 adjacencies. Instead, OSPF elects a **Designated Router (DR)** and **Backup DR (BDR)**, and everyone else only forms full adjacency with those two.
- Cuts LSA flooding overhead dramatically — like a raid leader being the only one who calls boss mechanics instead of 40 people screaming at once.
- **Election criteria:**
  - Highest **OSPF priority** wins (default 1; priority 0 means "I refuse to be DR").
  - **Highest Router ID** is the tiebreaker.
- Election is **non-preemptive** — a new router with higher priority joining later won't dethrone the current DR. It's seniority, not skill.

### Authentication

- **MD5 authentication** is supported between neighbors. Each Hello/LSU carries a hash; mismatched key = packet dropped.
- Configured **per-interface** (and applied per-area in practice). You can run different keys on different segments.
- Without authentication, **route injection** is trivial: any device on the segment can claim "I have a /1 to half the internet, send it through me." The attacker becomes a man-in-the-middle for the entire AS.
- MD5 isn't cryptographically modern, but it stops casual injection cold. Stronger options (SHA via OSPFv3 cryptographic auth, IPsec) exist for higher-threat environments.

## Related concepts

- [[Dijkstra's Shortest Path First Algorithm]]
- [[Link-State vs Distance-Vector Routing]]
- [[OSPFv3]]
- [[EIGRP]]
- [[IS-IS]]
- [[BGP]]
- [[Autonomous System (AS)]]
- [[LSA Types]]
- [[Route Injection Attacks]]
- [[Routing Protocol Authentication]]