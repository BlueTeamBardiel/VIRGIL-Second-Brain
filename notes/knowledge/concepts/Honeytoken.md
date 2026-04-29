# Honeytoken

## What it is
Like planting a marked $20 bill in a cash register to catch a thieving employee — a honeytoken is a fake digital asset (credential, file, record, or API key) that has no legitimate use, so any access to it is automatically evidence of malicious activity. It's a deception-based detection mechanism, not a prevention one.

## Why it matters
In 2020-style credential stuffing attacks, defenders embed fake username/password pairs into databases. When an attacker exfiltrates and uses those credentials, the login attempt triggers an alert — exposing the breach even before the organization realizes data was stolen. This gives defenders visibility into compromise timing and attacker behavior that traditional logging alone would miss.

## Key facts
- Honeytokens are *data*, not systems — distinguishing them from honeypots, which are full decoy machines or services
- A canary token is a popular implementation: a unique URL or document that phones home when opened, revealing the attacker's IP and timing
- Because no legitimate user ever touches a honeytoken, any interaction has a near-zero false-positive rate — every alert is actionable
- Common honeytoken types: fake AWS access keys, bogus database records, decoy documents, planted email addresses in harvested lists
- Effective for detecting insider threats and supply chain compromises, not just external attackers — any access path triggers detection

## Related concepts
[[Honeypot]] [[Canary Token]] [[Deception Technology]] [[Threat Detection]] [[Insider Threat]]