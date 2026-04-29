# Recovery

## What it is
Like a hospital trauma team that kicks in *after* the surgeon fails to prevent a patient from crashing, Recovery is the phase where you restore systems and operations to normal after a security incident has already caused damage. Precisely, it is the process of restoring affected systems, data, and services to a known-good state while eliminating the threat and preventing reinfection.

## Why it matters
In the 2021 Colonial Pipeline ransomware attack, the company shut down operations for six days not because decryption was impossible, but because their recovery procedures were untested and incomplete. Organizations that had validated backups isolated from the network and rehearsed recovery runbooks restored similar ransomware damage in hours rather than days — the difference between a bad week and a national fuel crisis.

## Key facts
- Recovery is the **fifth phase** of the NIST incident response lifecycle (Preparation → Detection → Containment → Eradication → **Recovery**)
- The **Recovery Time Objective (RTO)** defines the maximum acceptable downtime; the **Recovery Point Objective (RPO)** defines the maximum acceptable data loss window
- Backups must follow the **3-2-1 rule**: 3 copies, 2 different media types, 1 stored offsite (or offline/air-gapped)
- Systems should be restored from **clean, verified backups** taken *before* the compromise, not snapshots made during the attack window
- Recovery is considered complete only after **monitoring confirms** no indicators of compromise remain and normal business operations resume — premature declaration leads to re-infection

## Related concepts
[[Incident Response]] [[Business Continuity Planning]] [[Backup and Restore]] [[Disaster Recovery]] [[Eradication]]