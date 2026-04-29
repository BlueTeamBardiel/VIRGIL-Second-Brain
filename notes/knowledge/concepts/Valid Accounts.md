# Valid Accounts

## What it is
Like a thief who steals a hotel keycard instead of picking the lock, Valid Accounts is the technique where attackers use legitimate credentials to access systems rather than exploiting vulnerabilities. Precisely: it is MITRE ATT&CK Technique T1078, where adversaries obtain and abuse existing accounts (local, domain, cloud, or default) to authenticate as trusted users and blend into normal traffic.

## Why it matters
In the 2020 SolarWinds supply chain attack, threat actors used compromised service accounts with valid SAML tokens to move laterally across Microsoft 365 environments — triggers that signature-based detection completely missed because every login looked legitimate. Defenders countered by implementing Conditional Access policies and auditing accounts with excessive privilege, specifically hunting for authentication events outside normal business hours or geolocation baselines.

## Key facts
- Covers four sub-techniques: Default Accounts (T1078.001), Domain Accounts (T1078.002), Local Accounts (T1078.003), and Cloud Accounts (T1078.004)
- Classified under both **Initial Access** and **Persistence** tactics in MITRE ATT&CK — meaning one technique serves multiple attack phases
- Default credentials (admin/admin, admin/password) remain one of the fastest exploitation paths; changing them is a CIS Control baseline requirement
- Detection relies on behavioral analytics, not signatures — look for impossible travel, off-hours logins, and privilege anomalies (UEBA tooling)
- Mitigations include MFA enforcement, privileged access workstations (PAWs), and least privilege principles; MFA alone blocks ~99.9% of credential-based attacks per Microsoft telemetry

## Related concepts
[[Credential Dumping]] [[Pass the Hash]] [[Privilege Escalation]] [[Multi-Factor Authentication]] [[Lateral Movement]]