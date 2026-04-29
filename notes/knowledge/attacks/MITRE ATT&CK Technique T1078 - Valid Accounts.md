# MITRE ATT&CK Technique T1078 - Valid Accounts

## What it is
Like a thief who steals a hotel keycard instead of picking the lock — they walk right through the front door and blend in with legitimate guests. T1078 describes adversaries obtaining and using legitimate credentials (default, local, domain, or cloud accounts) to authenticate to systems, bypassing detection mechanisms that focus on malicious tools or exploits.

## Why it matters
In the 2020 SolarWinds supply chain attack, threat actors used valid SAML tokens and service account credentials to move laterally across victim networks for months — appearing as normal administrative activity. Defenders missed the intrusion precisely because the accounts were real and the authentication was technically legitimate, highlighting why anomaly-based detection matters as much as signature-based controls.

## Key facts
- T1078 has four sub-techniques: Default Accounts (T1078.001), Domain Accounts (T1078.002), Local Accounts (T1078.003), and Cloud Accounts (T1078.004)
- It spans multiple ATT&CK tactics simultaneously: **Initial Access**, **Persistence**, **Privilege Escalation**, and **Defense Evasion** — making it uniquely dangerous
- Default credentials (admin/admin, admin/password) remain one of the most exploited vectors, particularly against IoT devices and network appliances
- Detection relies heavily on behavioral analytics: login at unusual hours, impossible travel (geographically distant logins within minutes), and first-time access to sensitive resources
- Mitigations include Multi-Factor Authentication (MFA), Privileged Access Workstations (PAWs), regular account audits, and disabling or renaming default accounts

## Related concepts
[[Credential Dumping T1003]] [[Pass the Hash]] [[Privilege Escalation]] [[Identity and Access Management]] [[UEBA (User and Entity Behavior Analytics)]]