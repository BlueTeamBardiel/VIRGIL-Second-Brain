# Degaussing

## What it is
Like erasing a whiteboard by running a powerful magnet over it until no trace of the marker remains, degaussing works by exposing magnetic storage media to an intense electromagnetic field that randomizes the magnetic domains storing data. This renders the data on hard drives, magnetic tapes, and floppy disks completely unrecoverable — even by forensic tools. It is a form of sanitization, not just deletion.

## Why it matters
When a government contractor decommissions servers containing classified data, simply formatting drives leaves residual magnetic signatures recoverable with specialized tools like magnetic force microscopy. Degaussing is used as a NIST-approved sanitization method to ensure data destruction before physical disposal or repurposing. Without it, an attacker recovering discarded hardware could reconstruct sensitive files from "deleted" drives.

## Key facts
- Degaussing is effective on **magnetic media only** — it does **not** work on SSDs, flash drives, or optical media (CDs/DVDs), which require different destruction methods
- After degaussing, a hard drive is typically **no longer functional** because the servo tracks used by the drive's firmware are also erased
- NIST SP 800-88 ("Guidelines for Media Sanitization") recognizes degaussing as an approved **Clear** or **Purge** technique depending on classification level
- The strength of a degausser is measured in **Oersteds (Oe)**; NSA-listed degaussers must meet minimum field strength requirements (typically 5,000+ Oe for modern drives)
- Degaussing alone does **not** guarantee physical destruction — for the highest assurance (e.g., Top Secret data), it is combined with **physical shredding or disintegration**

## Related concepts
[[Media Sanitization]] [[Data Remanence]] [[Secure Data Destruction]]