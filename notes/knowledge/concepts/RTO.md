# RTO

## What it is
Like a hospital's promise to have a surgeon scrubbed and ready within 30 minutes of a trauma call, RTO (Recovery Time Objective) is the maximum acceptable downtime an organization can tolerate before a disrupted system must be restored to operation. It's a business-defined threshold — not a technical capability — that drives how aggressively you invest in redundancy and failover infrastructure.

## Why it matters
During the 2021 Colonial Pipeline ransomware attack, operators shut down systems proactively, and every hour offline translated directly to fuel shortages across the Eastern Seaboard. Had Colonial had a formally defined RTO of, say, 4 hours for pipeline control systems, it would have forced pre-existing investments in offline backups, tested restoration procedures, and alternate operational modes — potentially cutting recovery from days to hours.

## Key facts
- RTO answers "how fast must we recover?" while **RPO (Recovery Point Objective)** answers "how much data loss can we tolerate?" — both are required for a complete BCP
- A lower RTO requires more expensive solutions: hot sites recover in minutes, warm sites in hours, cold sites in days
- RTO is defined by **business impact analysis (BIA)**, not by IT — it reflects revenue loss, legal exposure, and reputational damage per hour of downtime
- RTO must be validated through **tabletop exercises and actual DR tests** — an untested RTO is a fictional RTO
- On Security+ exams, RTO is categorized under **Business Continuity and Disaster Recovery (BCDR)** concepts alongside MTTR, MTBF, and RPO

## Related concepts
[[RPO]] [[Business Impact Analysis]] [[Disaster Recovery Plan]] [[Hot Site]] [[MTTR]]