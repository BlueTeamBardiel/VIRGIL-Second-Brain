# Magnetic Tape

## What it is
Like a vinyl record that stores data linearly — you can't jump to track 5 without passing tracks 1 through 4 — magnetic tape is a sequential-access storage medium that encodes binary data as polarized magnetic particles on a thin plastic strip. It is one of the oldest persistent storage technologies, still widely used today for large-scale, long-term data archiving due to its low cost per gigabyte.

## Why it matters
Organizations often use tape libraries as their last line of defense in a 3-2-1 backup strategy — three copies of data, two media types, one offsite. During a ransomware attack, if an adversary compromises all online and near-line storage, an air-gapped tape backup stored offsite remains unencrypted and recoverable, making it the difference between paying a ransom and restoring operations cleanly.

## Key facts
- Tape follows sequential access, making random reads slow but large sequential writes extremely fast and efficient for backup workloads
- Modern LTO (Linear Tape-Open) standards (LTO-9) support up to 45 TB compressed per cartridge, with WORM (Write Once, Read Many) variants for tamper-evident archiving
- Tape is inherently air-gapped once physically removed from the drive, protecting against network-borne ransomware and wiper malware
- Physical destruction, degaussing (exposing to a strong magnetic field), or overwriting are accepted NIST SP 800-88 sanitization methods for tape media
- Tape is classified as an **offline backup** medium; its long shelf life (30+ years under proper conditions) makes it relevant for legal holds and compliance retention policies

## Related concepts
[[Backup and Recovery]] [[Data Sanitization]] [[Air Gap]] [[WORM Storage]] [[3-2-1 Backup Strategy]]