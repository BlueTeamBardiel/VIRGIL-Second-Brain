# OSPFv3

## What it is

OSPFv3 is what happens when OSPF gets a full character reroll for the IPv6 era — same link-state archetype, completely rewritten skill tree. The original OSPF (v2) was built when IPv4 was the only thing that mattered, and IPv6 addresses were stapled on awkwardly. OSPFv3 starts over: the protocol logic is separated from the addressing, so the routing brain doesn't care whether it's carrying IPv4, IPv6, or both — kind of like how a modern game engine renders the same scene to different displays without rewriting the engine.

Technically, OSPFv3 is a link-state interior gateway protocol operating at Layer 3, running directly on top of IPv6 as protocol number 89 (no UDP, no TCP — it sits right on the network layer like ICMP does). Each router floods Link-State Advertisements (LSAs) describing its local links, every router builds an identical Link-State Database (LSDB), and Dijkstra's algorithm calculates shortest paths from that map.

The big architectural shift: addressing was **decoupled from protocol logic**. The neighbor-finding, adjacency-forming, and SPF-calculating machinery doesn't have IPv6 hardcoded into it — IPv6 is just one address family it can carry. That's why a single OSPFv3 instance can haul both IPv4 and IPv6 routes simultaneously.

## Why it matters

If OSPF is the GPS for your internal network, OSPFv3 is the GPS that actually knows IPv6 streets exist. As enterprises and ISPs migrate to dual-stack or IPv6-only, you can't keep running OSPFv2 forever — it physically cannot describe a 128-bit address in its native LSAs.

But here's the catch that should make any blue-teamer twitch: **OSPFv3 ripped out its own authentication**. OSPFv2 had built-in MD5/SHA auth fields. OSPFv3 said "not my problem" and handed the entire job to IPsec (per RFC 4552). That's elegant in theory — why reinvent crypto when IPv6 already mandates IPsec support? — but in practice, if your IPsec policy is missing, misconfigured, or just never turned on, your routing fabric is wide open. A rogue router on the segment can flood crafted LSAs into the LSDB, and every router in the area will recompute SPF using the attacker's lies. That's **route injection** / **LSA poisoning**, and the payoff is traffic getting funneled through an attacker-controlled hop — the networking equivalent of a Watch Dogs ctOS hijack where Aiden reroutes the city's traffic lights to send a target down the alley he's waiting in.

## Key facts

### Protocol mechanics
- **IPv6-native rewrite** — same link-state DNA as OSPFv2, but rebuilt for 128-bit addresses from the ground up.
- **Runs on IP protocol 89** — directly over IPv6, no transport layer in between. Like a melee weapon — no ammo dependency, just hits the network layer.
- **Address-family agnostic** — protocol logic is decoupled from addressing, so one instance can carry IPv4 *and* IPv6 simultaneously. Think of it as a class that can equip multiple weapon types in one loadout.

### Neighbor formation
- **Adjacencies form using link-local addresses** (`fe80::/10`), not global unicast. Like party-finder in Elden Ring only working with players in your local network range — neighbors only need to be reachable on the shared link.
- **FF02::5** — AllSPFRouters multicast. The "everyone in this voice channel" address for OSPF speakers on a link.
- **FF02::6** — AllDRRouters multicast. The DR/BDR-only side channel, like a squad-leader-only ping in Helldivers 2.

### Authentication
- **No built-in auth** — fields stripped from the protocol entirely.
- **Delegated to IPsec** per RFC 4552 — uses AH or ESP headers to authenticate (and optionally encrypt) OSPFv3 packets.
- **Misconfigured IPsec = no auth at all** — like enabling 2FA in your settings but never finishing the setup wizard. The protocol will happily form adjacencies with anyone.

### Attack surface
- **Rogue router LSA injection** — a malicious neighbor floods crafted LSAs claiming it has a great path to some prefix. Every router in the area trusts the LSDB and recomputes SPF.
- **LSA poisoning outcome** — traffic flows along attacker-chosen paths. Sniff it, modify it, drop it — same playbook as a BGP hijack but inside your AS.
- **Mitigation** — actually deploy IPsec on OSPFv3 adjacencies, lock down which interfaces speak OSPF, and treat any unauthenticated OSPFv3 segment as a trust boundary you don't have.

## Related concepts
- [[OSPFv2]]
- [[Link-State Routing]]
- [[LSA (Link-State Advertisement)]]
- [[Dijkstra's SPF Algorithm]]
- [[IPv6]]
- [[Link-Local Addresses]]
- [[IPv6 Multicast Scopes]]
- [[IPsec AH and ESP]]
- [[RFC 4552]]
- [[Route Injection Attacks]]
- [[BGP Hijacking]]
- [[Designated Router / Backup Designated Router]]