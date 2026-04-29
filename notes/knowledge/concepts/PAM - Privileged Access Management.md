# PAM - Privileged Access Management

## What it is
Think of a nuclear launch facility where two officers must insert separate keys simultaneously — no single person can arm the warhead alone. PAM works the same way: it's a security framework that controls, monitors, and audits access to accounts with elevated privileges (root, admin, service accounts), ensuring no single user can silently abuse powerful credentials.

## Why it matters
The 2013 Target breach began when attackers compromised an HVAC vendor's credentials, which had been granted excessive network access. A properly implemented PAM solution would have restricted that vendor account to only HVAC-related systems using least privilege, preventing lateral movement to payment card systems and stopping a $162 million breach at the perimeter.

## Key facts
- **Just-In-Time (JIT) access** provisions privileged credentials only when needed and auto-expires them, eliminating standing privileges that attackers can harvest
- **Password vaulting** stores privileged credentials in an encrypted repository and can rotate them automatically after each use, so stolen credentials become instantly worthless
- **Session recording** logs all privileged activity keystroke-by-keystroke, creating forensic evidence and deterring insider threats
- PAM enforces **least privilege** by granting only the minimum access required for a specific task — a key control for both CySA+ and Security+ exams
- PAM solutions (CyberArk, BeyondTrust, Delinea) typically use **dual control** requiring approval workflows before privileged access is granted

## Related concepts
[[Least Privilege]] [[Zero Trust Architecture]] [[Identity and Access Management (IAM)]] [[Credential Stuffing]] [[Just-In-Time Access]]