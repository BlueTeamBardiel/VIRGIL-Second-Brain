# Data Corruption

## What it is
Like a librarian who secretly replaces one word on every third page of a book — the text looks intact, but the meaning is destroyed. Data corruption occurs when information is unintentionally or maliciously altered, rendering it inaccurate, unusable, or untrustworthy, without necessarily destroying it entirely.

## Why it matters
In a ransomware-adjacent attack called a "slow burn," an attacker silently corrupts database records over weeks before triggering detection — ensuring that all backups also contain corrupted data, making recovery nearly impossible. This is why backup integrity verification (hashing snapshots and comparing checksums) is a critical defense, not just backup frequency.

## Key facts
- **Integrity** is the CIA triad principle violated by data corruption — not confidentiality or availability
- **Checksums and cryptographic hashes (MD5, SHA-256)** detect corruption by producing a different hash value if even one bit changes
- **Bit rot** is passive corruption caused by physical media degradation over time; active corruption is caused by malware, power failures, or software bugs
- **Write blockers** are used in forensic investigations specifically to prevent accidental corruption of evidence drives during acquisition
- Data corruption attacks on **ICS/SCADA systems** (e.g., Stuxnet) can cause physical-world damage by feeding false operational values to industrial controllers

## Related concepts
[[Integrity]] [[Hashing]] [[File Integrity Monitoring]] [[Stuxnet]] [[Backup and Recovery]]