# Hot site fail-over

## What it is
Like a stunt double standing just offstage in full costume — ready to step in the moment the lead actor trips — a hot site is a fully operational, real-time duplicate of your primary data center. It maintains live data replication, active hardware, and running systems so that fail-over can occur in minutes or seconds with virtually no data loss.

## Why it matters
During the 2012 AWS US-East-1 outage, organizations without hot site arrangements faced hours of downtime, while those with active-active configurations across availability zones failed over automatically with near-zero user impact. This illustrates why financial institutions and healthcare providers, bound by RTO/RPO requirements, legally mandate hot site architectures.

## Key facts
- **RTO (Recovery Time Objective)** for a hot site is typically **minutes or less**; contrast with warm sites (hours) and cold sites (days)
- **RPO (Recovery Point Objective)** approaches **zero** because data is synchronously or near-synchronously replicated in real time
- Hot sites cost significantly more than warm/cold alternatives — they essentially run a **duplicate infrastructure 24/7**
- Fail-over can be **automatic** (active-active) or **manual** (active-passive), with active-active providing the fastest switchover
- Hot sites must be **geographically separated** from the primary site to protect against regional disasters (FEMA recommends >50 miles)

## Related concepts
[[Business Continuity Planning]] [[Recovery Time Objective]] [[Warm site]] [[Cold site]] [[Data Replication]]