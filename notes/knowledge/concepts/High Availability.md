# High Availability

## What it is
Like a hospital that keeps backup generators, redundant staff, and duplicate surgical suites so care never stops — even during a power outage or staff shortage — High Availability (HA) is the design principle of engineering systems to remain operational continuously, minimizing downtime through redundancy and failover mechanisms. Measured as a percentage of uptime (e.g., "five nines" = 99.999%), HA ensures critical services survive hardware failures, attacks, or disasters.

## Why it matters
During a DDoS attack against a financial institution, attackers flood a single server attempting to knock it offline. An HA architecture using load balancers, geographically distributed nodes, and automatic failover means traffic reroutes to healthy systems within seconds — the attack degrades performance but never achieves full service disruption. Without HA, that same attack creates the outage the adversary intended.

## Key facts
- **Five nines (99.999%)** uptime = approximately 5 minutes of downtime per year; this is the gold standard for mission-critical systems
- **RTO (Recovery Time Objective)** defines the maximum acceptable downtime; HA architectures are specifically designed to meet aggressive RTO targets (seconds to minutes)
- **Clustering and load balancing** are core HA mechanisms — active-active clusters handle traffic simultaneously, while active-passive clusters keep a standby node ready to take over
- **Single Points of Failure (SPOFs)** are the enemy of HA; security architects must identify and eliminate every SPOF in critical infrastructure
- HA directly supports the **Availability** pillar of the CIA Triad and is a primary defense against Denial of Service attacks

## Related concepts
[[CIA Triad]] [[Redundancy]] [[Fault Tolerance]] [[Load Balancing]] [[Disaster Recovery]]