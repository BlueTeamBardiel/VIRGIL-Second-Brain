# Recovery Point Objective

## What it is
Think of RPO like the last save point in a video game — it defines exactly how much progress you're willing to lose if the system crashes. Recovery Point Objective (RPO) is the maximum acceptable amount of data loss measured in time, representing how far back in time a recovery operation can restore data before business impact becomes unacceptable. If your RPO is 4 hours, you must have a backup no older than 4 hours at any given moment.

## Why it matters
During a ransomware attack that encrypts an organization's file servers at 3:00 PM, the incident response team must restore from backup. If the RPO was set to 24 hours but the last clean backup is from 11:00 PM the previous night, the organization loses 16 hours of transactions, orders, and records — a gap that could mean millions in unrecoverable business data. A tightly defined RPO drives the technical decision of *how frequently* backups must run.

## Key facts
- RPO is expressed in **units of time** (e.g., 15 minutes, 4 hours, 24 hours) — not data size or cost
- A **lower RPO** (e.g., 15 minutes) demands more frequent backups and higher infrastructure cost
- RPO is set during **Business Impact Analysis (BIA)** alongside RTO (Recovery Time Objective)
- RPO determines **backup frequency**; RTO determines how fast systems must be restored — they are distinct metrics
- Technologies like **continuous data replication** or **journaling** are used to achieve near-zero RPOs in critical systems
- RPO is a *business decision* driven by acceptable data loss tolerance, not purely a technical one

## Related concepts
[[Recovery Time Objective]] [[Business Impact Analysis]] [[Backup and Recovery Strategies]] [[Disaster Recovery Plan]] [[Business Continuity Planning]]