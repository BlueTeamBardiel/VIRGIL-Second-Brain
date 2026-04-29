# Warm Site

## What it is
Like a spare kitchen with appliances installed but no food stocked — a warm site has the hardware and connectivity ready, but needs data restored before it can serve customers. It is a disaster recovery facility pre-equipped with hardware, network infrastructure, and software, but requiring data restoration from backups before becoming fully operational. Recovery time is measured in hours to days, placing it between the instant-on hot site and the build-from-scratch cold site.

## Why it matters
When a ransomware attack encrypts a hospital's primary data center, administrators can fail over to a warm site within 24–48 hours by restoring the most recent off-site backups to pre-staged servers. This balance of cost and recovery speed makes warm sites the practical choice for mid-sized organizations that cannot afford a fully mirrored hot site but cannot tolerate the week-long recovery of a cold site.

## Key facts
- **RTO (Recovery Time Objective)** for a warm site is typically **hours to a few days** — longer than hot sites (minutes) but faster than cold sites (days to weeks)
- Hardware and network connectivity are **pre-installed and maintained**, but production data must be **manually restored** from backup media or cloud storage
- Cost sits **between hot and cold**: ongoing leasing and maintenance without the expense of real-time data replication
- Warm sites often use **periodic backup synchronization** (e.g., daily or hourly tape/cloud backups) rather than continuous mirroring
- A key exam distinction: **hot site = real-time replication; warm site = periodic backup restoration; cold site = no pre-staged data or equipment**

## Related concepts
[[Hot Site]] [[Cold Site]] [[Recovery Time Objective]] [[Business Continuity Plan]] [[Backup and Recovery]]