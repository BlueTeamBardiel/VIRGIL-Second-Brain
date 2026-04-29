# MITRE ATT&CK T1078

## What it is
Like a thief who steals a janitor's master keycard instead of picking every lock, T1078 (Valid Accounts) describes attackers using legitimate credentials — stolen, purchased, or guessed — to gain access to systems without triggering intrusion alarms.

## Why it matters
In the 2020 SolarWinds supply chain attack, threat actors used compromised service accounts with valid tokens to move laterally through victim networks for months undetected. Because authentication logs showed legitimate credential use, conventional signature-based detection completely missed the intrusion until forensic investigation began.

## Key facts
- T1078 has four sub-techniques: Default Accounts (T1078.001), Domain Accounts (T1078.002), Local Accounts (T1078.003), and Cloud Accounts (T1078.004)
- Attackers commonly obtain valid credentials via phishing, credential dumping, or purchasing them from dark web brokers — not necessarily through technical exploits
- Valid account abuse is particularly dangerous because it bypasses perimeter controls; detection requires behavioral analytics (UEBA) rather than signature matching
- Defense countermeasures include enforcing MFA, applying least privilege, auditing privileged account usage, and monitoring for impossible travel or anomalous login times
- This technique is consistently among the top tactics observed in real-world breaches and is heavily tested in CySA+ scenarios involving insider threat and lateral movement detection

## Related concepts
[[Credential Dumping]] [[Lateral Movement]] [[Pass the Hash]] [[Privilege Escalation]] [[Multi-Factor Authentication]]