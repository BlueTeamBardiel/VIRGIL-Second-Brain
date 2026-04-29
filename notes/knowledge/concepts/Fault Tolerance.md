# Fault Tolerance

## What it is
Like a commercial airplane that can lose an engine and still land safely, fault tolerance is a system's ability to continue operating correctly even when one or more of its components fail. Precisely defined: fault tolerance ensures that system failures do not cascade into total service outages by building in redundancy and failover mechanisms at the hardware, software, or network layer.

## Why it matters
During the 2016 Dyn DNS DDoS attack, DNS providers without fault-tolerant, geographically distributed infrastructure went completely offline, taking down Twitter, Netflix, and Reddit with them. Organizations that had configured redundant DNS providers across multiple autonomous systems remained reachable. This is a textbook case of why fault tolerance is not optional for high-availability security architecture.

## Key facts
- **RAID arrays** implement fault tolerance at the storage layer — RAID 1 (mirroring) and RAID 5 (striping with parity) can survive disk failure without data loss
- **Clustering and load balancing** provide fault tolerance at the server layer; if one node fails, traffic reroutes automatically to surviving nodes
- **Recovery Time Objective (RTO)** and **Recovery Point Objective (RPO)** are the metrics used to define how much downtime and data loss a fault-tolerant system is designed to tolerate
- **Active-active** configurations (both nodes serving traffic simultaneously) provide better fault tolerance than **active-passive** (standby node waits idle)
- Fault tolerance supports the **Availability** pillar of the CIA triad and is a core requirement for systems classified as High Availability (HA), typically targeting 99.999% uptime ("five nines")

## Related concepts
[[High Availability]] [[Redundancy]] [[Disaster Recovery]] [[RAID]] [[Business Continuity Planning]]