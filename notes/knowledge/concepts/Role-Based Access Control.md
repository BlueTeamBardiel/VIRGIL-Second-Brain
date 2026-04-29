# Role-based Access Control

## What it is
Think of a hospital: janitors have keys to supply closets, nurses access patient wards, and surgeons enter operating theaters — nobody gets a universal master key just because they work there. Role-based Access Control (RBAC) assigns permissions to predefined job roles rather than to individual users, so a user inherits access rights simply by being assigned to a role.

## Why it matters
In 2020, a Twitter insider threat compromised high-profile accounts by abusing an admin tool that granted overly broad permissions beyond what specific roles required. Proper RBAC implementation — where social media admins only access tools necessary for their defined function — would have limited the blast radius by ensuring no single role had the keys to every account simultaneously.

## Key facts
- **Three core components:** Users, Roles, and Permissions — users are assigned to roles, roles are assigned permissions (not users directly to permissions)
- **Principle of Least Privilege enforcement:** RBAC is a primary mechanism for implementing least privilege at scale across an organization
- **Role explosion** is a known failure mode — organizations that create too many granular roles defeat the management simplicity RBAC was designed to provide
- **RBAC vs. DAC vs. MAC:** RBAC is administratively defined (centralized); Discretionary Access Control lets owners set permissions; Mandatory Access Control uses security labels — Security+ expects you to distinguish all three
- **NIST RBAC Model** defines four levels: Flat, Hierarchical, Constrained (with Separation of Duties), and Symmetric RBAC — Constrained RBAC prevents one role from holding conflicting privileges

## Related concepts
[[Principle of Least Privilege]] [[Mandatory Access Control]] [[Separation of Duties]]