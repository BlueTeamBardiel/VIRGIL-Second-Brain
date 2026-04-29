# Service Availability

## What it is
Like a hospital emergency room that must stay open 24/7 regardless of how chaotic things get, service availability means critical systems remain accessible and functional when legitimate users need them. It is the "A" in the CIA triad, representing the guarantee that authorized users can reliably access systems, data, and services within acceptable performance thresholds.

## Why it matters
In 2016, the Mirai botnet hijacked hundreds of thousands of IoT devices to flood Dyn's DNS infrastructure with traffic, taking down Twitter, Netflix, and Reddit for hours across the U.S. East Coast. This attack demonstrated that availability failures cascade — one service's downtime can collapse dozens of dependent platforms. Defenders responded by architecting redundant DNS providers and implementing anycast routing to distribute attack traffic.

## Key facts
- **Availability is measured as uptime percentage**: "five nines" (99.999%) allows only ~5.26 minutes of downtime per year
- **DDoS attacks are the primary availability threat**: volumetric (flood), protocol (SYN flood), and application-layer (HTTP flood) are the three main categories tested on Security+
- **Redundancy controls** — RAID, failover clusters, load balancers, and hot/warm/cold site recovery — are the primary defenses for maintaining availability
- **RTO (Recovery Time Objective)** and **RPO (Recovery Point Objective)** are the two key metrics for measuring availability requirements in business continuity planning
- **Resource exhaustion** attacks don't require network floods — fork bombs, memory leaks, and CPU-intensive requests can achieve the same result against a single host

## Related concepts
[[CIA Triad]] [[Denial of Service]] [[Business Continuity Planning]] [[Redundancy]] [[Recovery Time Objective]]