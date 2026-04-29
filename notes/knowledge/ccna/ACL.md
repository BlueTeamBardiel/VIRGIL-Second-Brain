# ACL

## What it is
Think of an ACL like a bouncer at a nightclub with a clipboard—they check who you are and what you're allowed to do before letting you through. An Access Control List (ACL) is a set of rules attached to a resource (file, network interface, or object) that explicitly defines which users or systems can perform specific actions (read, write, execute) on that resource.

## Why it matters
A misconfigured ACL is one of the easiest ways attackers escalate privileges or access sensitive data. For example, if a Linux system has overly permissive file ACLs (world-readable on `/etc/shadow`), an attacker can extract password hashes offline. Similarly, network ACLs that fail to block unused ports become attack entry points—a classic mistake is leaving SSH accessible from the entire internet instead of specific IP ranges.

## Key facts
- **Entries are order-dependent**: ACLs evaluate rules top-to-bottom; the first matching rule wins (implicit deny at the end)
- **Two types exist**: Filesystem ACLs (file permissions) and network ACLs (firewall rules on interfaces/routes)
- **Default-deny is secure design**: Explicitly allow only necessary access rather than blacklisting threats
- **Inheritance matters**: Subdirectories often inherit parent ACLs; changing a parent ACL cascades dangerously
- **Audit trails are critical**: Track ACL modifications to catch privilege creep or insider changes

## Related concepts
[[Principle of Least Privilege]] [[File Permissions]] [[Network Segmentation]] [[Role-Based Access Control]]