# ACL — Access Control List

## What it is

In **Street Fighter**, every character has a move list — Ryu can throw a Hadouken, Chun-Li can chain Lightning Kicks, Zangief can grab you out of the air if you jump like an idiot. The move list defines what each fighter is *allowed* to do. Try to pull off a move that isn't on your character's list and the game just eats the input. Nothing happens. The engine checks the move list before it executes anything.

That's exactly what an **Access Control List** does — it's the move list for a resource. Every packet, user, file, or API call gets checked against the list. If the action is on the list with "permit," it goes through. If it's not on the list, or the list says "deny," the engine eats the input.

Technical definition: an ACL is an **ordered set of rules** that grants or denies access to a resource based on attributes — source/destination IP, port, protocol, user identity, group membership, file operation. ACLs live on routers, firewalls, switches, operating system filesystems, cloud object stores, and applications. They are the most fundamental access control primitive in IT, and they're evaluated **top-down, first-match-wins**, which is the source of approximately 60% of ACL bugs in production.

## Why it matters

ACLs are the connective tissue of [[Network segmentation]], [[Zero trust]] architecture, [[Identity and access management]], and [[System hardening]]. When a SOC analyst gets paged because a workstation in the finance VLAN just talked to a server in the OT environment, the first question is *"what ACL let that through?"* — and the answer is almost always *"a rule someone added at 4pm on a Friday two years ago that nobody owns anymore."*

CySA+ objective **1.1** lists ACLs under network architecture and system hardening. CompTIA expects you to know the difference between a network ACL and a filesystem ACL, the order of rule evaluation, and how ACLs intersect with [[Firewalls]], [[Software-defined networking]], and cloud security groups. Exam questions love the "which rule blocks this traffic" trap — they hand you a five-line ACL and ask which line a given packet hits first.

In the real world, ACL drift is one of the top three causes of unintended exposure in mid-sized enterprises. The other two are misconfigured S3 buckets (also ACLs, by the way) and forgotten admin accounts.

## Key facts

### The two ACL families

| Family | Lives on | Controls | Example |
|---|---|---|---|
| **Network ACL** | Routers, firewalls, switches, cloud VPC | Traffic flow by IP/port/protocol | `permit tcp 10.1.0.0/16 host 10.2.5.10 eq 443` |
| **Filesystem ACL** | OS (NTFS, ext4 with POSIX ACLs, AWS S3, Azure Blob) | File/object operations by principal | `Alice: Read, Write; Bob: Read; Everyone: Deny` |

Both follow the same logic — ordered rules, principal + action + target — but they live at different layers of the stack.

### Network ACL types (Cisco-flavored, but universal in concept)

- **Standard ACL** — filters on source IP only. Cheap, dumb, fast. Numbered 1–99.
- **Extended ACL** — filters on source IP, destination IP, protocol, port, flags. The workhorse. Numbered 100–199.
- **Named ACL** — same as extended but with human-readable names. Use these. Always.
- **Reflexive / stateful ACL** — tracks the connection state so return traffic for an outbound session is automatically permitted. This is what a [[Stateful firewall]] does under the hood.
- **Time-based ACL** — rules only active during specified hours. Useful for "contractors can only RDP during business hours."

### Rule evaluation order — the trap that eats juniors

ACLs are evaluated **top-down**, and the **first matching rule wins**. There's an **implicit deny** at the bottom of every ACL. If no rule matches, the traffic is dropped.

```
10  permit tcp any host 10.0.0.50 eq 443
20  permit tcp 192.168.1.0/24 any eq 22
30  deny   ip   192.168.1.100 any
40  permit ip   any any
```

A packet from `192.168.1.100` to `10.0.0.50:443` is **permitted** by rule 10. Rule 30 never gets a chance to deny it. This is the bug. Order matters more than content.

> **CompTIA exam trap:** Given an ordered ACL and a packet, the answer is the **first** rule that matches — not the most specific, not the most restrictive, not the last. CompTIA will deliberately put a "deny host X" rule below a broader "permit subnet" rule that already includes X. The deny is dead code. Read top to bottom.

> **CompTIA exam trap:** The **implicit deny** at the end of an ACL means anything not explicitly permitted is dropped. If a question asks "what happens to traffic not matched by any rule?" the answer is **denied**, even if no explicit deny line exists. This is also why "permit any any" at the end of an ACL effectively disables the implicit deny — and is almost always a mistake.

### Filesystem ACLs — DACL vs SACL

Windows NTFS distinguishes two ACL types on every object:

- **DACL (Discretionary ACL)** — who can do what to the object. Read, write, modify, delete, take ownership.
- **SACL (System ACL)** — what gets logged when the object is accessed. This feeds [[Log ingestion]] into the [[SIEM]]. Without SACL configured, you have no audit trail for sensitive file access.

