# Journaling

## What it is
Like a ship's log that records every course correction so investigators can reconstruct exactly where things went wrong, journaling is a filesystem feature that records metadata about pending write operations before they're committed to disk. If the system crashes mid-write, the journal lets the OS replay or roll back the incomplete transaction rather than leaving the filesystem in a corrupted state.

## Why it matters
During incident response, a forensic analyst investigating ransomware discovers the attack began at 2:47 AM, but the filesystem timestamps on encrypted files show 3:15 AM. The journal (transaction log) fills in the gap — revealing exactly which files were accessed and in what order before encryption began, providing a reliable timeline that volatile memory alone couldn't supply. Without journaling, partial writes during the attack might have left data unrecoverable and the sequence of events unknowable.

## Key facts
- **ext3, ext4, NTFS, and HFS+** all implement journaling by default; FAT32 does **not**, making it more vulnerable to corruption and harder to forensically reconstruct
- Journals record **metadata changes** (file creation, deletion, permission changes) first; some modes (data journaling) also record file content, at a performance cost
- Three journaling modes in Linux: **journal** (safest, slowest), **ordered** (default for ext4 — data written before metadata), and **writeback** (fastest, least safe)
- In NTFS, the equivalent is the **$LogFile** and **$UsnJrnl (Update Sequence Number Journal)** — both are prime forensic artifacts for CySA+ investigations
- Journaling reduces data loss on unexpected shutdown but is **not a backup** — it only protects filesystem integrity, not file content from deletion

## Related concepts
[[File System Forensics]] [[NTFS Artifacts]] [[Log Management]] [[Incident Response]] [[Data Integrity]]