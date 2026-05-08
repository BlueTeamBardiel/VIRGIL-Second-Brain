# Routing Protocol

## What it is

In DOTA, your team's minimap pings constantly — supports calling missing mids, allies revealing rune spawns, scans exposing smoke ganks, every hero feeding their vision into a shared map that updates in real time. That's exactly what a routing protocol does — routers gossip with their neighbors about what networks they can reach, and each router builds its own minimap of the entire topology, then picks the fastest lane to every destination.

More precisely: routing protocols are the agreed-upon rules that let routers **dynamically discover** network paths and **calculate the optimal route** to forward packets. Without them, you're stuck manually typing static routes into every router — the equivalent of playing DOTA with no minimap and no comms, hand-drawing where Roshan spawns on a sticky note.

They split into two leagues:

- **Interior Gateway Protocols (IGPs)** — used *inside* one organization's network. OSPF and EIGRP live here. Like team voice chat: only your four teammates hear the calls.
- **Exterior Gateway Protocols (EGPs)** — used *between* autonomous systems (the giant networks owned by ISPs, cloud providers, universities). BGP is the only one that matters. Like all-chat: every player on the server sees it, and one bad message can tilt the entire match.

## Why it matters

The entire internet's path-finding runs on these protocols, and historically, several were designed in an era when "trust" was the default setting. That assumption is the security hole.

When a routing protocol gets attacked, three nasty things can happen:

- **Black-holing** — traffic gets routed to a router that just drops it. Your packets walk into the void, like throwing items off the cliff in Breath of the Wild.
- **Sniffing/redirection** — an attacker advertises themselves as the best path, and now all your traffic flows through their box on the way to the real destination. Classic Watch Dogs ctOS scenario: hijack the infrastructure, watch everything.
- **Network partitioning** — bad routes split the network into chunks that can't reach each other, like a raid wipe where half the party gets disconnected.

This is why the BGP hijacks that occasionally make headlines (an ISP in one country accidentally — or "accidentally" — announcing they own YouTube's IP space) can knock services offline for hours.

## Key facts

### The big four protocols

- **OSPF (Open Shortest Path First)** — IGP. Uses link-state: every router floods info about its links, everyone builds the same map, then runs Dijkstra's algorithm to find shortest paths. Supports **MD5 or SHA cryptographic authentication** on routing updates, so a rogue router can't just walk up and inject lies — it needs the shared key, like needing the Discord server invite to even join the conversation.
- **EIGRP** — IGP. Cisco's hybrid protocol, uses the DUAL algorithm. Lives inside one organization.
- **RIP (Routing Information Protocol)** — IGP. The boomer of routing protocols. Uses **hop count** as its only metric — fewest routers between you and the destination wins. This is dumb because a 4-hop path over fiber beats a 2-hop path over a saturated DSL line, but RIP doesn't care. Vulnerable to **route poisoning attacks**, where an attacker injects fake routes with attractive hop counts to lure or kill traffic.
- **BGP (Border Gateway Protocol)** — the EGP. Glues the entire internet together by exchanging reachability info between autonomous systems (ASes). Every time your packet leaves your ISP, BGP decided where it goes next.

### BGP's security problem

- **Historically had no built-in authentication.** When BGP was designed, the internet was a small club where everyone knew everyone. Announcing "hey I own this IP range" was taken at face value — like an Among Us lobby where nobody can call out impostors.
- **Prefix hijacking** — an AS announces IP prefixes it doesn't actually own. Other ASes believe it, traffic gets redirected. Has happened to Google, Cloudflare, crypto exchanges (often profitably for the attacker).
- **RPKI (Resource Public Key Infrastructure)** — the modern defense. A cryptographic system where IP prefix owners publish signed records (ROAs — Route Origin Authorizations) saying "this AS is allowed to announce this prefix." Routers that validate against RPKI reject hijack announcements. It's account verification for IP space — the blue checkmark of routing.

### Attack outcomes (worth memorizing)

- Traffic black-holing (packets dropped silently)
- Traffic sniffing and redirection (man-in-the-middle on a continental scale)
- Network partitioning (segments isolated from each other)

## Related concepts

[[OSPF]]
[[BGP]]
[[RPKI]]
[[Autonomous System]]
[[Prefix Hijacking]]
[[Route Poisoning]]
[[MD5 Authentication]]
[[Static Routing]]
[[Dijkstra's Algorithm]]