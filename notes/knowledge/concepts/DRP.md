# DRP

## What it is
Like a fire escape plan rehearsed *before* the building burns, a Disaster Recovery Plan is the documented, tested playbook an organization executes *after* a disruptive event to restore critical IT systems and operations. It is a subset of Business Continuity Planning (BCP) focused specifically on technical recovery of infrastructure, data, and services following incidents like ransomware, hardware failure, or natural disasters.

## Why it matters
In 2021, the Colonial Pipeline ransomware attack forced a six-day shutdown of fuel distribution across the US East Coast — a well-tested DRP with defined RTOs and pre-staged clean backups could have dramatically shortened recovery time and reduced the $4.4 million ransom pressure. Organizations without a tested DRP often discover their backups are corrupted or their recovery procedures are undocumented only *during* the crisis itself.

## Key facts
- **RTO (Recovery Time Objective):** Maximum acceptable downtime — how fast you *must* be back online
- **RPO (Recovery Point Objective):** Maximum acceptable data loss — how old your restored data can be (e.g., "no more than 4 hours of lost transactions")
- **DRP is IT-focused; BCP is business-wide** — DRP lives *inside* BCP as a technical component
- **Hot site** = fully operational duplicate environment (lowest RTO, highest cost); **Warm site** = partially configured; **Cold site** = just space and power (highest RTO, lowest cost)
- DRPs must be **tested regularly** via tabletop exercises, parallel testing, or full cutover tests — an untested DRP is treated as nonexistent on Security+ exams
- **Mean Time to Recover (MTTR)** is the operational metric used to measure actual recovery performance against the RTO target

## Related concepts
[[Business Continuity Plan]] [[RTO and RPO]] [[Backup Strategies]] [[Incident Response Plan]] [[High Availability]]