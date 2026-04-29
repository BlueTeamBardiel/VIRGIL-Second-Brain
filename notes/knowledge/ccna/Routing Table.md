# Routing Table

## What it is
Like a postal worker's cheat sheet that maps every zip code to the right delivery truck, a routing table is a data structure stored in a router (or host) that lists known network destinations and specifies the next hop a packet should take to reach each one. Routers consult this table for every single packet, forwarding traffic along the most efficient path based on destination IP address and subnet mask.

## Why it matters
In a **route injection attack**, an adversary uses protocols like BGP or RIP to advertise fraudulent routes, poisoning a router's table so that legitimate traffic gets redirected through an attacker-controlled node — enabling man-in-the-middle interception or traffic blackholing. The 2010 China Telecom incident is a textbook example: roughly 15% of global internet traffic was briefly rerouted through Chinese routers due to a BGP route leak. Defenders combat this with route filtering, prefix validation (RPKI), and monitoring tools that alert on unexpected routing changes.

## Key facts
- Routing tables contain: destination network, subnet mask, next-hop address, interface, and metric (cost)
- **Static routes** are manually configured and don't adapt; **dynamic routes** are learned via protocols (RIP, OSPF, BGP, EIGRP)
- The **longest prefix match** rule determines which route wins when multiple entries match a destination
- A **default route** (0.0.0.0/0) acts as a catch-all — used when no specific match exists; attackers target this for traffic redirection
- Compromising a routing table is a **network-layer attack** — it bypasses host-based controls entirely, making it especially dangerous

## Related concepts
[[BGP Hijacking]] [[Man-in-the-Middle Attack]] [[Network Segmentation]] [[OSPF]] [[Default Gateway]]