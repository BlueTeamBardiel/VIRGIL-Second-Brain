# upKeeper Instant Privilege Access

## What it is
Think of it like a hotel key card that only works for your room during your specific check-in window — the moment you check out, it stops working entirely. upKeeper Instant Privilege Access is a Privileged Access Management (PAM) solution that grants users elevated permissions on-demand for a defined, time-limited session, then automatically revokes those privileges when the task is complete, eliminating persistent standing privileges.

## Why it matters
In the 2020 SolarWinds breach, attackers leveraged persistent privileged accounts to move laterally across networks for months undetected. A just-in-time (JIT) model like upKeeper Instant Privilege Access would have dramatically narrowed that attack window — credentials elevated only for a 30-minute session cannot be harvested and reused hours later by a threat actor.

## Key facts
- Implements **Just-In-Time (JIT) privilege elevation**, a core principle of Zero Trust architecture that assumes no user or system should hold standing privileges
- Privilege grants are **time-bounded and task-scoped** — a DBA might get 20 minutes of elevated DB access, not permanent admin rights
- Supports **approval workflows**, requiring a manager or security team to authorize privilege elevation before access is granted
- All privileged sessions are **logged and auditable**, supporting NIST 800-53 AC-6 (Least Privilege) and PCI-DSS compliance requirements
- Reduces the attack surface created by **standing privileges**, which are a primary target in credential theft attacks and insider threat scenarios

## Related concepts
[[Privileged Access Management (PAM)]] [[Just-In-Time Privilege Elevation]] [[Zero Trust Architecture]] [[Principle of Least Privilege]] [[Credential Theft]]