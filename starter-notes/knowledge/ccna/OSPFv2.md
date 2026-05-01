# OSPFv2

## What it is
Like postal workers sharing neighborhood maps with each other until every post office has a complete picture of all delivery routes, OSPFv2 is a link-state interior gateway routing protocol where routers exchange topology information to independently calculate the shortest path to every destination. It operates within a single autonomous system using Dijkstra's algorithm and communicates via multicast addresses 224.0.0.5 (all OSPF routers) and 224.0.0.6 (designated routers).

## Why it matters
An attacker with access to an internal network segment can inject rogue OSPF hello packets to become a neighbor, then advertise fraudulent routes to redirect traffic through a malicious router — a classic man-in-the-middle setup. This is why OSPFv2 supports MD5 authentication between neighbors; without it, any host on the segment can poison the routing table and silently intercept sensitive internal communications.

## Key facts
- OSPF uses **protocol number 89** (not TCP or UDP — it rides directly on IP)
- **Area 0 (backbone area)** is mandatory; all other areas must connect to it to prevent routing loops
- Neighbor relationships progress through states: **Down → Init → 2-Way → ExStart → Exchange → Loading → Full**
- MD5 authentication is configured per-interface and per-area; without it, OSPF is vulnerable to **route injection attacks**
- **Designated Router (DR) and Backup DR (BDR)** are elected on multi-access networks to reduce LSA flooding overhead — router with highest priority (then highest Router ID) wins

## Related concepts
[[BGP Security]] [[Routing Protocol Authentication]] [[Man-in-the-Middle Attack]]
