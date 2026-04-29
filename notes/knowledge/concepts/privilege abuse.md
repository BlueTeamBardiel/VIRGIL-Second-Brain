# privilege abuse

## What it is
Like a bank teller who uses their legitimate access to the vault to skim cash between audits, privilege abuse occurs when an authorized user exploits their legitimately granted permissions for unauthorized purposes. It is distinct from privilege escalation — the attacker already *has* the access, they're just misusing it. This makes it one of the hardest threat categories to detect because the activity looks normal from an authentication standpoint.

## Why it matters
In the 2013 Target breach, a third-party HVAC vendor's credentials were used to pivot into payment card systems — credentials that had far more network access than any HVAC contractor should ever need. If Target had enforced least privilege, that vendor's account would have been walled off from POS systems entirely. This case is now a textbook example of why over-provisioning is itself a security vulnerability.

## Key facts
- Privilege abuse falls under the **insider threat** category in MITRE ATT&CK and Security+ exam domains, even when the actor is a third party using legitimate credentials
- **Least privilege** and **separation of duties** are the two primary preventive controls
- **User and Entity Behavior Analytics (UEBA)** is the primary *detective* control — it baselines normal behavior and flags statistical anomalies in how privileges are used
- Privileged Access Management (PAM) tools (e.g., CyberArk, BeyondTrust) enforce just-in-time access and session recording to limit the abuse window
- The **CIS Controls** list privileged account management as Control 5, reflecting how foundational it is to defense-in-depth

## Related concepts
[[least privilege]] [[insider threat]] [[privilege escalation]] [[separation of duties]] [[UEBA]]