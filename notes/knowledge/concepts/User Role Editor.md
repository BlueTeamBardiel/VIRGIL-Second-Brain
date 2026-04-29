# User Role Editor

## What it is
Like a hotel manager who hands out keycards — some open the gym, some open the penthouse, some open every door — a User Role Editor is an administrative interface that defines and modifies what permissions are assigned to which user roles within a system. It is the control plane for Role-Based Access Control (RBAC), allowing administrators to create, modify, or delete permission sets that govern what authenticated users can see and do.

## Why it matters
In a 2023-style WordPress privilege escalation attack, a vulnerability in a plugin allowed unauthenticated users to call the User Role Editor functionality directly, promoting their accounts to Administrator. This bypassed all authentication controls because the permission logic itself was exposed — attackers didn't steal credentials, they simply *rewrote the rules*. Defending this requires strict access controls on the role-editing interface itself, not just on the roles it manages.

## Key facts
- User Role Editors implement the **RBAC model**: users are assigned roles, roles are assigned permissions — never permissions directly to users
- Misconfigured role editors are a leading cause of **privilege escalation**, a top finding in web application penetration tests
- The **principle of least privilege** requires role definitions be audited regularly; role creep occurs when permissions accumulate without review
- Changes made through role editors should be logged for **non-repudiation** — who changed what role, and when
- In WordPress specifically, the `edit_roles` capability gates access to the User Role Editor; exposing this via API without authentication check is a critical misconfiguration (CVSS typically 9.0+)

## Related concepts
[[Role-Based Access Control]] [[Privilege Escalation]] [[Principle of Least Privilege]] [[Access Control Lists]] [[Identity and Access Management]]