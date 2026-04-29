# MITRE ATT&CK T1078 - Valid Accounts

## What it is
Like a thief who steals a hotel keycard instead of picking the lock — they walk right through the front door looking like a guest. Valid Accounts is when an adversary uses legitimate credentials (stolen, purchased, or guessed) to authenticate to systems, bypassing security controls that look for intrusion rather than misuse.

## Why it matters
In the 2020 SolarWinds supply chain attack, threat actors used valid service account credentials to move laterally across victim networks for months undetected — SIEM alerts weren't firing because the logins *looked* normal. Defenders must baseline authentication behavior and flag anomalies like off-hours logins or impossible travel, not just failed login attempts.

## Key facts
- Splits into four sub-techniques: Default Accounts (T1078.001), Domain Accounts (T1078.002), Local Accounts (T1078.003), and Cloud Accounts (T1078.004)
- Attackers often obtain credentials through phishing, credential dumping (e.g., Mimikatz), or purchasing them on dark web markets — the accounts themselves are never "broken into"
- This technique directly enables **Persistence** and **Privilege Escalation** — a valid admin account means an attacker can return and operate with elevated rights
- Detection relies on behavioral analytics: impossible travel, login time anomalies, and user-agent mismatches rather than signature-based detection
- Mitigations include Multi-Factor Authentication (MFA), Privileged Access Workstations (PAWs), and disabling default/built-in accounts like the Windows built-in Administrator

## Related concepts
[[Credential Dumping T1003]] [[Privilege Escalation]] [[Multi-Factor Authentication]] [[Lateral Movement]] [[Identity and Access Management]]