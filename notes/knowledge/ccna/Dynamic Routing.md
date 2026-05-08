# Dynamic Routing

## What it is

In Need for Speed, the cops have a live spotter network — every cruiser that sees you radios your position, your heading, your heat level, and the whole pursuit grid updates in real time. Compare that to a single dispatcher reading from a printed map of last week's roadblocks: useless the moment you take a side street. That's exactly what dynamic routing does — routers gossip with their neighbors constantly, so when a road closes the whole network knows within seconds.

Dynamic routing is the process where routers automatically exchange topology information and build their routing tables without an admin manually typing in every path. Routers run a **routing protocol** — a standardized language for chatting with neighbors — that lets them advertise reachable networks, learn what their neighbors can reach, calculate the best paths, and react when something breaks.

Compare that to **static routing**, where an admin hand-configures every single route. If a link dies, only the router directly attached to the dead link knows. Every other router keeps cheerfully forwarding packets to a next-hop that's been gone for an hour — like the rest of the NFS pursuit AI still converging on your last known location while you've already swapped cars at the safehouse and changed plates.

## Why it matters

Networks fail. Cables get unplugged, switches reboot, ISPs have bad days. In a static-routed network, every alternate path has to be pre-configured by a human who correctly predicted every failure mode — which is roughly as realistic as no-hit Elden Ring on your first try. Dynamic routing detects failures in seconds and propagates the change across the whole topology automatically.

The tradeoff: dynamic routing burns CPU, memory, and bandwidth to maintain those neighbor relationships. So static routing still wins for tiny networks and **stub networks** (a network with only one way in or out — there's literally no alternate path to calculate). Dynamic routing wins anywhere redundancy exists, which is most enterprise networks.

**Convergence** — every router agreeing on the current shape of the network — is the goal. Until convergence happens, you can have black holes, loops, or packets taking absurd detours. Convergence times range from a few seconds (EIGRP, OSPF) to a few minutes (BGP across the internet).

## Key facts

### Protocol families

Routing protocols split along two axes: scope and algorithm.

**Scope:**
- **IGP (Interior Gateway Protocol)** — runs *inside* one organization's network (one autonomous system). Like coordinating loadouts inside your own Apex squad.
- **EGP (Exterior Gateway Protocol)** — runs *between* organizations. Like negotiating a temporary alliance between two squads in a battle royale.
- **BGP** is the only EGP still in use. It literally runs the entire internet.

**Algorithm:**
- **Distance vector** — routers tell their neighbors "I can reach Network X, and it's this far away." Neighbors trust them and pass the rumor along. It's the telephone game with math. Uses the **Bellman-Ford algorithm**. Prone to routing loops because nobody sees the full map.
- **Link state** — every router floods detailed topology info to *every* other router in the area, so each one builds a complete map and runs **Dijkstra's algorithm** to compute its own shortest paths. More bandwidth overhead, but inherently loop-free because everyone has the same map.

### The protocols themselves
- **RIPv1 / RIPv2** — legacy distance vector. Metric is **hop count**. Mostly a museum piece.
- **EIGRP** — Cisco's proprietary distance vector. Composite metric based on bandwidth and delay. Excellent scalability, fast convergence.
- **OSPFv2 (IPv4) / OSPFv3 (IPv6)** — open standard link state. Most common enterprise IGP.
- **IS-IS** — link state, less common in enterprise, beloved by ISPs.
- **BGP** — the EGP. Path-vector protocol that uses AS path length as its primary metric.

### Administrative Distance (AD)
The router's trust ranking when it learns the same destination from multiple sources. Like having multiple buddies in your Discord recommending a build for your character — you trust the diamond-ranked friend over the bronze one.

- Range: 0 to 255. **Lower = more trusted.**
- **0** — directly connected (you can see it with your own eyes)
- **1** — static route (the admin said so)
- **20** — BGP external
- **90** — EIGRP
- **110** — OSPF
- **120** — RIPv2
- **255** — never use this route

If two routes to the same destination exist with different ADs, the lower AD wins, full stop.

### Metric (the tiebreaker)
When two routes share the same AD (same protocol, multiple paths), the **metric** decides. Lower metric wins.

- **RIPv2** — hop count (number of routers crossed). Crude.
- **EIGRP** — composite of bandwidth and delay.
- **OSPF** — cost = 100,000 / interface bandwidth. Faster link = lower cost.
- **BGP** — multiple attributes, AS path length being the headline metric.

### Longest Prefix Match (LPM)
A packet for 10.0.5.42 might match three table entries: 10.0.0.0/8, 10.0.0.0/16, and 10.0.5.0/24. LPM picks the most specific one — the /24. It's the GPS-routing-rule version of "the more specific instruction wins." Search aimbot in CS2 — it locks onto the tightest target available.

### Configuration essentials
- The `network` command activates a routing protocol on specific interfaces.
- **OSPF** needs a *process ID* (locally significant) and an *area ID* (must match neighbors).
- **EIGRP** needs an *AS number* (must match neighbors).
- **Wildcard masks** (inverted subnet masks) are used inside the `network` command to specify which interfaces participate.

### Failure behavior
- A router drops a route if it can't reach the next-hop IP.
- Static: only the directly-attached router notices. Everyone else keeps forwarding into the void.
- Dynamic: failure detection in seconds, automatic propagation, automatic reroute if an alternate path exists.

## Related concepts
[[OSPF]]
[[EIGRP]]
[[BGP]]
[[Static Routing]]
[[Routing Table]]
[[Autonomous System]]
[[Convergence]]
[[Administrative Distance]]
[[Longest Prefix Match]]
[[Dijkstra's Algorithm]]
[[Bellman-Ford Algorithm]]
[[Wildcard Masks]]