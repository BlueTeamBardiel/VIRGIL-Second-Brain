# disk

## What it is
Like a massive filing cabinet where every drawer stays labeled even after you "throw away" the file — a disk is a persistent storage medium (HDD or SSD) that retains data without power. Unlike RAM, data written to disk survives reboots, making it both a treasure trove for investigators and a liability for defenders.

## Why it matters
In a ransomware incident, attackers encrypt disk contents and demand payment — but forensic responders can image the disk sector-by-sector before attempting recovery, preserving evidence of the attack chain. Conversely, improper disk disposal (tossing an old server without wiping) has led to real breaches where sensitive customer data was recovered from "deleted" files by anyone with a $20 USB adapter.

## Key facts
- **Deletion ≠ erasure**: Deleting a file removes the pointer in the filesystem, not the data — forensic tools like Autopsy can recover it until sectors are overwritten
- **Slack space**: The gap between a file's logical size and the disk cluster size can contain remnants of previously stored data — a forensic artifact
- **Secure wiping standards**: DoD 5220.22-M specifies overwrite patterns; NIST 800-88 recommends "Clear, Purge, or Destroy" based on media sensitivity
- **SSDs complicate forensics**: TRIM and wear-leveling on SSDs can automatically erase deleted blocks, making recovery harder — and full-disk encryption (BitLocker, FileVault) renders recovered data unreadable without keys
- **Disk imaging**: Forensic copies must be bit-for-bit (using `dd` or FTK Imager) and hash-verified (MD5/SHA-256) to maintain chain of custody

## Related concepts
[[forensics]] [[encryption]] [[data remanence]]