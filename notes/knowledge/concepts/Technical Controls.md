# Technical Controls

## What it is
Like a bank vault with a combination lock, motion sensors, and a time-delay mechanism all working together — technical controls are the hardware and software mechanisms that directly enforce security policy without relying on human behavior. They include firewalls, encryption, access control lists, MFA, and IDS/IPS systems. Unlike administrative controls (policies), technical controls are automated and machine-enforced.

## Why it matters
In the 2021 Colonial Pipeline ransomware attack, the attackers gained initial access through a compromised VPN account that lacked multi-factor authentication — a missing technical control. Had MFA been enforced at the authentication layer, the credential alone would have been insufficient, potentially stopping the breach at the perimeter before lateral movement began.

## Key facts
- Technical controls are divided into **preventive** (firewalls, encryption), **detective** (IDS, SIEM logs), and **corrective** (quarantine systems, patch management) subtypes
- They are one of three control *categories* on the Security+ exam alongside **administrative** and **physical** controls
- Encryption is a technical control that addresses both **confidentiality** and **integrity** simultaneously
- **Least privilege** enforced via ACLs and RBAC is a core technical control that limits blast radius from insider threats and compromised accounts
- Technical controls can fail silently — a misconfigured firewall rule may appear active while permitting unauthorized traffic, making **configuration audits** essential

## Related concepts
[[Administrative Controls]] [[Physical Controls]] [[Defense in Depth]] [[Access Control Lists]] [[Multi-Factor Authentication]]