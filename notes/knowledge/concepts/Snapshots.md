# Snapshots

## What it is
Like a photograph of your living room — it captures exactly where everything was at that moment, so you can notice if someone moved the furniture later. A snapshot is a point-in-time copy of a system's state (disk, memory, or VM configuration) that can be used for rollback, forensic analysis, or baseline comparison. In virtualized environments, hypervisors like VMware and Hyper-V create snapshots by preserving the delta between the original disk image and subsequent changes.

## Why it matters
Ransomware operators specifically target and delete VM snapshots before triggering encryption — knowing that intact snapshots would allow victims to recover without paying. Defenders counter this by replicating snapshots offsite or to immutable storage (e.g., AWS S3 Object Lock), ensuring at least one clean recovery point survives the attack. This cat-and-mouse dynamic makes snapshot management a frontline ransomware defense strategy.

## Key facts
- Snapshots are **not backups** — they depend on the original disk remaining intact; if the parent volume fails, the snapshot is useless
- In cloud forensics, EBS snapshots (AWS) or managed disk snapshots (Azure) preserve evidence without taking production systems offline
- Snapshots can **expose sensitive data** — a snapshot of a running database may contain plaintext credentials or PII in memory
- **Snapshot sprawl** increases attack surface; unmanaged, forgotten snapshots may run outdated, unpatched software
- NIST SP 800-86 recommends snapshot acquisition as a forensic technique for volatile and semi-volatile cloud evidence

## Related concepts
[[Virtual Machines]] [[Immutable Backups]] [[Cloud Forensics]] [[Ransomware]] [[Baseline Configuration]]