A common forensic gap: incident responders pull file timestamps for a compromised host and find no audit events because nobody configured SACL on the sensitive directories. The data was accessed; nobody knows by whom.

### ACLs vs RBAC vs ABAC

ACLs are the *primitive*. Higher-level models compile down to ACLs.

| Model | What it grants on | Scales to |
|---|---|---|
| **ACL** | Specific principals on specific objects | Small environments, low cardinality |
| **RBAC** (role-based) | Roles, then roles get ACL entries | Mid-size enterprise |
| **ABAC** (attribute-based) | Policy evaluating attributes at runtime | Cloud-scale, [[Zero trust]] |

A modern enterprise uses RBAC at the IAM layer, which programmatically maintains ACLs on the underlying resources. When you see an "AWS IAM policy," that's ABAC syntax compiling to S3 bucket ACLs and resource policies underneath.

### Where ACLs show up on the CySA+ exam

- **Network segmentation** — VLAN ACLs and inter-subnet routing ACLs enforce segmentation. Without them, a VLAN is just a broadcast domain, not a security boundary.
- **System hardening** — removing default "Everyone: Read" ACL entries on shared directories, tightening firewall rules to least privilege.
- **Privileged access management ([[PAM]])** — PAM tools maintain ACLs on jump hosts, vaults, and target systems so privileged credentials are only usable from approved sources.
- **Cloud security** — AWS Security Groups (stateful), Network ACLs (stateless), S3 bucket ACLs, Azure NSGs. The cloud version of every concept above.
- **[[CASB]] and [[SASE]]** — both enforce ACLs at the edge between users and SaaS apps based on identity, device posture, and location.

### Stateless vs stateful — a CySA+ favorite

| Type | Behavior | Example |
|---|---|---|
| **Stateless ACL** | Evaluates every packet independently. You must explicitly permit return traffic. | AWS Network ACL, classic Cisco ACL |
| **Stateful ACL** | Tracks connection state. Return traffic for permitted outbound is auto-allowed. | AWS Security Group, [[Stateful firewall]] |

If a junior writes a stateless ACL and only permits outbound port 443, the response packets get dropped because the source port is ephemeral and there's no inbound rule for it. Classic late-night ticket: *"the web is broken for half the subnet."*

### ACL hygiene — what gets you owned

- **Shadow rules** — newer rules that fully shadow older ones. The old rule is dead code, but it's still in the config bloating the rule set.
- **Overly permissive rules** — `permit ip any any` somewhere in the middle of the ACL because someone was troubleshooting and forgot to remove it.
- **Stale rules** — entries for hosts, contractors, or vendors that no longer exist. Every stale `permit` is a potential pivot for an attacker who lands on a recycled IP.
- **No documentation** — every rule should have a ticket, an owner, and a review date. Without that, nobody dares delete anything, and the rule set grows monotonically forever.
- **No periodic review** — ACLs should be reviewed at least annually. PCI DSS requires it every six months for systems handling [[Cardholder data]].

> **CompTIA exam trap:** "Least privilege" applied to ACLs means **start with implicit deny, add the minimum permits needed.** Not "start with permit any any and deny the bad stuff." CompTIA will offer both as answers. The default-deny posture is always the right answer on the exam, even when it's painful in practice.

## SOC reality

- The alert at 3am isn't usually "ACL violation." It's "unexpected east-west traffic between segments that should be isolated." You go look at the firewall logs, find the `permit` rule that allowed it, and trace it back to a change ticket from 14 months ago that said *"temporary rule for vendor POC, remove after 30 days."* Nobody removed it.
- L1's first move when a network alert fires: pull the firewall rule that matched the flow. The log line tells you the rule ID. The rule ID tells you who owns the exposure.
- The CISO question after a breach is never "did the ACL fire?" It's *"when was this rule added, who approved it, and why is it still here?"* If you can't answer all three in five minutes, your change management is broken — which is the real finding.
- Never tell leadership "the ACL blocks it" without testing. Rules that look right in the config can be shadowed by an earlier permit you didn't notice. Always validate with a test packet from the actual source to the actual destination. `tcpdump` on both ends or it didn't happen.
- Escalation point: L1 confirms the traffic and the rule, L2 owns the rule audit and proposes the change, change board approves removal or tightening, network engineering implements during the maintenance window. The SOC doesn't unilaterally edit production ACLs at 3am unless containment requires it — and even then, it goes in the IR log immediately.

## Related concepts

[[Network segmentation]] · [[Zero trust]] · [[Firewall]] · [[Stateful firewall]] · [[SIEM]] · [[Log ingestion]] · [[Identity and access management]] · [[PAM]] · [[RBAC]] · [[ABAC]] · [[System hardening]] · [[CASB]] · [[SASE]] · [[Software-defined networking]] · [[Least privilege]] · [[Cardholder data]] · [[NTFS permissions]]

*Source: VIRGIL knowledge base — 2026-05-11*