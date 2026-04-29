# Access Control Entries

## What it is
Think of an ACE like a single line on a nightclub guest list: "Alice — VIP section — allowed" or "Bob — back stage — denied." An Access Control Entry (ACE) is one individual record within an Access Control List (ACL) that specifies a trustee (user, group, or process) and the permissions granted or denied to that trustee for a specific object. Each ACE contains a Security Identifier (SID), an access mask defining allowed operations, and a flag indicating whether the entry is an Allow or Deny rule.

## Why it matters
Misconfigured ACEs are a primary vector in Windows privilege escalation attacks. Tools like BloodHound and PowerView specifically enumerate ACEs on Active Directory objects — if an unprivileged user has a `WriteDACL` or `GenericAll` ACE on a high-value account, an attacker can modify permissions and take full control without ever exploiting a CVE. Defenders audit ACEs on sensitive AD objects as a core part of hardening.

## Key facts
- ACEs are evaluated **in order** within a DACL; **explicit Deny ACEs are processed before Allow ACEs**, which is why Deny always wins in a conflict.
- Two ACL types exist: **DACL** (controls access permissions) and **SACL** (controls auditing/logging of access attempts); ACEs live in both.
- A **null DACL** (DACL explicitly set to nothing) grants **everyone full access** — a common misconfiguration mistake.
- An **absent DACL** (no DACL at all) also grants full access; this is distinct from an empty DACL, which denies all access.
- On Windows, ACEs use **inheritance flags** to propagate permissions from parent containers (e.g., folders) to child objects automatically.

## Related concepts
[[Access Control Lists]] [[Discretionary Access Control]] [[Security Identifiers]] [[Privilege Escalation]] [[Windows Active Directory Security]]