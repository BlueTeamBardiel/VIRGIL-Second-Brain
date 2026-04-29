# Restore

## What it is
Like a time machine that rewinds a broken clock back to when it was working perfectly, a **restore** is the process of recovering data, systems, or configurations from a backup to a known-good state after data loss, corruption, or a security incident. It is the operational counterpart to backup — the actual act of putting saved data back into production use.

## Why it matters
During a ransomware attack, an organization's files are encrypted and held hostage. If verified, uncorrupted backups exist and a restore procedure is rehearsed, the organization can wipe infected systems and recover without paying the ransom — making restore capability one of the most decisive factors in ransomware resilience. A backup that has never been test-restored is just a hope, not a recovery plan.

## Key facts
- **RTO (Recovery Time Objective)** defines how fast a restore must complete; **RPO (Recovery Point Objective)** defines how much data loss is acceptable — both are tested through restore drills.
- Restoring from a backup taken *after* an attacker gained persistence can reintroduce malware — always restore from a backup predating the compromise.
- A **bare-metal restore** recovers an entire system image to new or wiped hardware, bypassing the OS entirely.
- The **3-2-1 backup rule** (3 copies, 2 media types, 1 offsite) is only valuable if restores from all three copies are periodically verified.
- Restore testing is a required component under frameworks like **NIST SP 800-34** (Contingency Planning Guide) and is examined in **BCP/DRP** scenarios on Security+.

## Related concepts
[[Backup]] [[Business Continuity Plan (BCP)]] [[Disaster Recovery Plan (DRP)]] [[Recovery Time Objective (RTO)]] [[Ransomware]]