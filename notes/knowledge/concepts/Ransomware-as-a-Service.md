# Ransomware-as-a-Service

## What it is
Think of it like a McDonald's franchise model for crime: a core developer builds and maintains the ransomware infrastructure, then licenses it to affiliate "operators" who handle the actual attacks in exchange for a revenue cut. Ransomware-as-a-Service (RaaS) is a criminal business model where ransomware developers lease their malware toolkits, command-and-control infrastructure, and negotiation portals to third-party attackers, typically taking 20–30% of ransom payments as commission.

## Why it matters
The 2021 Colonial Pipeline attack was executed by a DarkSide RaaS affiliate — not DarkSide's core developers themselves. This distinction matters defensively because it means threat actor attribution is layered: dismantling the affiliate doesn't kill the platform, and taking down the platform doesn't immediately stop active affiliates mid-campaign.

## Key facts
- RaaS groups typically operate on the dark web with professional support portals, dashboards showing infection statistics, and even customer service for victims paying ransoms
- The affiliate split is commonly 70/30 or 80/20 (affiliate keeps the larger share), incentivizing widespread recruitment of technically unsophisticated operators
- Double extortion is now standard in RaaS: data is exfiltrated *before* encryption, allowing operators to threaten public leak even if backups prevent decryption leverage
- Major RaaS groups include LockBit, BlackCat (ALPHV), Conti (defunct), and REvil — each with distinct TTPs mapped to MITRE ATT&CK
- Indicators of RaaS compromise often appear during the dwell period (average 9–11 days) before encryption, including Cobalt Strike beacons and legitimate admin tool abuse (LOLBins)

## Related concepts
[[Double Extortion]] [[Command and Control Infrastructure]] [[Indicators of Compromise]] [[MITRE ATT&CK Framework]] [[Lateral Movement]]