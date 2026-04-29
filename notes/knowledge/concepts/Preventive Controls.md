# Preventive controls

## What it is
Like a bank vault door that stops a thief *before* they reach the cash — not after — preventive controls are security measures designed to stop an attack or unauthorized action from occurring in the first place. They act proactively, blocking threats at the entry point rather than detecting or recovering from them after damage is done.

## Why it matters
In 2021, the Colonial Pipeline ransomware attack succeeded partly because multi-factor authentication was not enforced on a legacy VPN account. A preventive control — MFA — could have stopped the initial credential-based intrusion entirely, before any ransomware was ever deployed. This illustrates why prevention is architecturally cheaper than incident response.

## Key facts
- Preventive controls are one of three primary control categories by function: **preventive**, detective, and corrective (the others being deterrent, compensating, and recovery)
- Examples include firewalls, access control lists (ACLs), encryption, MFA, input validation, and least-privilege policies
- They can be **technical** (firewall rules), **administrative** (security policies, separation of duties), or **physical** (locked server rooms, mantraps)
- On Security+/CySA+, preventive controls are contrasted with **detective controls** (IDS, audit logs) — knowing which is which is frequently tested
- A preventive control does **not** replace detective controls; layered defense-in-depth requires both — prevention reduces attack surface, detection catches what slips through

## Related concepts
[[Detective controls]] [[Defense in depth]] [[Access control]] [[Least privilege]] [[Multi-factor authentication]]