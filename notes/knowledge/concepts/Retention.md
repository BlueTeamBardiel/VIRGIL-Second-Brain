# Retention

## What it is
Like a library that keeps old books in the basement for seven years before shredding them, data retention is the formal policy governing how long an organization keeps specific types of data before securely disposing of it. Precisely defined: retention is the practice of storing data for a legally or operationally mandated period, after which it must be purged, archived, or destroyed according to defined procedures.

## Why it matters
During a breach investigation, forensic analysts discovered that a company had deleted six months of firewall logs — logs that would have revealed the attacker's lateral movement pattern — because their retention policy only mandated 90 days of storage. Without adequate retention windows aligned to regulatory requirements (like PCI DSS's 12-month log requirement), incident response becomes guesswork and legal liability skyrockets.

## Key facts
- **PCI DSS** requires audit logs be retained for at least 12 months, with the most recent 3 months immediately available for analysis
- **HIPAA** mandates healthcare records be retained for a minimum of 6 years from creation or last use
- Retention policies must address both **active retention** (accessible data) and **legal holds** — when litigation freezes normal deletion schedules to preserve evidence
- Over-retention is also a risk: keeping data longer than necessary increases breach exposure and violates GDPR's **data minimization** principle
- Retention schedules should classify data by type (PII, financial, logs) and assign different timelines — a one-size-fits-all policy is a compliance failure waiting to happen

## Related concepts
[[Data Classification]] [[Legal Hold]] [[Log Management]] [[Data Destruction]] [[Compliance Frameworks]]