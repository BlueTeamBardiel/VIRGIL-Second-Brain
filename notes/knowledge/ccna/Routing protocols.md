# routing protocols

## What it is
Think of routing protocols as the postal workers of the internet — they gossip with each other constantly to figure out the best path to deliver your packet. More precisely, routing protocols are standardized methods by which routers dynamically exchange topology information and calculate optimal forwarding paths across a network. Common examples include OSPF (link-state), RIP (distance-vector), and BGP (path-vector), each using different algorithms to build their "map" of the network.

## Why it matters
In 2010, China Telecom hijacked roughly 15% of global internet traffic for 18 minutes by advertising false BGP routes — redirecting traffic through Chinese infrastructure before forwarding it onward. This BGP hijacking attack demonstrates that unauthenticated routing updates are a critical threat vector, allowing attackers to intercept, inspect, or blackhole traffic at massive scale. Defenses like BGPsec and RPKI (Resource Public Key Infrastructure) exist specifically to cryptographically validate route announcements.

## Key facts
- **BGP** is the exterior gateway protocol (EGP) that routes traffic between autonomous systems (ASes) on the internet — it is notoriously trust-based and vulnerable to prefix hijacking
- **OSPF and EIGRP** are interior gateway protocols (IGPs) used within a single organization; OSPF supports MD5/SHA authentication to prevent rogue router injection
- **RIP** uses hop count as its only metric (max 15 hops) and broadcasts full routing tables every 30 seconds — making it both inefficient and easy to poison
- **Route poisoning** and **BGP hijacking** are the two primary routing-layer attacks: one corrupts internal tables, the other manipulates inter-AS path advertisements
- **RPKI** cryptographically ties IP prefixes to their legitimate ASes, directly mitigating BGP prefix hijacking — a key emerging defense on Security+/CySA+ radar

## Related concepts
[[BGP hijacking]] [[network segmentation]] [[man-in-the-middle attack]]