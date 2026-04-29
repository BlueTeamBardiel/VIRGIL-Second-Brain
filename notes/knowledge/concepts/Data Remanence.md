# Data Remanence

## What it is
Like a whiteboard that still shows ghostly outlines of erased marker after you wipe it down, storage media retains traces of data even after deletion or formatting. Data remanence is the residual physical representation of data that persists on storage media after attempts have been made to remove or erase it. Magnetic fields, flash memory charge states, and even microscopic physical changes in drive platters can preserve recoverable data long after "deletion."

## Why it matters
When a healthcare company sells decommissioned laptops without properly sanitizing the drives, a buyer running forensic recovery tools like Recuva or Autopsy can reconstruct patient records — creating a HIPAA breach from hardware the organization thought was clean. This exact scenario has led to multi-million dollar regulatory fines. Proper sanitization procedures are not optional; they are a compliance requirement.

## Key facts
- **Three NIST-approved sanitization methods** (SP 800-88): Clear (overwriting), Purge (cryptographic erase or degaussing), and Destroy (physical destruction like shredding or incineration)
- **Deleting a file** only removes the pointer in the file system table — the actual data blocks remain intact until overwritten
- **SSDs complicate sanitization**: wear leveling and over-provisioning mean overwrite passes may miss reserved blocks; cryptographic erase is the preferred SSD method
- **Degaussing** destroys magnetic media by exposing it to a powerful alternating magnetic field — renders HDDs unreadable but is ineffective on SSDs and optical media
- **NIST SP 800-88** is the authoritative standard for media sanitization and is directly testable on Security+ and CySA+

## Related concepts
[[Media Sanitization]] [[Cryptographic Erasure]] [[Digital Forensics]] [[Data Classification]] [[Chain of Custody]]