# Network Disruption

## What it is
Like cutting the power lines to a city before a heist, network disruption attacks degrade or completely sever communications infrastructure to prevent defenders from coordinating, communicating, or responding. Precisely defined, network disruption encompasses intentional attacks that impair availability of network services — including routing, DNS, and bandwidth — making systems unreachable or unusable without necessarily compromising their data.

## Why it matters
During the 2016 Mirai botnet attack, attackers directed 620 Gbps of traffic at Dyn's DNS infrastructure, taking down Twitter, Reddit, Netflix, and dozens of other major platforms simultaneously. This wasn't about stealing data — it was pure disruption, demonstrating that availability attacks on critical network chokepoints (like DNS resolvers) can cascade across the entire internet. Defenders responded by implementing anycast routing and traffic scrubbing centers as countermeasures.

## Key facts
- **DDoS (Distributed Denial of Service)** is the most common network disruption technique; volumetric, protocol, and application-layer are the three primary subtypes recognized on Security+
- **BGP hijacking** disrupts networks at the routing level by announcing false routes, redirecting or blackholing traffic without generating high traffic volumes
- **DNS amplification attacks** exploit open DNS resolvers to generate traffic ratios of up to 70:1 — small queries produce massive responses aimed at the victim
- **Impact triad**: Network disruption attacks target **Availability**, the "A" in the CIA triad, and are often paired with extortion (ransom DDoS threats)
- **Mitigation controls** include rate limiting, ingress/egress filtering (BCP38), traffic scrubbing services (e.g., Cloudflare Magic Transit), and redundant ISP connections

## Related concepts
[[Denial of Service]] [[BGP Hijacking]] [[DNS Amplification]] [[Availability]] [[Botnet]]