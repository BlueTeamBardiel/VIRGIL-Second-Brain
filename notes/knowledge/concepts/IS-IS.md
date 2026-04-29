# IS-IS

## What it is
Like postal workers sharing neighborhood route maps with each other rather than asking a central post office, IS-IS is a link-state routing protocol where routers flood topology information directly to all their peers. Intermediate System to Intermediate System (IS-IS) is an IGP (Interior Gateway Protocol) that uses Dijkstra's shortest path algorithm to build a complete map of the network and calculate optimal routes, operating directly over Layer 2 rather than IP.

## Why it matters
IS-IS is heavily used in ISP backbone networks, making it a high-value attack target. An adversary with access to a router running IS-IS could inject fraudulent Link State PDUs (LSPs) to poison the topology database — redirecting traffic through attacker-controlled infrastructure for man-in-the-middle interception. IS-IS authentication (MD5 or SHA-HMAC) exists precisely to prevent unauthenticated routers from injecting false routing updates.

## Key facts
- IS-IS runs **directly over Layer 2** (not IP), making it unreachable from external IP-based attacks — unlike OSPF which runs over IP (protocol 89)
- Uses **Link State PDUs (LSPs)** to advertise topology; routers flood these to all neighbors, building a synchronized Link State Database (LSDB)
- Supports **two-level hierarchy**: Level 1 (intra-area routing) and Level 2 (inter-area/backbone routing), similar to OSPF areas
- Authentication options include **cleartext and MD5/HMAC-SHA**; without authentication, any device can inject malicious LSPs
- IS-IS is **protocol-agnostic** — originally designed for OSI networks, it was extended (Integrated IS-IS) to support IPv4 and IPv6 simultaneously, making it popular with large ISPs

## Related concepts
[[OSPF]] [[BGP Security]] [[Routing Protocol Authentication]]