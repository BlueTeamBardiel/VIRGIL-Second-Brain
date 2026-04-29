# Access Control List

## What it is
Think of an ACL like a nightclub bouncer's clipboard — each entry says exactly who gets in, what room they can enter, and whether they're allowed to bring a bag. Formally, an Access Control List is an ordered set of rules (ACEs — Access Control Entries) attached to a resource that specifies which subjects (users, IPs, processes) are permitted or denied specific actions (read, write, execute, connect). ACLs operate at both the network level (routers/firewalls filtering traffic) and the filesystem level (controlling who can touch a file or directory).

## Why it matters
In 2020, misconfigured AWS S3 bucket ACLs exposed millions of records by granting public READ access — effectively putting the bouncer's clipboard away entirely. A correctly hardened ACL would have restricted object access to specific IAM roles only, making that data invisible to anonymous requests. This class of misconfiguration remains one of the most common causes of cloud data breaches.

## Key facts
- **Two types**: Network ACLs (stateless, filter packets by IP/port/protocol on routers and firewalls) vs. Filesystem ACLs (control object-level permissions on files/directories)
- **Implicit deny**: Most ACL implementations end with an implicit "deny all" rule — if no entry matches, access is blocked by default
- **ACE order matters**: Rules are evaluated top-to-bottom; a premature PERMIT can override a later DENY for the same subject
- **DAC vs. MAC context**: Standard ACLs implement Discretionary Access Control (DAC) — the resource owner sets the rules; Mandatory Access Control (MAC) enforces labels system-wide instead
- **AWS NACLs are stateless**: Unlike Security Groups, AWS Network ACLs require explicit inbound AND outbound rules — a common exam trap

## Related concepts
[[Firewall Rules]] [[Discretionary Access Control]] [[Principle of Least Privilege]]