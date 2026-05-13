# Routing Technologies

## What it is

In **Mass Effect**, the galaxy map shows you every cluster, system, and planet you could fly the Normandy to. You pick Eden Prime, the navigator plots a path through the relay network, and Joker burns fuel to get you there. Some routes Shepard knows by heart — Citadel, Omega, the Citadel again. Others the EDI-equivalent calculates on the fly based on which mass relays are active, which Reaper-occupied systems to avoid, and what the shortest fuel cost is. That's exactly what routing does — it decides which path a packet takes to get from where it is to where it needs to go.

A **router** is a Layer 3 device that forwards packets between networks by consulting a **routing table**. The routing table is the galaxy map. Each entry says: "to reach this destination network, send the packet out this interface, toward this next hop." Routes get into that table two ways: an admin types them in (**static**), or the router learns them by talking to other routers (**dynamic**). Everything in objective 2.1 is a variation on how those routes get learned, ranked, and selected.

## Why it matters

Routing is the heart of the network. Switches move frames around a single segment; routers move packets between segments, across the WAN, across the internet. Every time you load a webpage, your packet hits a half-dozen routers before it gets to the server. When routing breaks, the internet breaks — for you, for your office, sometimes for entire countries (see: any BGP outage news story).

Net+ leans hard on objective 2.1. Expect questions on administrative distance values, OSPF vs EIGRP vs BGP characteristics, NAT vs PAT, and route selection logic. The exam loves to give you two valid routes and ask which one wins. Know the tiebreakers cold.

## Key facts

### Static vs dynamic routing

**Static routing** is hand-typed. Admin logs into the router and says "to reach 10.20.0.0/16, send it to 192.168.1.1." That route sits there forever until someone deletes it. No CPU cost, no bandwidth cost, no protocol chatter. Predictable. Brittle.

**Dynamic routing** is routers gossiping. They run a protocol — OSPF, EIGRP, BGP — and tell each other "hey, I can reach these networks at this cost." The routing table updates itself when links go down or new networks appear. CPU cost, bandwidth cost, complexity cost. Resilient.

| Factor | Static | Dynamic |
|---|---|---|
| Configuration | Manual per route | Configure protocol once |
| Scalability | Small networks (< 10 routes) | Enterprise to internet scale |
| Convergence on failure | None — admin must fix | Automatic |
| Overhead | Zero | CPU, RAM, bandwidth |
| Use case | Stub networks, default routes, DMZ | Anything that changes |

*Static for the predictable, dynamic for the alive.* Most real networks use both — static default routes pointing at the ISP, dynamic protocols inside the enterprise.

### Dynamic routing protocols

Three you must know cold for N10-009:

**OSPF (Open Shortest Path First)** — link-state, open standard, runs everywhere. Every router builds a complete map of the area (the LSDB, link-state database) and runs Dijkstra's algorithm to find the shortest path. **Metric: cost**, derived from interface bandwidth. Fast convergence. Hierarchical with areas (Area 0 is the backbone). Used inside enterprises.

**EIGRP (Enhanced Interior Gateway Routing Protocol)** — Cisco-developed, now an open standard but still mostly Cisco shops. Advanced distance-vector (Cisco calls it "hybrid"). **Metric: composite** based on bandwidth, delay, reliability, load (default uses bandwidth + delay). Very fast convergence via DUAL algorithm. Easier to configure than OSPF.

**BGP (Border Gateway Protocol)** — the protocol that runs the internet. Path-vector. ISPs and large enterprises use BGP to exchange routes between **autonomous systems (AS)**. **Metric: path attributes** (AS path length, local preference, MED, origin — not a single number). Slow convergence by design — BGP prioritizes stability over speed. When BGP misconfigures, half the internet sees it (Facebook, October 2021).

| Protocol | Type | Metric | Scope | Standard |
|---|---|---|---|---|
| **OSPF** | Link-state | Cost (bandwidth) | Interior (within AS) | Open (IETF) |
| **EIGRP** | Advanced distance-vector | Composite (BW + delay) | Interior | Cisco / open |
| **BGP** | Path-vector | Path attributes | Exterior (between AS) | Open (IETF) |
| **RIP** | Distance-vector | Hop count (max 15) | Interior, legacy | Open |

### Administrative distance

When a router learns the same destination from two different sources — say, a static route AND OSPF — it has to pick one. **Administrative distance (AD)** is the trust ranking. Lower AD wins.

| Source | AD |
|---|---|
| Directly connected | 0 |
| Static route | 1 |
| BGP (external/eBGP) | 20 |
| EIGRP (internal) | 90 |
| OSPF | 110 |
| RIP | 120 |
| BGP (internal/iBGP) | 200 |
| Unknown / unreachable | 255 |

A static route (AD 1) will always beat an OSPF-learned route (AD 110) to the same destination, even if OSPF has better information about the topology. *AD is how the router decides which teacher to believe.*

### Prefix length and route selection

Administrative distance is the second tiebreaker. The **first** tiebreaker — and this trips people up — is **prefix length**. The router always picks the **longest prefix match** (most specific route) regardless of AD or metric.

Example: routing table has both:
- `10.0.0.0/8` via OSPF
- `10.20.30.0/24` via RIP

