# ZFS

## What it is
Imagine a bank vault that not only stores your valuables but photographs everything going in or out, detects if someone swapped the gold bars for painted rocks, and can instantly rewind to yesterday's inventory — that's ZFS. ZFS (Zettabyte File System) is a combined volume manager and file system originally developed by Sun Microsystems that provides built-in data integrity verification, snapshot capability, and storage pooling at the filesystem level rather than relying on external tools.

## Why it matters
During a ransomware attack, ZFS snapshots can be a defender's secret weapon: because snapshots are read-only point-in-time copies stored outside the writable filesystem path, ransomware encrypting live data cannot touch them without explicit administrative commands. An incident responder on a ZFS-based system can roll back an entire volume to a pre-infection snapshot within minutes, dramatically reducing recovery time and data loss compared to traditional backup restoration.

## Key facts
- **Copy-on-Write (CoW):** ZFS never overwrites data in place — it writes new data to a fresh block and updates the pointer, making silent corruption virtually impossible and enabling instant snapshots with zero performance overhead at creation time.
- **Checksumming:** Every data block and metadata block carries a cryptographic checksum (SHA-256 or Fletcher-4); ZFS detects and self-heals silent data corruption ("bit rot") automatically in RAID configurations.
- **Storage Pools (zpools):** Disks are aggregated into a zpool, abstracting physical storage — similar to LVM but with integrity guarantees baked in.
- **Snapshot vs. Clone:** Snapshots are read-only; clones are writable copies derived from snapshots — both are forensically useful for preserving system state during incident response.
- **Encryption support:** ZFS native encryption (available since OpenZFS 0.8) encrypts at the dataset level, with keys manageable independently per dataset — relevant for data-at-rest compliance requirements.

## Related concepts
[[Copy-on-Write]] [[Data Integrity Verification]] [[Snapshot-Based Recovery]] [[Ransomware Defense]] [[Encryption at Rest]]