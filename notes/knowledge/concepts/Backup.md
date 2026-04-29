# backup

## What it is
Like a photograph of your house's contents taken before a fire — useless during the blaze, but everything afterward depends on it. A backup is a copy of data stored separately from the original so it can be restored after loss, corruption, or destruction. Backups are a core component of availability, the "A" in the CIA triad.

## Why it matters
In 2021, the Kaseya VSA ransomware attack encrypted files across hundreds of managed service providers simultaneously. Organizations with tested, offline backups restored operations within days; those without paid ransoms exceeding $50,000 or lost data permanently. This illustrates why backups are the primary technical control against ransomware — but only if they're air-gapped and verified.

## Key facts
- The **3-2-1 rule**: keep 3 copies of data, on 2 different media types, with 1 stored offsite
- **Full backup** copies everything; **incremental** copies only changes since the last backup; **differential** copies changes since the last *full* backup — differentials restore faster, incrementals use less storage
- **RTO (Recovery Time Objective)** is how long you can tolerate downtime; **RPO (Recovery Point Objective)** is how much data loss is acceptable — backups must be designed to meet both
- Backups must be **tested via restoration drills** — an untested backup is an assumption, not a control
- Backups connected to the network can be encrypted by ransomware; **air-gapped or immutable backups** (WORM storage) are the hardened countermeasure

## Related concepts
[[ransomware]] [[disaster_recovery]] [[business_continuity]] [[availability]] [[recovery_point_objective]]