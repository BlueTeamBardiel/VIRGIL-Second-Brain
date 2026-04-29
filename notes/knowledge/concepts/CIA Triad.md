# CIA Triad

## What it is
Think of a hospital's patient records: a nurse needs to *read* the file (confidentiality), trust that the dosage written hasn't been tampered with (integrity), and pull it up instantly during an emergency (availability). The CIA Triad is the foundational security framework defining these three core properties — Confidentiality, Integrity, and Availability — that any secure system must protect.

## Why it matters
In the 2017 NotPetya attack, all three pillars were simultaneously violated: data was encrypted (confidentiality lost as attackers accessed systems), records were corrupted (integrity destroyed), and entire shipping companies like Maersk were paralyzed for weeks (availability obliterated). Security controls are designed and evaluated against exactly these three axes — a firewall protects confidentiality, a hash protects integrity, a UPS protects availability.

## Key facts
- **Confidentiality** is enforced through encryption, access controls, and data classification — violated by eavesdropping and credential theft
- **Integrity** is enforced through hashing (SHA-256), digital signatures, and checksums — violated by man-in-the-middle modification or insider tampering
- **Availability** is enforced through redundancy, failover, and DDoS mitigation — violated by ransomware and denial-of-service attacks
- Each attack type maps to a pillar: snooping → Confidentiality, data alteration → Integrity, ransomware → Availability
- The **DAD model** (Disclosure, Alteration, Denial) is the adversarial mirror of CIA — expect to see both on Security+ exams
- Some frameworks extend CIA with **non-repudiation** (you can't deny sending a signed message), treating it as a fourth pillar

## Related concepts
[[Access Control]] [[Hashing and Data Integrity]] [[Denial of Service Attacks]] [[Encryption]] [[Non-Repudiation]]