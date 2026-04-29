# Recovery Time Objective

## What it is
Think of RTO like a surgeon's promise to a hospital: "If the power fails during an operation, I guarantee we're back to full function within 4 hours." Recovery Time Objective (RTO) is the maximum acceptable duration of downtime an organization can tolerate after a disruption before business impact becomes critical. It is a pre-defined target, not a measurement of actual recovery — it's the deadline you must beat.

## Why it matters
During a ransomware attack on a hospital network, attackers know that encrypting patient records creates life-threatening pressure to pay quickly. A hospital with an RTO of 2 hours *and* tested backups can refuse the ransom and restore systems within that window; a hospital with an undefined RTO scrambles, pays, and funds the next attack. RTO forces organizations to invest in recovery infrastructure *before* the incident.

## Key facts
- RTO is paired with **RPO (Recovery Point Objective)** — RTO answers "how fast?" while RPO answers "how much data loss is acceptable?"
- A lower RTO requires more expensive solutions: hot sites, real-time replication, and automated failover
- RTO is defined during **Business Impact Analysis (BIA)** and documented in the **Disaster Recovery Plan (DRP)**
- If actual recovery time exceeds the RTO, the organization is operating outside its acceptable risk tolerance — a compliance and financial liability
- RTO applies per-system: a payment processing system might have RTO of 1 hour while internal HR software might have RTO of 72 hours

## Related concepts
[[Recovery Point Objective]] [[Business Impact Analysis]] [[Disaster Recovery Plan]] [[Business Continuity Planning]] [[Mean Time to Restore]]