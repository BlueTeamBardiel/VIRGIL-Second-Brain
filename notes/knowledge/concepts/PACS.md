# PACS

## What it is
Think of PACS like a bouncer at a club who checks your wristband at every door inside — not just the entrance. A **Physical Access Control System (PACS)** is the integrated hardware and software infrastructure (badge readers, door controllers, biometrics, cameras) that governs who can physically enter specific areas of a facility, logging every access event. Unlike a simple lock-and-key, PACS enforces *granular, auditable* access policies tied to individual identities.

## Why it matters
In 2019, a threat actor tailgated into a water treatment facility by following an authorized employee through a badge-controlled door — a classic PACS failure called *piggybacking*. Had the facility combined badge readers with mantraps (interlocking double doors that trap one person at a time) and tailgating detection cameras, the intrusion would have been physically prevented before any cyber-physical sabotage could occur.

## Key facts
- **Mantrap (airlock)** is the gold-standard PACS countermeasure against tailgating — only one person can pass per authentication event
- PACS credentials exist in a hierarchy: something you **have** (smart card/CAC), something you **are** (biometric), something you **know** (PIN) — multi-factor combinations dramatically reduce bypass risk
- **Piggybacking** (with victim's consent) and **tailgating** (without consent) are distinct threats but both defeated by mantraps and motion sensors
- PACS logs feed into SIEM systems as a physical-layer data source — correlating badge events with network logins detects insider threats (e.g., badge-in at 2 AM + large data exfiltration)
- Convergence of PACS with cyber systems (network-connected door controllers) creates attack surface — compromised PACS credentials can unlock server rooms

## Related concepts
[[Mantrap]] [[Tailgating]] [[Multifactor Authentication]] [[SIEM]] [[Insider Threat]]