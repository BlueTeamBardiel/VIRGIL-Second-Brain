# Disk Wipe

## What it is
Like burning a letter instead of just throwing it in the trash — disk wiping overwrites every sector of a storage device with random data (or zeros) so that the original content cannot be recovered. Unlike a standard delete operation, which merely removes the file's directory entry while leaving data physically intact, a disk wipe destroys the underlying bits themselves. It is a deliberate sanitization method used to permanently eliminate data before device disposal, reuse, or decommissioning.

## Why it matters
When a hospital sells decommissioned workstations without properly wiping drives, attackers can use forensic tools like Autopsy or PhotoRec to recover patient records from "deleted" files within minutes. This exact scenario has triggered HIPAA breach notifications and six-figure fines. Proper disk wiping — or physical destruction — is the last line of defense in an asset disposal policy.

## Key facts
- **DoD 5220.22-M** is the classic standard specifying a 3-pass overwrite (0s, 1s, random data), though modern guidance (NIST SP 800-88) often recommends a **single-pass overwrite** as sufficient for magnetic media.
- **SSDs and flash storage** complicate wiping because wear-leveling algorithms may leave data in inaccessible blocks — NIST SP 800-88 recommends **Purge** (Secure Erase command) or physical destruction for SSDs.
- Three sanitization levels per NIST SP 800-88: **Clear** (overwrite), **Purge** (cryptographic erase or Secure Erase), and **Destroy** (shredding/degaussing).
- **Cryptographic erasure** — destroying the encryption key of a fully-encrypted drive — is accepted as a valid sanitization method under NIST SP 800-88.
- Degaussing destroys data on magnetic media by exposing it to a strong magnetic field, but renders the drive **permanently unusable** and does not work on SSDs.

## Related concepts
[[Data Sanitization]] [[Secure Disposal]] [[Data Remanence]] [[NIST SP 800-88]] [[Cryptographic Erasure]]