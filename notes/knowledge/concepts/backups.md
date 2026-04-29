# backups

## What it is
Think of backups like a time machine for your data — if ransomware encrypts your files at 2 PM Tuesday, a good backup lets you step back to Monday and pretend Tuesday never happened. Precisely, a backup is a copy of data stored separately from the original, enabling restoration after loss, corruption, or compromise. The "separately stored" part is the whole ballgame.

## Why it matters
In a ransomware attack, threat actors increasingly target and delete local backups *before* deploying encryption — specifically to eliminate your escape route and force payment. Organizations running the 3-2-1 backup strategy (3 copies, 2 media types, 1 offsite) survived NotPetya in 2017 with minimal downtime, while those without offsite copies paid millions or shut down permanently.

## Key facts
- **3-2-1 Rule**: 3 copies of data, on 2 different media types, with 1 stored offsite (or air-gapped/offline)
- **RTO vs RPO**: Recovery Time Objective (how fast you recover) and Recovery Point Objective (how much data loss is acceptable) are the two metrics that drive backup strategy design
- **Air-gapped backups** are physically or logically disconnected from the network — ransomware cannot encrypt what it cannot reach
- **Backup testing** is non-negotiable: an untested backup is not a backup, it's a hope. Regular restore drills are required for NIST 800-34 compliance
- **Backup types matter**: Full (complete copy), Differential (changes since last full), Incremental (changes since last backup of any type) — incrementals are fastest to create, slowest to restore

## Related concepts
[[ransomware]] [[disaster-recovery]] [[business-continuity]] [[data-integrity]] [[incident-response]]