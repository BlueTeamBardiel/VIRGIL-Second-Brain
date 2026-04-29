# digital forensics

## What it is
Like a crime scene investigator who photographs the room before touching anything, then reconstructs events from fingerprints and footprints — digital forensics is the disciplined collection, preservation, and analysis of electronic evidence to reconstruct what happened on a system. It follows strict procedures to ensure evidence remains admissible in legal proceedings.

## Why it matters
After a ransomware attack on a hospital network, forensic investigators image the infected hard drives using write blockers, then analyze event logs, registry hives, and prefetch files to determine the initial infection vector — perhaps a phishing email opened three weeks prior. Without forensics, the organization cannot patch the root cause, attribute the attack, or satisfy regulatory breach notification requirements.

## Key facts
- **Order of volatility** dictates collection priority: CPU registers and RAM first, then swap/pagefile, disk, then remote logs — volatile data disappears on reboot
- **Chain of custody** documents every person who handled evidence, with timestamps and cryptographic hashes (MD5/SHA-256) to prove data integrity — breaking it can make evidence inadmissible
- **Write blockers** (hardware or software) prevent any write operations to original media, preserving forensic soundness during imaging
- **Forensic image types**: dd (raw bit-for-bit copy), E01 (EnCase format with built-in hashing and compression), and AFF are the most common acquisition formats
- **Live forensics** vs. **dead forensics**: live acquisition captures running processes and RAM on a powered-on system; dead acquisition images powered-off storage media — each has irreplaceable evidence the other cannot capture

## Related concepts
[[chain of custody]] [[incident response]] [[log analysis]]