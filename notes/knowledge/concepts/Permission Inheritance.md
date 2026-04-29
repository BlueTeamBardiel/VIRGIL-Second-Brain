# Permission Inheritance

## What it is
Like house rules that automatically apply to every room when you move in — unless a room has its own lock — permission inheritance is the automatic propagation of access rights from a parent object (folder, container, OU) to its child objects. In file systems and directory services, child objects receive the same permissions as their parent unless explicitly blocked or overridden.

## Why it matters
In a misconfigured Active Directory environment, an attacker who compromises a low-privilege user account in an Organizational Unit with inherited Write permissions on the OU can modify group memberships or reset passwords — escalating privileges without ever touching the Domain Admin account. Attackers routinely scan for broken or over-permissive inheritance chains using tools like BloodHound to map these privilege escalation paths.

## Key facts
- **NTFS inheritance** flows from parent folders to subfolders and files; inherited permissions appear grayed out in Windows and are overridden by explicit permissions.
- **Blocking inheritance** (e.g., "Break Inheritance" in Windows) stops parent permissions from flowing down but does not automatically remove already-inherited ACEs — those must be manually purged.
- In **Active Directory**, permissions on OUs inherit to child OUs, users, and computers by default; this is a primary vector for ACL-based privilege escalation.
- **Explicit permissions always take precedence** over inherited permissions; a Deny set explicitly at the child level overrides an Allow inherited from the parent.
- The **principle of least privilege** requires auditing inheritance chains — over-permissive parent ACLs silently grant excess rights to thousands of child objects at once.

## Related concepts
[[Access Control Lists (ACLs)]] [[Active Directory Security]] [[Privilege Escalation]] [[Principle of Least Privilege]]