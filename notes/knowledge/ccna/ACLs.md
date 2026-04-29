# ACLs

## What it is
Think of an ACL like a bouncer's list at a nightclub—it explicitly says who gets in and who doesn't. An Access Control List is a set of rules attached to a resource (file, network interface, or system object) that specifies which users or processes can perform specific actions (read, write, execute, delete) on that resource. ACLs are the fundamental mechanism for enforcing least privilege at the object level.

## Why it matters
A misconfigured ACL is a direct path to privilege escalation. For example, if a Windows file ACL grants "Everyone" full control on a sensitive configuration file, an unprivileged attacker can modify it to inject malicious settings or execute code. Conversely, properly auditing and restricting ACLs prevents lateral movement—if a compromised service account has overly permissive ACLs, an attacker can use it to access data far beyond what that service actually needs.

## Key facts
- ACLs can be **discretionary** (owner controls permissions) or **mandatory** (OS enforces via labels)
- Windows NTFS and Linux file systems both use ACLs; Linux also applies them to network interfaces
- ACLs are evaluated **top-to-bottom**; first match wins, so rule order is critical
- Inheritance can cause surprise permissions—child objects inherit parent ACLs unless explicitly blocked
- Regular ACL audits are essential; stale permissions accumulate like technical debt

## Related concepts
[[Principle of Least Privilege]] [[RBAC]] [[SELinux]] [[Permission Inheritance]] [[Privilege Escalation]]