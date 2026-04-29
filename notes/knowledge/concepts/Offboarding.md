# Offboarding

## What it is
Like a hotel revoking your keycard, collecting your parking pass, and deactivating your pool access the moment you check out — offboarding is the formal, structured process of terminating an employee's or contractor's access to all organizational systems, data, and physical facilities when they leave. It is the security-critical counterpart to onboarding, ensuring that departing users retain zero residual access or credentials after separation.

## Why it matters
In 2020, a former Cisco engineer accessed the company's AWS environment **five months after resignation** using credentials that were never revoked, deleting over 16,000 virtual machines and causing $2.4 million in damages. Proper offboarding — immediate account disablement, credential rotation, and access log review — would have closed that window entirely.

## Key facts
- **Immediate account disablement** is preferred over deletion; disabled accounts preserve audit logs and forensic evidence while blocking access.
- Offboarding must cover **all access vectors**: VPN credentials, SSO tokens, API keys, shared passwords, physical badges, and cloud service accounts — not just the primary Active Directory account.
- **Exit interviews** and **non-disclosure agreement reminders** are administrative controls that reduce insider threat risk post-separation.
- Privileged accounts (sysadmin, DBA) require **password rotation on shared systems** the user could access, even after disablement.
- Security+ and CySA+ treat offboarding as part of **Identity and Access Management (IAM)** and the broader **personnel security policy** domain.

## Related concepts
[[Least Privilege]] [[Identity and Access Management]] [[Insider Threat]] [[Account Management]] [[Access Control]]