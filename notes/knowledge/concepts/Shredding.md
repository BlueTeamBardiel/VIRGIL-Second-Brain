# Shredding

## What it is
Like burning classified documents before an enemy captures a base, shredding overwrites storage media with random or patterned data to make original content unrecoverable. Precisely, it is a data sanitization technique that performs multiple overwrite passes on a file or disk sector, preventing forensic recovery of deleted data.

## Why it matters
When a hospital disposes of old hard drives without shredding, attackers using tools like Recuva or Autopsy can recover patient records from "deleted" files because standard deletion only removes the filesystem pointer, not the actual data. Proper shredding — using tools like `shred` on Linux or DBAN for full disk sanitization — makes this recovery computationally infeasible, protecting PHI and ensuring HIPAA compliance.

## Key facts
- Standard file deletion only removes the directory entry; data remains on disk until overwritten by new writes
- The DoD 5220.22-M standard historically specified 7-pass overwrite patterns, though NIST SP 800-88 now recommends simpler methods (often 1-3 passes) for modern drives as sufficient
- For SSDs and flash storage, overwriting is unreliable due to wear leveling — physical destruction or cryptographic erasure is preferred
- The `shred` command on Linux supports configurable overwrite passes (`shred -n 3 -z filename`)
- NIST SP 800-88 categorizes sanitization into three levels: Clear, Purge, and Destroy — shredding software typically achieves "Clear" or "Purge" depending on implementation

## Related concepts
[[Data Sanitization]] [[Secure Deletion]] [[Drive Wiping]] [[Cryptographic Erasure]] [[Chain of Custody]]