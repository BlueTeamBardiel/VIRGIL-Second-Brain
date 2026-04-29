# anycast

## What it is
Like a chain of identical fire stations where your 911 call is automatically routed to the nearest one — anycast is a network addressing method where a single IP address is assigned to multiple servers in different geographic locations, and routers automatically direct traffic to the topologically closest node. Unlike unicast (one sender, one receiver), anycast means one address, many possible destinations, chosen by routing distance.

## Why it matters
Anycast is the primary defense architecture behind modern DDoS mitigation services like Cloudflare and Akamai. When an attacker floods a target with hundreds of gigabits of traffic, anycast routing automatically distributes that flood across dozens of globally distributed scrubbing centers, so no single node absorbs the full attack volume — effectively absorbing terabit-scale attacks that would instantly collapse a single-origin server.

## Key facts
- Anycast uses the same IP address advertised from multiple BGP routing points simultaneously; routers choose the path with the lowest cost metric
- DNS root servers (there are 13 logical root server addresses) rely heavily on anycast — there are actually hundreds of physical servers behind those 13 addresses
- Anycast does NOT provide load balancing in the traditional sense — all traffic from one geographic area hits the same node unless that node fails
- Attackers can abuse anycast in BGP hijacking attacks, announcing a victim's anycast prefix from a rogue AS to redirect traffic through a malicious node
- Anycast is stateless by design — TCP sessions can break if routing flaps cause mid-session path changes, which is why it's most commonly used for UDP-based services like DNS

## Related concepts
[[BGP hijacking]] [[DDoS mitigation]] [[DNS infrastructure]] [[Content Delivery Network]] [[unicast]]