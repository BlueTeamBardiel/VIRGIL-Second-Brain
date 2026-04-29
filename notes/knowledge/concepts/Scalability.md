# Scalability

## What it is
Like a highway that needs extra lanes during rush hour, scalability is the ability of a system to handle increasing workloads by adding resources without degrading performance or security posture. Precisely, scalability refers to a system's capacity to grow (scale out horizontally or scale up vertically) while maintaining functionality, availability, and security controls proportionally to demand.

## Why it matters
During a volumetric DDoS attack, an organization running a fixed-capacity infrastructure gets crushed — bandwidth and server resources exhaust quickly. A scalable defense using cloud-based load balancing and auto-scaling groups can absorb traffic spikes dynamically, while WAF rules and rate-limiting policies scale alongside the infrastructure to maintain protection without manual intervention.

## Key facts
- **Horizontal scaling** (scale out) adds more nodes/instances; **vertical scaling** (scale up) adds more CPU/RAM to existing nodes — horizontal is preferred for resilience and fault tolerance
- Security controls must scale with infrastructure: adding 1,000 new endpoints without scaling SIEM log ingestion creates dangerous visibility gaps
- **Elasticity** is a subset of scalability — specifically the ability to automatically scale up *and* shrink back down; relevant in cloud environments (AWS Auto Scaling, Azure Scale Sets)
- Load balancers are a key scalability component and represent an attack surface themselves — misconfigured session persistence can expose session hijacking vulnerabilities
- Scalability failures contribute to **availability** attacks (one of the CIA triad pillars); ensuring scalability is a core component of Business Continuity Planning (BCP)

## Related concepts
[[Availability]] [[Load Balancing]] [[DDoS Mitigation]] [[Elasticity]] [[Business Continuity Planning]]