# BGP

## What it is

The internet is basically a massive Discord with thousands of servers, and each server (an Autonomous System) has its own admin running things their way. BGP — Border Gateway Protocol — is how those server admins shout across the void to tell each other "hey, if you want to reach my people, route through me." It's the protocol that stitches separate networks into *the* network.

More precisely: BGP is the **exterior gateway protocol** of the internet. It runs between autonomous systems (ASes) — the big chunks of IP space owned by ISPs, cloud providers, universities, and large enterprises. When your packet leaves Comcast and ends up at Cloudflare, BGP is what figured out the inter-company handoff.

It's a **path-vector protocol**. Instead of advertising raw distance or link speed like interior protocols (OSPF, EIGRP), BGP advertises the *list of ASes* a route passes through — the **AS_PATH**. Routers pick paths based on policy and attributes, not on what's technically fastest. Cheapest peering agreement wins, not lowest latency. It's less Google Maps "fastest route" and more "which toll road did accounting tell us to use."

## Why it matters

BGP is the load-bearing wall of the internet, and it was built in an era when everyone on the internet basically knew each other by name. There's no built-in authentication. When an AS announces "I own 10.0.0.0/8," every other router on the planet kind of just... believes it.

That trust model is why BGP outages and hijacks make headlines. A typo in a route filter at a single ISP can black-hole massive chunks of traffic globally — this is how Facebook took itself off the internet in 2021, and how a Pakistani ISP once accidentally swallowed YouTube worldwide trying to block it domestically. Pull one Jenga block, the whole tower wobbles.

For attackers, BGP hijacking is the heist version of the same trick: announce someone else's IP prefix, and traffic destined for them detours through your network instead. Think of it like a Watch Dogs 2 hack where you reroute the city's traffic lights — except the "city" is global banking, crypto exchanges, or DNS infrastructure, and the prize is plaintext sessions you can MITM, snapshot, and walk away with.

## Key facts

- **Transport: TCP port 179.** BGP doesn't reinvent reliability — it sits on top of TCP, like a fighting game netcode that delegates packet ordering to someone else and focuses on the actual moves.
- **Exterior, not interior.** OSPF and EIGRP run *inside* an AS (the guild's internal voice channels). BGP runs *between* ASes (cross-server diplomacy).
- **Path-vector with AS_PATH.** Each route advertisement carries the chain of ASes it traversed. If a router sees its own AS number already in the path, it drops the route — this is BGP's loop prevention, the equivalent of refusing to retweet your own post.
- **Policy beats performance.** Route selection considers attributes like LOCAL_PREF, AS_PATH length, MED, and origin type before anything resembling "speed." A route through three ASes your company has cheap contracts with will beat a two-AS route you'd have to pay extra to use.
- **Sessions are peer relationships.** Two BGP routers explicitly configure each other as neighbors — IP and AS number declared on both sides. No discovery, no broadcast — it's a mutual friend request, not matchmaking.
- **No native authentication.** Classic BGP just trusts whatever a peer announces. The original spec assumed everyone in the room was already vetted, like an early-days Among Us lobby with friends only.
- **BGP hijacking** = a malicious or compromised AS announces prefixes it doesn't own. Other ASes accept the announcement, traffic flows the wrong direction. Used for traffic interception, crypto wallet theft, spam campaigns, and surveillance.
- **Misconfiguration = the same damage.** A fat-fingered route leak from a regional ISP can ripple globally because everyone propagates the bad advertisement. Most "BGP hijacks" in history were actually accidents.
- **RPKI (Resource Public Key Infrastructure)** cryptographically binds IP prefixes to the AS numbers authorized to announce them. Routers check announcements against signed ROAs (Route Origin Authorizations) and drop the obviously bogus ones. It's the verified-checkmark layer for route origins.
- **BGPsec** goes further: every AS in the path cryptographically signs the announcement as it forwards. This protects the *entire path*, not just the origin — so an attacker can't forge a shorter AS_PATH to win route selection. Adoption is slow because signing every hop is expensive.
- **RPKI validates origin. BGPsec validates the journey.** RPKI says "this AS is allowed to announce this prefix." BGPsec says "and here's a signed receipt from every AS that touched the announcement."

## Related concepts

[[Autonomous System (AS)]] · [[RPKI]] · [[BGPsec]] · [[BGP Hijacking]] · [[OSPF]] · [[Path-Vector Protocols]] · [[TCP]] · [[Route Leaks]] · [[Internet Exchange Points (IXP)]] · [[MITM Attacks]]