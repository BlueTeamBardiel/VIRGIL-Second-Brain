# T1491 - Data Encrypted for Impact

## What it is
Imagine a thief who breaks into a library, locks every book in unbreakable safes, and leaves a ransom note demanding payment for the combination. Data Encrypted for Impact is exactly that: an adversary encrypts files on a target system using strong cryptography, rendering them inaccessible, then demands payment or action to restore access. Unlike data theft, the goal here is disruption and extortion — not exfiltration.

## Why it matters
The 2021 Colonial Pipeline attack used DarkSide ransomware to encrypt operational systems, forcing a shutdown of 5,500 miles of fuel pipeline and triggering fuel shortages across the U.S. East Coast. The company paid approximately $4.4 million in Bitcoin, though the FBI later recovered a portion. This incident demonstrated that ransomware against critical infrastructure carries national security implications far beyond the ransom itself.

## Key facts
- **MITRE ATT&CK ID: T1486** — Note: T1491 is *Defacement*; ransomware encryption specifically maps to **T1486**, a common exam trap worth knowing
- Ransomware typically uses **asymmetric + symmetric hybrid encryption**: a unique AES key encrypts files, then RSA encrypts that key — decryption is impossible without the attacker's private key
- Common delivery vectors include phishing (T1566), exposed RDP (T1021.001), and exploiting public-facing applications (T1190)
- Effective defenses include **immutable, offline backups** (3-2-1 rule), network segmentation, and disabling VSS (Volume Shadow Copy deletion, T1490, is a common companion technique)
- Incident response priority: **isolate before remediation** — do not attempt decryption on a live, potentially still-communicating endpoint

## Related concepts
[[T1490 - Inhibit System Recovery]] [[T1566 - Phishing]] [[Ransomware Defense and Recovery]] [[Business Impact Analysis]] [[Backup Strategies]]