# Network Routing

## What it is

In Bioshock, you wander Rapture following a glowing arrow that bends around corners, through vents, and across collapsed corridors to wherever your next objective lives. That's exactly what routing does — every packet has a destination, and each router along the way figures out which door to shove it through next.

When your laptop sends a packet to a server across the internet, that packet hops through a chain of routers. Each router consults its **routing table** — a lookup sheet of "if the destination looks like X, send it out interface Y toward next-hop Z" — and forwards the packet one step closer. The routing table is the router's strategy guide; without it, the router is just an expensive paperweight.

How those tables get filled is the whole game:

- **Static routes** are hand-written rules. Like the fixed pneumo tubes in Rapture — Andrew Ryan laid them down once, and they go where they go. If the tube is severed, mail piles up until someone physically rebuilds it.
- **Dynamic routes** are filled in by protocols (OSPF, RIP, BGP) that gossip with neighboring routers and rebuild the map automatically when the topology shifts. Think of the quest arrow in Bioshock recalculating the moment a bulkhead seals — routers exchange updates so every node's view of the city stays current.

## Why it matters

Routing is the load-bearing wall of the internet, and a lot of it runs on trust that hasn't aged well.

BGP — the protocol that stitches the entire public internet together — was designed in an era where every network operator was assumed to be honest. That assumption is doing a lot of heavy lifting. When routing breaks or gets manipulated, traffic for entire countries can vanish, get rerouted through a hostile network, or pile up in a black hole. It's the equivalent of someone in Among Us convincing the crew that the route to electrical goes through their kill room.

For defenders, understanding routing is how you reason about: where your traffic actually goes, who could intercept it, why a service suddenly became unreachable, and how to detect when someone is lying about who they are on the network.

## Key facts

### Routing table mechanics

- Routers consult the **routing table** on every packet to pick the next hop. It's the decision tree the router runs through millions of times per second.
- **Static routes**: manually configured, zero adaptation. Reliable in tiny stable networks, a maintenance nightmare anywhere else.
- **Dynamic routes**: protocols like OSPF and RIP keep the table fresh automatically when links go up or down.

### TTL — the anti-loop seatbelt

- Every IP packet carries a **TTL (Time to Live)** counter in its header. Each router that forwards it subtracts one — like the stamina meter draining in Tears of the Kingdom every time Link climbs another ledge.
- When TTL hits zero, the packet is dropped. The router then sends an **ICMP Time Exceeded** message back to the original sender (this is exactly how `traceroute` maps the path — it intentionally ships packets with tiny TTLs to make each hop announce itself).
- The whole point: if a routing misconfiguration creates a loop, packets don't circulate forever clogging the network — they self-destruct.

### Interior protocols: OSPF and RIP

- **OSPF (Open Shortest Path First)** is a **link-state** protocol. Every router builds a full topology map of the area, like every player on a Counter-Strike 2 team having the complete callout map memorized, then computes shortest paths from that map.
- **RIP (Routing Information Protocol)** is a **distance-vector** protocol. Routers don't know the full map — they only know "destination X is N hops away through neighbor Y," gossiped from their neighbors. Simpler, slower to converge, and capped at 15 hops.

### BGP — the internet's group chat

- **BGP (Border Gateway Protocol)** is *the* routing protocol of the public internet. It connects **autonomous systems** (ASes) — the big networks run by ISPs, cloud providers, universities, governments.
- Runs over **TCP port 179**.
- Operates on an **honor system**. By default there's no built-in authentication of route announcements — if an AS announces "hey, I own these IP ranges, send traffic to me," peers tend to believe it. It's Discord with no moderators.

### BGP hijacking

- A **BGP hijack** happens when an AS (malicious or just badly misconfigured) advertises routes for IP space it doesn't own. Traffic destined for the real owner gets pulled toward the attacker — equivalent to someone in a Watch Dogs 2 mission spoofing a cell tower so your phone connects to theirs instead of the legit one.
- Consequences: traffic interception (mass surveillance, credential theft), redirection through hostile geography, or **black-holing** (traffic gets dropped, services go dark).
- Famous real-world incidents have knocked major services offline for hours.

### RPKI — actually checking IDs at the door

- **RPKI (Resource Public Key Infrastructure)** is the fix layered on top of BGP. IP block owners cryptographically sign statements saying "AS 12345 is authorized to announce this prefix." Routers can validate incoming BGP announcements against these signatures and reject the fakes.
- It's the verified-checkmark system for route announcements. Doesn't fix every BGP problem, but it kills the easiest hijacks dead.

### Routing table poisoning

- Dynamic routing protocols (OSPF, RIP, BGP) can be attacked by **injecting false route information** — feeding lies directly into the gossip layer.
- A poisoned table can **redirect traffic** through an attacker (man-in-the-middle position) or **black-hole** it (advertise a fake "best path" that goes nowhere). Same playbook as a Helldivers 2 stratagem beacon getting kicked into a wall — everything aimed at it just gets wasted.
- Mitigations: authenticate routing protocol peers (MD5/IPsec on OSPF, RPKI on BGP), filter accepted routes, and monitor for suspicious advertisements.

## Related concepts

[[Autonomous Systems]] · [[OSPF]] · [[BGP]] · [[RPKI]] · [[ICMP]] · [[Traceroute]] · [[IP Header]] · [[Default Gateway]] · [[Route Filtering]] · [[MITM Attacks]] · [[DDoS via Black-holing]]