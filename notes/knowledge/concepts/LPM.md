# LPM

## What it is
Like a postal sorting office that always routes your letter to the most specific zip code match first, Longest Prefix Match (LPM) is the algorithm routers use to select the best route for a packet. When multiple routing table entries match a destination IP address, the router selects the entry with the longest (most specific) subnet prefix — the one with the most bits matching the destination.

## Why it matters
Attackers exploit LPM in route hijacking and BGP prefix hijacking attacks: by announcing a more-specific prefix (e.g., /25 instead of a legitimate /24), a malicious AS can attract traffic destined for a victim network, enabling interception or blackholing. Defenders use this same principle intentionally — injecting more-specific null routes (blackhole routing) to silently drop attack traffic during a DDoS mitigation response.

## Key facts
- LPM compares destination IP addresses against all entries in the routing table, selecting the match with the **highest prefix length** (most bits in the subnet mask)
- A /32 host route always wins over a /24 network route for that specific IP — it is the most specific possible match
- BGP prefix hijacking weaponizes LPM: advertising a /25 steals traffic from a legitimate /24 announcement because routers globally prefer the longer prefix
- Remotely Triggered Black Hole (RTBH) filtering uses LPM defensively — operators advertise /32 routes pointing to Null0 to drop attack traffic at the network edge
- CIDR (Classless Inter-Domain Routing) is what made LPM operationally necessary, replacing fixed-class routing with variable-length subnet masks

## Related concepts
[[BGP Hijacking]] [[CIDR]] [[Routing Table]] [[DDoS Mitigation]] [[Blackhole Routing]]