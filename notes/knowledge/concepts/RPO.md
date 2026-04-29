# RPO

## What it is
Like deciding how many pages of a novel you can afford to rewrite if your manuscript is destroyed, RPO defines how much data loss is acceptable. Recovery Point Objective (RPO) is the maximum tolerable period of data loss measured in time — it answers "how old can our most recent backup be when disaster strikes?" RPO is a business continuity metric that directly drives backup frequency and replication strategy.

## Why it matters
During a ransomware attack on a hospital, if the RPO is 4 hours but backups only run nightly, the organization faces up to 20 hours of unrecoverable patient data — far exceeding their tolerance. This gap between stated RPO and actual backup architecture is one of the most commonly exploited weaknesses incident responders find post-breach. Defenders use RPO to justify continuous replication technologies like journaling and database mirroring to close that window.

## Key facts
- RPO is measured in **time**, not data volume (e.g., "15 minutes" means you can lose at most 15 minutes of data)
- A **lower RPO = higher cost**: achieving a 5-minute RPO requires near-continuous replication, not just daily tape backups
- RPO is determined by **business requirements**, not IT preference — legal, financial, and operational teams define acceptable data loss
- RPO pairs with **RTO** (Recovery Time Objective): RPO = how much data loss is acceptable; RTO = how long recovery can take
- Common exam trap: **RPO does NOT measure downtime** — that's RTO's job; confusing the two is a frequent Security+ distractor
- Technologies aligned to aggressive RPOs include **continuous data protection (CDP), database transaction log shipping, and synchronous replication**

## Related concepts
[[RTO]] [[Business Continuity Planning]] [[Backup Strategies]] [[Disaster Recovery]] [[Data Availability]]