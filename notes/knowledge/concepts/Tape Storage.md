# Tape Storage

## What it is
Like a VHS cassette holding a full movie season, magnetic tape stores massive amounts of sequential data on a long ribbon of magnetic material — you can't jump to chapter 5 without rewinding past chapters 1–4. Precisely, tape storage is an offline, sequential-access backup medium used for long-term data archival, capable of holding petabytes of data at very low cost per gigabyte.

## Why it matters
Tape storage is a critical line of defense against ransomware because encrypted or corrupted data cannot reach an air-gapped tape sitting in a vault. Organizations following the **3-2-1 backup rule** (3 copies, 2 media types, 1 offsite) often rely on tape as that offsite, offline copy — making it the last recovery option when all networked systems are compromised by a destructive attack like NotPetya.

## Key facts
- **Air-gapped by nature**: Once ejected and stored physically, tape is completely unreachable by network-based attackers — a property called "offline immutability."
- **Sequential access weakness**: Restoration from tape is slow because data must be read linearly; recovery time objectives (RTOs) must account for this latency.
- **LTO (Linear Tape-Open)** is the dominant modern standard; LTO-9 holds up to 45TB compressed per cartridge.
- **Retention risk**: Tapes stored insecurely represent a significant data breach vector — lost or stolen tapes containing unencrypted backups have triggered major HIPAA and PCI-DSS violations.
- **Write-Once, Read-Many (WORM)** tape formats prevent overwriting, supporting compliance requirements for tamper-evident audit logs.

## Related concepts
[[Backup and Recovery]] [[Air Gap]] [[Data Classification]] [[3-2-1 Backup Rule]] [[Encryption at Rest]]