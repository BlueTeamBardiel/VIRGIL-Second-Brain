# Confidentiality, Integrity, and Availability

## What it is
Think of a hospital's medication cabinet: only authorized nurses can open it (confidentiality), the drug labels can't be tampered with (integrity), and the cabinet must be accessible during emergencies (availability). The CIA Triad is the foundational security model defining three core properties every information system must protect — confidentiality ensures data is seen only by authorized parties, integrity ensures data isn't altered without detection, and availability ensures systems remain accessible to legitimate users when needed.

## Why it matters
A ransomware attack elegantly destroys all three pillars simultaneously: it exfiltrates sensitive data before encrypting it (breaking confidentiality), corrupts or locks files (breaking integrity), and takes systems offline entirely (breaking availability). Defenders use this triad as a diagnostic framework — when an incident occurs, they immediately ask which pillar was violated to prioritize response actions and control selection.

## Key facts
- **Confidentiality** is protected by encryption, access controls, and data classification schemes (e.g., AES-256 for data at rest)
- **Integrity** is verified using hashing algorithms (SHA-256) and digital signatures — any bit change produces a completely different hash value
- **Availability** is measured in uptime percentages (e.g., "five nines" = 99.999% = ~5 minutes downtime/year) and protected via redundancy and failover systems
- The **Parkerian Hexad** extends CIA by adding Possession, Authenticity, and Utility — relevant for advanced exam questions
- Attacks map directly to the triad: eavesdropping → confidentiality; man-in-the-middle → integrity; DDoS → availability
- Security controls are evaluated against all three pillars because strengthening one can weaken another (heavy encryption can reduce availability)

## Related concepts
[[Encryption]] [[Hashing and Data Integrity]] [[DDoS Attacks]] [[Access Control Models]] [[Risk Management]]