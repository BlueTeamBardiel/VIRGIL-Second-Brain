# Dynamic Routing with EIGRP

## What it is

In Smash Bros, your opponent doesn't redraw the entire stage every frame to tell you what's happening — you only react to *changes*: Falcon throws a punch, Samus charges a shot, a Smash Ball spawns. The stage geometry stays cached in your head; only deltas matter. That's exactly what EIGRP does — it tells its neighbors the full picture once, then only whispers updates when something actually changes.

EIGRP (Enhanced Interior Gateway Routing Protocol) is Cisco's hybrid routing protocol — hybrid because it borrows the fast convergence and metric-richness of link-state protocols (like [[OSPF]]) while keeping the simpler neighbor-based gossip model of distance-vector protocols. Routers running EIGRP form neighbor relationships, exchange their full topology once at startup, and after that only send **partial bounded updates** when something in the topology actually changes.

The brain behind it is **DUAL** (Diffusing Update Algorithm). DUAL is the tournament player who already knows their punish before the opponent whiffs — it pre-computes not just the best route to every destination (the **Successor**) but also a backup route that's mathematically guaranteed to be loop-free (the **Feasible Successor**). When the primary path dies, EIGRP doesn't freeze mid-stage like someone who just got shield-broken — it swaps to the Feasible Successor instantly, no recalculation needed.

## Why it matters

Routing protocols decide where your traffic goes. If an attacker can get a router to believe a lie about the network topology, they can drag your traffic through their box, sniff it, modify it, or just drop it on the floor. This is **route injection** — the networking equivalent of Aiden Pearce in Watch Dogs rerouting traffic cameras to follow a target. The attacker spoofs EIGRP Hello packets or fake route advertisements, the legitimate routers welcome the impostor as a neighbor, and suddenly the "best path" to your file server runs through the attacker's laptop.

The defense is **neighbor authentication**. EIGRP supports MD5 and SHA-256 key chains, which work like the secret handshake in Among Us — if you don't know the shared key, you don't get to claim you're a crewmate. Routers reject Hello packets that don't carry a valid HMAC, so a rogue router on the wire can shout routing updates all day and nobody listens.

EIGRP also matters because of who wins fights. When a router learns the same destination from multiple protocols, **administrative distance** is the tiebreaker — lower wins. EIGRP internal routes sit at 90, OSPF at 110. So in a mixed network, EIGRP's word beats OSPF's word every time, even if OSPF has a "better" path by its own math. This is the kind of detail that quietly steers traffic in ways operators don't always notice until something breaks.

## Key facts

### Protocol identity
- **EIGRP** = Enhanced Interior Gateway Routing Protocol.
- Originally **Cisco-proprietary**, but published as an open standard in **RFC 7868** in 2016 — like when a fighting game's frame data finally gets officially documented instead of living in a community wiki.
- **Classless**: carries subnet masks in updates, so VLSM and CIDR work fine.
- **Hybrid**: distance-vector roots, link-state-style convergence behavior.

### How it talks
- Forms neighbor adjacencies via **Hello packets**, then exchanges full topology once.
- After that: **partial bounded updates** — only the changed routes, sent only to routers that need to know. No periodic full-table broadcasts.

### DUAL (the algorithm)
- Computes the **Successor** (best path) and a **Feasible Successor** (pre-vetted backup) for each destination.
- The Feasible Successor is guaranteed loop-free by the feasibility condition — it's not just "the second-best path," it's mathematically safe to use immediately.
- Failover to the Feasible Successor is effectively instant, no recomputation phase. Like having a respawn loadout already locked in before you die.

### Administrative distance
- **EIGRP internal: 90** — routes learned from EIGRP neighbors in your own AS.
- **EIGRP external: 170** — routes redistributed into EIGRP from another protocol. Trusted less because they're hearsay.
- **OSPF: 110**.
- Lower wins, so **EIGRP internal (90) beats OSPF (110)** when both protocols know the same destination. External EIGRP (170) loses to OSPF, which catches a lot of engineers off guard during redistribution.

### Security
- **Route injection** attack: attacker sends forged Hello packets or fake route advertisements, becomes a "neighbor," and advertises attractive (low-metric) routes to pull traffic through their router. Classic man-in-the-middle setup.
- **MD5 authentication**: shared-secret HMAC on EIGRP packets. Legacy but widely deployed.
- **SHA-256 authentication**: stronger HMAC, the modern choice. MD5 is cryptographically wounded — use SHA-256 where the platform supports it.
- Both use **key chains**, which let you rotate keys with start/end times, like rotating Discord invite links so old leaks expire on their own.

## Related concepts
- [[OSPF]]
- [[Administrative Distance]]
- [[DUAL Algorithm]]
- [[Route Redistribution]]
- [[Routing Protocol Authentication]]
- [[Route Injection Attacks]]
- [[BGP]]
- [[RIP]]
- [[HMAC]]
- [[Key Chains]]