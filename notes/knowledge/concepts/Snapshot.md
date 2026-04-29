# Snapshot

## What it is
Like a photograph of a crime scene frozen in time, a snapshot is a point-in-time copy of a system's state — capturing disk contents, memory, configurations, or virtual machine state exactly as they existed at that moment. Unlike a full backup, snapshots typically record only the *delta* (changed blocks) from a baseline, making them fast to create and space-efficient.

## Why it matters
During ransomware incidents, attackers increasingly target and delete VM snapshots before detonating their payload — specifically to eliminate the victim's fastest recovery path. Defenders who store snapshots in immutable, offsite repositories (or use snapshot-locking features in hypervisors like VMware vSphere) can restore encrypted systems in minutes rather than days, dramatically reducing ransom leverage.

## Key facts
- **Forensic integrity**: Memory snapshots capture volatile data (running processes, network connections, encryption keys in RAM) that disappears on reboot — critical for live forensics and malware analysis
- **Hypervisor snapshots** (VMware, Hyper-V, KVM) save full VM state including CPU registers and memory, enabling rollback to a known-good configuration
- **Copy-on-Write (CoW)** is the dominant snapshot mechanism — original data stays in place; changes are written to a separate delta file, preserving the original state
- **Snapshot ≠ Backup**: Snapshots stored on the same volume as the source are destroyed if the disk fails; they complement but do not replace offsite backups
- For **CySA+/Security+**: Snapshots are a key control under Business Continuity (RTO/RPO goals) and appear in IR playbooks as a rapid recovery mechanism

## Related concepts
[[Virtual Machine Security]] [[Forensic Imaging]] [[Backup and Recovery]] [[Ransomware]] [[Chain of Custody]]