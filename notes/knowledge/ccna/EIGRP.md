# EIGRP

## What it is

EIGRP is the routing protocol equivalent of a squad in Helldivers 2 constantly pinging each other with stratagem updates — every router in the squad keeps a live map of who's reachable, who just went down, and what the fastest backup route is when the primary path gets nuked. It's not just shouting "here's my whole world" like link-state protocols, and it's not just whispering "trust me, this path is 5 hops" like old distance-vector protocols. It's a hybrid.

**EIGRP (Enhanced Interior Gateway Routing Protocol)** is a Cisco-proprietary routing protocol that combines distance-vector efficiency (only telling neighbors what changed) with link-state awareness (keeping enough topology info to compute backup paths instantly). It runs the **Diffusing Update Algorithm (DUAL)**, which mathematically guarantees loop-free paths and pre-computes a backup route — called a **feasible successor** — before anything breaks.

Think of DUAL like Elden Ring's stake of Marika system: when your primary path "dies," EIGRP doesn't reload from a save — it respawns instantly at the pre-marked backup, no convergence delay.

## Why it matters

Fast convergence is the whole sales pitch. When a link drops, OSPF has to recalculate the shortest path tree; RIP has to wait out timers like a Pokémon waiting for its turn. EIGRP just swaps to the feasible successor it already had on standby. That's the difference between a 200ms blip and a 30-second outage.

But the same chattiness that makes EIGRP fast also makes it loud — and loud protocols leak information. An attacker who can reach the network segment and isn't blocked by authentication can inject fake routes, become a feasible successor, and silently redirect traffic through their own box. That's a man-in-the-middle attack dressed up as a routing update. In Watch Dogs terms: ctOS doesn't need to break encryption if it can just convince every traffic light that *its* server is the closest one.

Anywhere EIGRP runs without MD5 or SHA-256 authentication, the routing table is essentially a public Google Doc with edit access on.

## Key facts

### Protocol mechanics
- **Cisco-proprietary** — historically locked to Cisco gear, though it was opened up via informational RFC. Still mostly a Cisco-shop protocol.
- **Hybrid design** — distance-vector at heart, but stores topology info like a link-state protocol. Best of both classes, like a Cyberpunk 2077 Netrunner/Solo build.
- **DUAL algorithm** — picks a **successor** (primary route) and a **feasible successor** (pre-validated backup). The feasible successor must satisfy the feasibility condition: its reported distance to the destination is less than the current successor's total distance. This math is what prevents loops.
- **Composite metric** — by default uses **bandwidth** and **delay**, with **reliability** and **load** available as optional knobs (and MTU as a tiebreaker). Not just hop count like RIP. It's the difference between picking a Discord server based on member count vs. picking it based on ping, mods, and how toxic chat is.
- **Classless** — supports VLSM and CIDR, so you can subnet however you want (10.0.0.0/24, 10.0.1.0/27, whatever).

### Neighbor discovery
- **Hello packets** keep neighbor relationships alive — like the heartbeat ping in any multiplayer lobby. Stop hearing them, you assume the player rage-quit.
- **Default Hello interval is 5 seconds** on LAN/high-bandwidth links. The hold timer (how long before declaring a neighbor dead) is 3× that — 15 seconds.
- **Multicast 224.0.0.10** is the address EIGRP uses for updates. Only EIGRP speakers tune into that channel — like a Discord voice channel only routers are invited to.

### Security
- **MD5 and SHA-256 authentication** are supported for verifying neighbors. Without these, any device that can send packets to 224.0.0.10 can claim to be a router.
- **Route injection attacks** exploit unauthenticated EIGRP by feeding the DUAL algorithm bogus routes with attractive metrics, hijacking feasible successor selection. The attacker becomes the "best path."
- **Route poisoning** can be weaponized — instead of legitimately advertising a dead route, an attacker poisons real routes and replaces them with paths through a malicious hop.
- **Man-in-the-middle exposure** — once the attacker is the next hop, all traffic flows through their interface. They can sniff, modify, or drop at will. The fix is non-negotiable: enable authentication on every EIGRP interface, and ideally restrict EIGRP to trusted interfaces only (passive-interface for everything else).

## Related concepts
[[OSPF]]
[[RIP]]
[[DUAL Algorithm]]
[[Routing Protocol Authentication]]
[[Route Injection Attacks]]
[[Man-in-the-Middle Attacks]]
[[VLSM and CIDR]]
[[Multicast Routing]]
[[Convergence Time]]
[[Passive Interface]]