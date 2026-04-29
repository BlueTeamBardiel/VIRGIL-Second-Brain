# Backup Strategy

## What it is
Think of it like a time machine for your data — if ransomware locks you out of today, a good backup lets you step back to yesterday and carry on. A backup strategy is a formal plan defining what data gets copied, how often, where copies are stored, and how quickly they can be restored in the event of loss, corruption, or compromise.

## Why it matters
In 2021, the Colonial Pipeline attack demonstrated that even organizations with backups can face extended downtime if restoration procedures are untested or backups are themselves encrypted by ransomware. Organizations following the **3-2-1 rule** — three copies, two media types, one offsite — were far better positioned to recover without paying ransom.

## Key facts
- **3-2-1 Rule**: 3 copies of data, on 2 different media types, with 1 copy stored offsite (or in the cloud); a core exam concept.
- **RTO vs. RPO**: Recovery Time Objective (how fast you must be back up) and Recovery Point Objective (how much data loss is acceptable) drive backup frequency decisions.
- **Backup types**: Full (complete copy), Incremental (changes since last backup), Differential (changes since last *full* backup) — incrementals are fastest to create; differentials are faster to restore than incrementals.
- **Immutable backups** — write-once storage that cannot be altered or deleted — are the primary defense against ransomware targeting backup systems.
- **Testing matters**: An untested backup is not a backup; restore drills must be scheduled to validate integrity and RTO compliance.

## Related concepts
[[Ransomware]] [[Disaster Recovery Plan]] [[Business Continuity]] [[Recovery Time Objective]] [[Data Integrity]]