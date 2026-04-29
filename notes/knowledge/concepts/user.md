# user

## What it is
Like a library card that grants access to specific shelves — a **user** is a named identity recognized by an operating system or application, assigned specific permissions that define what resources it can read, write, or execute. Technically, a user is a security principal with a unique identifier (UID on Linux, SID on Windows) that the OS uses to enforce access control decisions.

## Why it matters
In the 2020 Twitter breach, attackers used social engineering to compromise internal admin accounts — privileged users — and took over high-profile accounts including Barack Obama's. This demonstrates why separating regular user accounts from administrative accounts (least privilege) is critical: a compromised standard user causes far less damage than a compromised admin.

## Key facts
- Every process runs in the context of a user account; malware inherits the permissions of the user who launched it
- The **root** (Linux) and **Administrator** (Windows) accounts are built-in superusers with unrestricted system access — their compromise equals full system compromise
- Service accounts are non-interactive users created specifically to run applications or background processes; they are frequent targets because they're often over-privileged and rarely monitored
- **UID 0** on Linux always means root regardless of the account's display name — a classic privilege escalation trick is creating a second UID 0 account
- Orphaned user accounts (accounts belonging to former employees) violate least privilege and are a common initial access vector exploited by attackers

## Related concepts
[[least privilege]] [[privilege escalation]] [[access control]] [[service accounts]] [[identity and access management]]