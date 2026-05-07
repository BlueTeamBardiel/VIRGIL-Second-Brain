# Routing Table

## What it is

A routing table is the GPS app inside every router and computer — a list of known destinations with directions on how to get there. When you tell Google Maps "take me to LAX," it doesn't load every street in California; it picks the best matching route from what it knows. A router does the same thing, except instead of streets it knows networks, and instead of "fastest route" it picks the most specific match.

Technically, a routing table is a data structure stored on a router (or any host with a network stack) that lists known network destinations and the next hop a packet should take to reach each one. Every single packet that hits the router gets looked up against this table based on its destination IP address. No table entry that matches? The packet gets dropped — or punted to a default route if one exists.

Each entry in the table contains five core fields:
- **Destination network** — where you're trying to go (e.g., 10.0.0.0)
- **Subnet mask** — how specific that destination is (e.g., /24)
- **Next-hop address** — the IP of the next router along the way
- **Interface** — which physical/logical port to send the packet out of
- **Metric** — how "expensive" this route is, used to break ties between multiple paths

## Why it matters

The routing table is the brain stem of the network. Corrupt it and you don't need to break encryption, phish a user, or pop a shell — every packet on the network now goes wherever you tell it to. It's the netrunner fantasy from Cyberpunk 2077: instead of attacking one target, you reroute the whole district's traffic through your own node and read everything in transit.

This is a network-layer attack, which means it sails right past host-based controls. Your endpoint EDR doesn't care that the packet leaving your NIC is taking a scenic detour through a hostile AS in another country. The packet looks fine. The destination IP is correct. It's just… going somewhere it shouldn't first.

The 2010 China Telecom incident is the textbook real-world example: a BGP route leak caused roughly **15% of global internet traffic** — including traffic to and from US government and military domains — to be rerouted through Chinese networks for about 18 minutes. No malware. No exploits. Just bad routes accepted as truth.

## Key facts

### Anatomy of a route lookup

- **Longest prefix match wins.** If a packet headed to 10.0.0.5 matches both `10.0.0.0/24` and `10.0.0.0/16`, the /24 wins — it's more specific. Like loot priority in Escape from Tarkov: the more specific tag (your squad's callsign) beats the generic one (faction).
- **Default route = `0.0.0.0/0`.** The catch-all, the "I have no idea, just send it upstream" entry. Same energy as the `default:` case in a switch statement, or your friend group's one person who knows somebody who knows somebody.
- Lookup happens **on every packet**. There's no "remember this for me" cache at the routing-decision level by default — though hardware shortcuts like CEF exist on real gear.

### How routes get into the table

- **Static routes** — manually typed in by an admin. They don't adapt. If the next hop dies, the route stays in the table pointing at a corpse. Like hardcoding a teammate's IP in a Minecraft server config — works until they change ISPs.
- **Dynamic routes** — learned automatically from neighbors via routing protocols:
  - **RIP** — old, simple, hop-count based, mostly retired
  - **OSPF** — link-state, fast convergence, used inside organizations
  - **EIGRP** — Cisco's hybrid, also internal
  - **BGP** — the protocol that glues the entire internet together between ISPs and large orgs

### Route injection attacks

- **Route injection** = advertising fake routes into a routing protocol so other routers accept and install them. The router has no built-in way to know if a BGP advertisement is a lie — it's basically Among Us at internet scale, and historically there were no emergency meetings.
- Two main payoffs for the attacker:
  - **MITM interception** — pull traffic through your network, read it, then forward it on so nobody notices the latency bump
  - **Blackholing** — advertise a route then drop everything that arrives, a denial-of-service via misdirection
- BGP and RIP are the usual injection vectors because they accept routes from peers with limited validation by default.

### Defenses

- **Route filtering** — only accept advertisements for prefixes a peer is actually authorized to announce. Like an allowlist for which channels a Discord bot can post in.
- **RPKI (Resource Public Key Infrastructure)** — cryptographic prefix validation. Each prefix is signed by its legitimate owner; routers can reject unsigned or mismatched announcements.
- **Monitoring** — tools that watch for unexpected origin AS changes, sudden prefix appearances, or traffic-pattern anomalies. The "wait, why is our traffic suddenly going through Belarus" alarm.
- **Peer authentication** (MD5/TCP-AO on BGP sessions) so randoms can't just open a session and start lying.

## Related concepts

[[BGP]] · [[OSPF]] · [[RIP]] · [[EIGRP]] · [[RPKI]] · [[Longest Prefix Match]] · [[Default Gateway]] · [[Static vs Dynamic Routing]] · [[Route Hijacking]] · [[Man-in-the-Middle Attack]] · [[Blackhole Routing]] · [[Autonomous System (AS)]] · [[CIDR and Subnetting]]