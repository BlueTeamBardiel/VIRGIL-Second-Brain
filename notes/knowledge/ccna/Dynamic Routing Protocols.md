# Dynamic Routing Protocols

## What it is

A guild in an MMO where every player automatically shares the location of every quest, dungeon, and shortcut they discover — without anyone manually updating a spreadsheet. New shortcut found? Everyone's map updates. A bridge gets destroyed? Everyone reroutes. That's a dynamic routing protocol, except the guild members are routers and the quests are network destinations.

Technically, dynamic routing protocols are Layer 3 (Network Layer) mechanisms that let routers exchange routing table information with each other, automatically discover paths to remote networks, and adapt when links fail or topology changes — all without an admin manually punching in static routes on every device.

They split into two camps based on scope:

- **Interior Gateway Protocols (IGPs)** run *inside* a single organization's network — your guild's internal chat. **OSPF** and **EIGRP** live here.
- **Exterior Gateway Protocols (EGPs)** run *between* organizations — the cross-server global trade chat. **BGP** is effectively the only one anyone uses.

## Why it matters

Static routing is fine for a 3-router homelab. The moment your network grows past that, manually maintaining routes is like trying to update every NPC's pathing in Cyberpunk 2077 by hand every time a road closes — you'd never finish. Dynamic protocols handle it for you and reconverge in seconds when something breaks.

But that automation is also the attack surface. Routers blindly trusting each other is exactly the netrunner fantasy from Watch Dogs — slip a lie into the system and the whole grid reroutes through your machine. If a router accepts forged routing updates, traffic for your bank can quietly flow through an attacker's box first. This isn't theoretical: BGP hijacks have rerouted significant chunks of internet traffic through hostile networks more than once, and they're classified as infrastructure-level man-in-the-middle attacks because that's exactly what they are.

That's why hardening and authenticating routing devices isn't optional — an unhardened router is a free pivot point.

## Key facts

### The three protocols you'll actually meet

- **OSPF (Open Shortest Path First)** — IGP, open standard. The Linux of routing protocols: vendor-agnostic, works on anything from Cisco to Juniper to Mikrotik to your weird homelab box running FRR.
- **EIGRP (Enhanced Interior Gateway Routing Protocol)** — IGP, Cisco-proprietary. Like a console exclusive — fast and polished, but you're locked into one vendor's hardware to use it fully.
- **BGP (Border Gateway Protocol)** — the only EGP in widespread use, and the routing protocol that literally runs the internet. Every ISP, every cloud provider, every major network speaks BGP at its edges. When BGP breaks at scale, the news writes articles about it.

### What they all do

- Exchange routing table information between routers (the gossip layer).
- Adapt to network changes — link dies, neighbor disappears, new path appears — without admin intervention.
- Select optimal paths automatically based on each protocol's metric (cost, bandwidth, AS-path length, etc.).
- Operate at **Layer 3** of the OSI model.

### Attacks against routing protocols

- **Route injection** — an unauthorized device sends forged routing updates and **poisons the routing table**. Like an Among Us imposter feeding fake task locations to the crew so everyone walks into reactor at the same time.
- **BGP hijacking** — an AS announces prefixes it doesn't own, sucking other networks' traffic toward itself. It's a man-in-the-middle at the infrastructure level: traffic destined for the real Limbo Capital servers ends up flowing through an attacker's AS first, where it can be inspected, modified, or just dropped.
- **Routers themselves as the attack vector** — an unhardened, unauthenticated router with default creds is the open vent in your base. Compromise the router, compromise every flow through it.

### Mitigations

- **MD5 authentication on routing neighbors** — neighbors must prove they know a shared secret before their updates are accepted. Stops route injection because the imposter doesn't have the password. (Modern deployments prefer stronger HMAC variants, but MD5 neighbor auth is the baseline you'll see referenced.)
- **BGP route filtering** — only accept route announcements that match expected patterns. The bouncer at the door checking the guest list.
- **Prefix lists** — explicit allow/deny rules for which prefixes a neighbor is allowed to announce or you're willing to accept. If your peer Beatrice's network suddenly claims to own Google's IP space, the prefix list laughs and drops it.
- **RPKI (Resource Public Key Infrastructure)** — cryptographically validates that the AS announcing a prefix is actually authorized to announce it. Think of it as a verified checkmark for route origins: signed by the legitimate owner, verifiable by anyone, forgeable by no one.

## Related concepts

[[Static Routing]] · [[Routing Tables]] · [[Autonomous Systems]] · [[OSPF]] · [[EIGRP]] · [[BGP]] · [[RPKI]] · [[Man-in-the-Middle Attacks]] · [[Network Layer (Layer 3)]] · [[Router Hardening]] · [[MD5 / HMAC Authentication]] · [[Prefix Lists and Route Filtering]]