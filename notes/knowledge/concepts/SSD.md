# SSD

## What it is
Unlike a filing cabinet where you can shred a document in one pass, an SSD is more like a whiteboard covered in sticky notes — erasing one spot doesn't mean the data is truly gone, just moved around. A Solid-State Drive (SSD) is a non-volatile storage device that uses NAND flash memory chips and a controller to store data electrically, with no moving mechanical parts. Unlike HDDs, SSDs manage data through wear-leveling algorithms and over-provisioning that fundamentally complicate traditional data destruction methods.

## Why it matters
During a forensic investigation or secure decommissioning, an analyst who wipes an SSD using a DoD 7-pass overwrite (designed for magnetic HDDs) may leave recoverable data intact — the SSD controller silently redirected writes to reserve cells the overwrite never touched. This is a critical gap in data sanitization procedures: NIST SP 800-88 specifically recommends cryptographic erase or physical destruction for SSDs rather than overwriting. Organizations that apply HDD sanitization standards to SSDs risk violating data protection regulations like HIPAA or GDPR when disposing of hardware.

## Key facts
- **Wear leveling** distributes writes across all cells, meaning overwritten "secure delete" data may persist in remapped blocks
- **Cryptographic erase** (encrypting the drive then discarding the key) is the NIST SP 800-88 recommended sanitization method for SSDs
- **Over-provisioning** reserves 7–25% of NAND capacity that the OS cannot address, making this space invisible to standard wipe tools
- **ATA Secure Erase** command is the manufacturer-level method that instructs the SSD controller to wipe all cells, including reserved areas
- SSDs do **not** support reliable file-level forensic recovery timelines — TRIM commands proactively zero deleted blocks, complicating acquisition

## Related concepts
[[Data Sanitization]] [[Forensic Acquisition]] [[Full Disk Encryption]]