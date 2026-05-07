# OSPF

## What it is

OSPF (Open Shortest Path First) is the GPS app that every router inside one company uses to agree on the fastest route to every destination — except instead of Google Maps downloading map data from a server, every router in the network constantly broadcasts its own slice of the map to every other router, and they each compute the shortest path locally.

Technically: OSPF is a **link-state interior gateway protocol (IGP)**. "Link-state" means every router knows the entire topology of the network, not just rumors from its neighbors. "Interior gateway" means it operates *inside* a single autonomous system (AS) — one organization's routing domain — not between ISPs on the public internet.

Each router floods information about its directly connected links to all other OSPF routers. Once everyone has the same map, they each independently run **Dijkstra's algorithm** to compute the shortest path to every destination. Same input, same algorithm, same answer — the network converges on a consistent view of reality.

## Why it matters

OSPF is the routing brain of most medium-to-large enterprise networks. If it lies, the network lies. And OSPF has a couple of properties that make it a juicy target.

First, it doesn't ride on TCP or UDP — it talks **IP protocol 89 directly**. This is like a process on your machine that doesn't open a port, so `netstat` shows nothing and your port-based firewall rules don't catch it. If your firewall is configured to "block weird traffic on weird ports," congratulations, OSPF sails right past because there is no port to block. You have to filter protocol 89 explicitly.

Second, without authentication, OSPF trusts anyone who shows up speaking the protocol. It's the Among Us problem: if there's no vote, no verification, the impostor just walks into the meeting and starts voting. Plug a malicious device into a network segment where OSPF is running and it can announce itself as a router, advertise routes, and quietly redirect traffic through itself — classic **route injection** for man-in-the-middle.

## Key facts

### Protocol mechanics
- **Link-state, not distance-vector** — every router builds a full topological map, then runs Dijkstra's shortest-path algorithm locally. Like every player in Helldivers 2 having the same minimap synced in real time, then each picking their own route to the objective.
- **IP protocol 89, no TCP/UDP** — OSPF rides directly on IP. No port numbers exist to firewall against. If your ACLs are port-based only, OSPF traffic is invisible to them.
- **Hello packets** establish and maintain neighbor adjacency. Routers send Hellos periodically; if Hellos stop, the neighbor is declared dead and the topology recomputes. Think of it as the heartbeat ping in a multiplayer lobby — miss too many and you get dropped.
- **Multicast 224.0.0.5** is the destination address for Hello packets — the "all OSPF routers" channel. No need to know your neighbors in advance; you shout into the OSPF-only group chat and whoever's listening responds.

### Areas and the backbone
- OSPF organizes routers into **areas** to keep the topology database manageable. Each area is a sub-region of the AS.
- **Area 0 is the backbone**. Every other area must connect to Area 0. It's the central hub raid in an MMO — every wing of the dungeon eventually funnels back to it.
- **Compromising a backbone router is catastrophic** — it sees and influences topology for every connected area. Owning a backbone router is owning the network's nervous system.

### Authentication
- OSPF supports **MD5** and **SHA** authentication for neighbor relationships. These prevent random devices from forming adjacencies and injecting routes.
- **Without authentication, OSPF trusts anyone speaking the protocol.** A laptop running an OSPF daemon on the right segment becomes a "trusted" router. This is the default-open-server problem: if you don't put a password on it, the lobby is public.

### Attack surface
- **Route injection** — a malicious router advertises bogus routes (e.g., "I'm the best path to 10.0.0.0/8"), poisoning the routing tables of legitimate routers. Traffic gets pulled through the attacker's box. It's the Watch Dogs scenario where ctOS reroutes a target's traffic through a node you control.
- **Hello spoofing** — forging or flooding Hello packets can flap adjacencies, force constant reconvergence, and degrade or break routing entirely. A denial-of-service against the topology itself.
- **Mitigations**: enable MD5/SHA authentication on every adjacency, filter IP protocol 89 at trust boundaries, configure passive interfaces on segments where OSPF has no business running (user VLANs, server VLANs), and treat backbone routers as crown-jewel assets.

## Related concepts
- [[Dijkstra's algorithm]]
- [[Interior Gateway Protocol (IGP)]]
- [[Autonomous System (AS)]]
- [[EIGRP]]
- [[BGP]]
- [[RIP]]
- [[Routing table poisoning]]
- [[Man-in-the-Middle attack]]
- [[Multicast addressing]]
- [[Network reconnaissance]]
- [[Passive interface configuration]]