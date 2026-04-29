# Server Clustering

## What it is
Like a relay race team where any runner can grab the baton if another stumbles, a server cluster is a group of servers that work together as a single logical unit, automatically shifting workloads when one node fails. Precisely defined: server clustering links multiple physical or virtual servers so that services remain available even if individual nodes experience failure, sharing processing load and providing redundancy through coordinated failover mechanisms.

## Why it matters
During the 2016 Dyn DNS DDoS attack, organizations with clustered, geographically distributed infrastructure maintained availability while single-point deployments went dark — demonstrating that clustering is both a resilience strategy and a direct defense against availability attacks. Conversely, attackers who compromise a cluster's management plane (like VMware vCenter or Windows Server Failover Clustering) can pivot across all nodes simultaneously, turning redundancy into a massive attack surface.

## Key facts
- **Active/Active clustering**: all nodes handle traffic simultaneously, providing load balancing AND redundancy — maximum resource utilization
- **Active/Passive clustering**: standby node sits idle until the active node fails — simpler but wastes capacity; failover typically occurs within seconds
- **Split-brain** is a critical failure condition where cluster nodes lose communication and each assumes it's the sole active node, potentially causing data corruption
- **Quorum** mechanisms (requiring majority node agreement) are used to prevent split-brain by defining a minimum threshold for the cluster to remain operational
- Clustering directly addresses the **Availability** pillar of the CIA triad and maps to **Recovery Time Objective (RTO)** reduction in business continuity planning

## Related concepts
[[High Availability]] [[Load Balancing]] [[Failover]] [[Redundancy]] [[Business Continuity Planning]]