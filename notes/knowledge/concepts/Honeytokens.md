# Honeytokens

## What it is
Like a dye pack hidden inside a stack of cash — harmless until stolen, then it explodes with evidence — a honeytoken is a fake digital asset (credential, file, record, or API key) designed to have no legitimate use, so any interaction with it is an unambiguous sign of intrusion. Unlike honeypots (full decoy systems), honeytokens are individual data objects embedded within real environments.

## Why it matters
In 2020-style credential stuffing attacks, defenders plant fake username/password pairs in databases. When an attacker exfiltrates the database and attempts to use those credentials, the login attempt triggers an alert — revealing both the breach and the attacker's infrastructure. This gives defenders early warning that real credentials may also be compromised, hours or days before damage escalates.

## Key facts
- A honeytoken triggers alerts on **access or use**, not just presence — making it a detection control, not a preventive one
- Common types include: fake AWS access keys, ghost user accounts, canary documents with tracking pixels, and bogus database records
- **Canarytokens.org** is a widely-used free tool for generating trackable honeytokens (e.g., URLs, Word docs, DNS tokens)
- Honeytokens produce **near-zero false positives** — since no legitimate process should ever touch them, any alert is highly reliable
- They support the **deception** layer of defense-in-depth and map to MITRE ATT&CK's **T1078 (Valid Accounts)** detection strategies

## Related concepts
[[Honeypots]] [[Deception Technology]] [[Intrusion Detection Systems]] [[Threat Intelligence]] [[Indicators of Compromise]]