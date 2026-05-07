# ACL

## What it is

A bouncer at a club working off a clipboard. The list says "Beatrice gets in, Dante gets in but no VIP room, Virgil is banned, everyone else turn around." The bouncer reads top to bottom, stops at the first name that matches, and acts on that line. No name on the list? You're not getting in.

An **Access Control List (ACL)** is exactly that clipboard, attached to a resource — a file, a folder, a network interface, a route. Each entry (an ACE, Access Control Entry) says *who* can do *what*. When a request hits the resource, the system walks the list top-to-bottom and applies the first rule that matches the request. If nothing matches, the **implicit deny** at the end kicks in: silent rejection.

Two main flavors:
- **Filesystem ACLs** — who can read, write, execute, or delete a file or directory.
- **Network ACLs** — which packets are allowed in or out of an interface, or onto a route. This is the bread and butter of router and firewall rule sets.

## Why it matters

ACLs are the difference between your loadout being yours and your loadout being everyone's. In Escape from Tarkov, your stash is gated — only your account touches it. Strip that ACL away and the raid economy collapses in an afternoon. Same logic runs every multi-tenant system on Earth: cloud buckets, shared drives, VLAN segmentation, SSH access to a jump host.

Two design realities make ACLs harder than they look:

1. **Order matters.** Because the first match wins, a sloppy "permit any" near the top makes every "deny" rule below it cosmetic. It's like setting your Discord server's @everyone role to Administrator and then carefully restricting individual channels — you've already lost.
2. **Inheritance cascades.** Subdirectories inherit parent ACL rules by default, and changes to a parent flow downhill. Tighten the top-level folder and every child tightens with it. Loosen it by accident and you've just opened a thousand doors with one click. This is why a misconfigured S3 bucket policy at the root can leak terabytes — the cascade is the whole point and the whole danger.

The secure default is **default-deny**: start with everything blocked, then explicitly allow what's needed. The opposite (default-allow with deny exceptions) is how you end up with an "oh god, what else did we forget" incident report.

## Key facts

- **Top-to-bottom, first match wins.** Rule ordering is the entire game. A permit rule above a deny rule for the same traffic means the deny never fires.
- **Implicit deny at the end.** Even if you don't write it, it's there. Anything not explicitly permitted is dropped — like an Elden Ring fog wall you didn't earn the right to cross.
- **Default-deny is the secure baseline.** Whitelist what's allowed, blacklist nothing. If you're writing "deny X, deny Y, deny Z, permit everything else," you're playing whack-a-mole and the moles are winning.
- **Filesystem ACLs** govern read/write/execute/delete on files and directories. Think of NTFS permissions on Windows or POSIX ACLs on Linux — the same clipboard logic, just scoped to inodes instead of packets.
- **Network ACLs** are applied to interfaces (inbound or outbound) and to routes. This is what a router uses to decide whether traffic from 10.0.0.0/24 can talk to your management subnet.
- **Inheritance is automatic.** Create a new folder inside a protected parent and it picks up the parent's ACL by default. Same in network ACLs grouped into policies — child objects ride on the parent's rules.
- **Cascade on edit.** Modify the parent and every child inherits the change unless inheritance is explicitly broken. Powerful and dangerous in equal measure — one keystroke can re-permission an entire share.
- **Audit and track every change.** ACL edits should be logged the same way you'd log admin commands in a CS2 server. "Who added the permit any any rule on Tuesday at 2 AM" is a question you want answered before the breach review, not during it.
- **An ACE is a single rule.** An ACL is the collection. The vocabulary trips people up — "rule" and "entry" are the same thing.

## Related concepts

[[Firewall]] · [[Default-deny]] · [[RBAC]] · [[Principle of Least Privilege]] · [[Stateful vs Stateless Filtering]] · [[NTFS Permissions]] · [[POSIX Permissions]] · [[Network Segmentation]] · [[Zero Trust]] · [[Audit Logging]]