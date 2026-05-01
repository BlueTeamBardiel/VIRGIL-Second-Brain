# OSPF

## What it is
Like postal workers in a city who constantly share updated maps with each other so every office knows the fastest route to every address — OSPF (Open Shortest Path First) is a link-state interior gateway routing protocol that allows routers within a single autonomous system to dynamically share topology information and calculate optimal paths using Dijkstra's algorithm.

## Why it matters
Attackers who gain access to a network can inject fraudulent OSPF routing advertisements, poisoning the routing table to redirect traffic through a malicious router for man-in-the-middle interception — a technique called OSPF route injection. Without OSPF authentication configured, any device speaking the protocol can participate as a trusted peer, making this a realistic privilege escalation and traffic interception vector in misconfigured enterprise networks.

## Key facts
- OSPF uses **protocol 89** directly over IP (not TCP or UDP), which means it bypasses port-based firewall rules if not explicitly filtered
- OSPF supports **MD5 and SHA authentication** for neighbor relationships — absence of this is a common misconfiguration finding in network audits
- OSPF organizes routers into **areas** (Area 0 is the backbone); compromising a backbone router has cascading topology impact across all connected areas
- **Neighbor adjacency** is established via Hello packets on multicast address 224.0.0.5; spoofing these can disrupt routing convergence
- OSPF is an **interior** gateway protocol — it operates *within* an organization's autonomous system, unlike BGP which routes between organizations

## Related concepts
[[BGP Hijacking]] [[Routing Table Poisoning]] [[Man-in-the-Middle Attack]] [[Authentication Protocols]]


<!-- merged from: SPF.md -->

# SPF


