# Privileged Account Management

## What it is
Think of privileged accounts like master keys to a hotel — they open every room, every stairwell, every server closet. Privileged Account Management (PAM) is the set of policies, tools, and controls used to govern accounts with elevated permissions (admins, service accounts, root users) — controlling who gets those master keys, when, and under strict audit conditions.

## Why it matters
The 2020 SolarWinds breach succeeded largely because attackers compromised a privileged build account and moved laterally across thousands of networks undetected. Had PAM controls like just-in-time access and session recording been enforced, the lateral movement window would have been dramatically reduced — and the anomalous behavior more easily flagged.

## Key facts
- **Principle of Least Privilege (PoLP):** Users and accounts should only hold the minimum permissions required for their specific task — core to PAM implementation.
- **Just-In-Time (JIT) Access:** Privileges are granted temporarily on-demand and automatically revoked after the task window expires, shrinking the attack surface.
- **Privileged Access Workstations (PAWs):** Dedicated, hardened machines used exclusively for administrative tasks, isolated from general internet browsing and email.
- **Credential Vaulting:** PAM tools (like CyberArk or BeyondTrust) store privileged credentials in encrypted vaults, rotating passwords automatically so admins never directly know them.
- **Session Recording & Monitoring:** All privileged sessions are logged and recorded for forensic accountability — key for detecting insider threats and meeting compliance requirements (PCI-DSS, HIPAA).

## Related concepts
[[Least Privilege]] [[Zero Trust Architecture]] [[Identity and Access Management]] [[Service Account Security]] [[Credential Management]]