Packet for `10.20.30.55` goes via RIP, because `/24` is more specific than `/8`. AD doesn't enter the conversation. The router only consults AD when comparing routes with the **same prefix length**.

**Full route selection order:**

1. **Longest prefix match** wins. Always.
2. Among equally-specific routes, **lowest AD** wins.
3. Among same-AD routes (same protocol), **lowest metric** wins.
4. Among equal-metric routes, **load-balance** across both (ECMP).

> **CompTIA exam trap:** A question shows you a routing table with a static route to `10.0.0.0/8` and an OSPF route to `10.1.1.0/24`. The packet is destined for `10.1.1.5`. The obvious answer is "static, because AD=1 beats AD=110." Wrong. The OSPF route is more specific. Longest prefix match always wins before AD is even consulted.

### NAT and PAT

**Network Address Translation (NAT)** rewrites IP addresses as packets cross a boundary — typically the boundary between your private network (RFC 1918: 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) and the public internet. Your laptop is `192.168.1.42`; the internet sees the packet coming from your router's public IP. Replies come back to the router, which translates back to `192.168.1.42`.

**Port Address Translation (PAT)** — also called **NAT overload** — is what your home router actually does. Many private IPs share one public IP, distinguished by source port number. Laptop on port 51000, phone on port 51001, smart fridge on port 51002 — all mapped to the public IP on different external ports. The router keeps a translation table and untangles return traffic by port.

| Type | Mapping | Use case |
|---|---|---|
| **Static NAT** | One private ↔ one public | Internal server reachable from internet |
| **Dynamic NAT** | Pool of private ↔ pool of public | Rare today |
| **PAT (NAT overload)** | Many private → one public, via ports | Every SOHO router on earth |

NAT is why IPv4 didn't die in 2005. It's also why hosting a [[Minecraft]] server for friends requires port forwarding — the router has no return mapping for unsolicited inbound traffic, so you have to create one manually. *NAT broke the end-to-end principle of the internet, and we've been working around it ever since.*

### FHRP and Virtual IP

**First Hop Redundancy Protocol (FHRP)** is how you eliminate the default gateway as a single point of failure. Two routers share a **Virtual IP (VIP)** and a virtual MAC. Clients use the VIP as their default gateway. One router is active; the other stands by. If the active dies, standby takes over the VIP within seconds. Clients never notice — they're still pointed at the same VIP.

Common implementations:
- **HSRP** — Hot Standby Router Protocol (Cisco)
- **VRRP** — Virtual Router Redundancy Protocol (open standard)
- **GLBP** — Gateway Load Balancing Protocol (Cisco, also load-balances)

*A FHRP is a firewall-equivalent move for routing: don't let the most-used device be the most fragile.*

### Subinterfaces

A **subinterface** is a logical interface carved out of a physical one, typically tagged for a specific VLAN. Classic use case: **router-on-a-stick**. One physical link to a switch carrying multiple VLANs as 802.1Q tags. The router has `GigabitEthernet0/0.10` for VLAN 10, `GigabitEthernet0/0.20` for VLAN 20, each with its own IP in the appropriate subnet. The router routes between VLANs over a single cable.

Layer-3 switches mostly replaced router-on-a-stick in modern networks, but subinterfaces are still everywhere on WAN edges, hypervisors, and any device with limited physical ports.

### CompTIA exam traps

> **Exam trap — AD vs metric:** AD compares routes from **different** sources. Metric compares routes from the **same** source. Don't mix them. OSPF cost is not comparable to EIGRP composite metric — the router uses AD to decide which protocol wins, then uses that protocol's metric internally.

> **Exam trap — NAT vs PAT:** If the question says "many internal hosts share one public IP," it's PAT, not NAT. Plain "NAT" on the exam usually means one-to-one. If you see port numbers in the translation table, it's PAT.

> **Exam trap — BGP scope:** BGP is the only **exterior** gateway protocol on the exam. OSPF, EIGRP, RIP are all **interior**. If the question mentions autonomous systems or ISPs, the answer is BGP.

## Helpdesk reality

- User says "the internet is slow but the intranet is fast" — routing issue at the edge, not the LAN. Traceroute from the user out to `8.8.8.8` and find where the latency jumps. Usually the ISP, sometimes a misbehaving default route.
- User says "I can't reach the new branch office" — somebody added a subnet and forgot to redistribute it into OSPF, or the static route is missing. Check the routing table on the gateway. `show ip route` is your friend.
- Never promise "it'll route around the failure instantly." Convergence takes seconds to minutes depending on protocol and topology. BGP can take *minutes* to settle after a major change.
- Port-forwarding tickets from remote workers hosting game servers from home — explain PAT, explain that the router has no inbound mapping, point them at their home router admin page. This is not a corp-IT problem but you'll get the ticket anyway.
- Escalation point: if you've confirmed L1 (link), L2 (ARP), and the client's L3 (IP, mask, gateway) are all sane, and the gateway is pingable but destinations aren't — it's a routing problem upstream. Network team ticket.

## Related concepts

[[OSI Model]] · [[IPv4 Addressing]] · [[IPv6 Addressing]] · [[Subnetting]] · [[VLANs]] · [[Default Gateway]] · [[ARP]] · [[Traceroute]] · [[Autonomous System]] · [[Network Segmentation]] · [[High Availability]]

*Source: VIRGIL knowledge base — 2026-05-11*