# System Backup

## What it is
Like a photograph of your house's interior taken before a burglary — you can prove exactly what was there and restore it afterward — a system backup is a point-in-time copy of data, configurations, and system states stored separately from the original. Backups enable recovery from data loss caused by ransomware, hardware failure, accidental deletion, or disaster.

## Why it matters
In the 2021 Colonial Pipeline ransomware attack, the company shut down operations partly due to fears about data integrity and recovery capability. Organizations with tested, offline backups can restore systems without paying ransoms — making robust backup strategy a primary defense against ransomware's core leverage: destroying your only copy of data.

## Key facts
- The **3-2-1 backup rule**: maintain **3** copies of data, on **2** different media types, with **1** copy stored offsite (or offline/air-gapped)
- **RTO (Recovery Time Objective)** defines how quickly systems must be restored; **RPO (Recovery Point Objective)** defines the maximum acceptable data loss window — both are critical to backup design
- Backups must be **tested regularly** via restoration drills; an untested backup is not a reliable backup
- **Immutable backups** (write-once storage) prevent ransomware or malicious insiders from encrypting or deleting backup data
- Backup types: **Full** (complete copy), **Incremental** (changes since last backup), **Differential** (changes since last full backup) — incrementals are faster to create but slower to restore

## Related concepts
[[Ransomware]] [[Disaster Recovery Plan]] [[Business Continuity Planning]] [[Recovery Time Objective]] [[Data Integrity]]