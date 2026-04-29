# Clop

## What it is
Like a bank robber who photocopies every document in the vault *before* detonating the safe, Clop steals data first, then encrypts it. Clop (also written "Cl0p") is a ransomware-as-a-service (RaaS) group and associated malware strain known for large-scale double extortion attacks, where victims face both encrypted systems and threatened public data leaks on Clop's dark web leak site.

## Why it matters
In 2023, Clop exploited a zero-day SQL injection vulnerability (CVE-2023-34362) in the MOVEit Transfer file-sharing software, compromising hundreds of organizations worldwide — including government agencies and universities — without ever deploying traditional ransomware encryption in many cases. The attackers simply exfiltrated sensitive data and demanded payment to suppress its release, demonstrating that encryption is no longer required to extort victims.

## Key facts
- Clop pioneered **mass exploitation of managed file transfer (MFT) platforms**, targeting GoAnywhere MFT (2023) and MOVEit Transfer (2023) in back-to-back campaigns affecting 2,000+ organizations.
- Operates as **Ransomware-as-a-Service (RaaS)**, with core developers leasing infrastructure and tooling to affiliate attackers.
- Uses **double extortion**: encrypts files *and* exfiltrates data, threatening publication on "CL0P^_-LEAKS" Tor site if ransom is unpaid.
- Attributed to a Russian-speaking threat actor group tracked as **TA505** by Proofpoint and **GOLD TAHOE** by Secureworks.
- The MOVEit campaign leveraged a **zero-day SQL injection flaw** allowing unauthenticated remote code execution — patched in June 2023 but widely exploited before disclosure.

## Related concepts
[[Ransomware-as-a-Service]] [[Double Extortion]] [[Zero-Day Vulnerability]] [[SQL Injection]] [[Threat Actor Attribution]]