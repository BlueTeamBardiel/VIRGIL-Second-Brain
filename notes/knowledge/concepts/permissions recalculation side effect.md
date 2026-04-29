# permissions recalcitation side effect

## What it is
Like a spreadsheet that auto-recalculates every cell when you change one value — sometimes producing unexpected results in cells you weren't watching — a permissions recalculation side effect occurs when a change to one access control element triggers unintended permission changes elsewhere in the system. This happens in hierarchical or inherited permission models where modifying a parent object, group membership, or role cascades downstream, granting or revoking access in ways the administrator didn't anticipate.

## Why it matters
An attacker who gains the ability to modify a single high-level Active Directory group can trigger a recalculation that silently grants domain-wide resource access to accounts they control — without ever touching individual resource ACLs. Defenders must audit *effective permissions* after any structural change, not just the change itself, because the blast radius is invisible until recalculated.

## Key facts
- In Windows NTFS and Active Directory, permissions are *effective* (the union of all applied permissions), meaning adding a user to even one privileged group recalculates their total access across all inherited resources
- Removing a user from a group does **not** immediately revoke active sessions or cached tokens — Kerberos tickets remain valid until expiration (default 10 hours)
- Role-Based Access Control (RBAC) systems are especially vulnerable: a role reassignment recalculates dozens of entitlements simultaneously
- The "deny overrides allow" rule in NTFS means an accidental deny entry introduced during recalculation can cause unexpected lockouts — a denial-of-availability risk
- Privilege creep is a long-term side effect: repeated recalculations over time accumulate excessive permissions that violate least privilege

## Related concepts
[[privilege creep]] [[access control inheritance]] [[Kerberos ticket lifetime]] [[least privilege principle]] [[Active Directory group policy]]