# RBAC - Role-Based Access Control

## What it is
Think of a hospital: the janitor has a key to every room, but can't access patient records; the doctor accesses records but can't unlock the pharmacy safe; the pharmacist can open the safe but doesn't see billing data. RBAC works the same way — permissions are assigned to *roles*, and users inherit permissions by being placed into those roles, rather than receiving permissions directly. This separates the "what you can do" from "who you are" at the individual level.

## Why it matters
In 2020, a Twitter insider with excessive privileges was able to access and hijack high-profile accounts (Obama, Musk, Biden) because Twitter's internal admin tools weren't tightly scoped by role. A properly enforced RBAC model would have ensured that customer support agents could only perform support-level actions, not account takeovers — containing the blast radius of both insider threats and compromised credentials.

## Key facts
- Permissions attach to **roles**, not individual users — a user gets access by role membership, not direct assignment
- Follows the **principle of least privilege**: each role contains only the permissions necessary for that job function
- **Role explosion** is a real failure mode — organizations that create too many granular roles end up with an unmanageable, insecure mess
- RBAC is distinct from **MAC** (Mandatory Access Control, policy-enforced by system) and **DAC** (Discretionary Access Control, owner-controlled) — Security+ tests this distinction directly
- NIST defines a formal RBAC standard (NIST SP 800-207 adjacent; core model in ANSI INCITS 359-2004) with four models: Flat, Hierarchical, Constrained, and Symmetric

## Related concepts
[[Principle of Least Privilege]] [[Mandatory Access Control]] [[Discretionary Access Control]] [[Attribute-Based Access Control]] [[Privileged Access Management]]