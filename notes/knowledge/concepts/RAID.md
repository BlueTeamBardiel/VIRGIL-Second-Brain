# RAID

## What it is
Like a team of cyclists where one rider can crash and the peloton keeps racing, RAID spreads data across multiple disks so the failure of one doesn't stop the show. RAID (Redundant Array of Independent Disks) is a storage technology that combines multiple physical drives into a logical unit for redundancy, performance, or both. It is a hardware or software implementation providing fault tolerance at the disk level.

## Why it matters
In a ransomware attack that corrupts a single disk, a RAID 1 (mirrored) configuration ensures the server stays operational because an exact duplicate exists on a second drive — buying time for incident response without data loss. Conversely, attackers who understand RAID may know that RAID is **not a backup**: deleting a file propagates the deletion across all mirrors instantly, so it provides zero protection against logical corruption or malicious deletion.

## Key facts
- **RAID 0** (striping) splits data across drives for performance — zero redundancy, one drive fails and everything is lost
- **RAID 1** (mirroring) duplicates data across two drives — 50% storage efficiency, survives one drive failure
- **RAID 5** requires minimum 3 drives, uses distributed parity — survives **one** drive failure; rebuilding a degraded RAID 5 can expose a window of vulnerability
- **RAID 6** uses double parity across minimum 4 drives — survives **two** simultaneous drive failures
- **RAID 10** (1+0) combines mirroring and striping — high performance and redundancy, requires minimum 4 drives; preferred in high-availability enterprise environments
- RAID is a **availability** control, not a confidentiality or integrity control — it does not replace encryption or backups

## Related concepts
[[Fault Tolerance]] [[Backup Strategies]] [[Business Continuity Planning]] [[Data Integrity]] [[High Availability]]