# Windows ACLs

## What it is
Think of a nightclub bouncer holding a clipboard — every resource (the club) has a list of who gets in, what they can do inside, and who's explicitly banned. A Windows Access Control List (ACL) is precisely that: an ordered list of Access Control Entries (ACEs) attached to a securable object (file, registry key, process) that defines which security principals are granted or denied specific permissions.

## Why it matters
Misconfigured ACLs are a primary privilege escalation path in Windows environments. An attacker who finds a service binary with write permissions granted to low-privileged users can replace it with a malicious executable — a technique called weak service binary permissions exploitation — and gain SYSTEM-level code execution when the service restarts.

## Key facts
- **Two types of ACL**: the **DACL** (Discretionary ACL) controls *who* can access an object; the **SACL** (System ACL) controls *auditing* — which access attempts get logged to the Security Event Log.
- ACEs are evaluated **top-down**; an explicit **Deny** ACE overrides an Allow ACE unless the Deny appears lower in the list than the Allow (order matters).
- If a DACL is **absent** (null DACL), Windows grants **full access to everyone** — a dangerous misconfiguration.
- Permissions can be **inherited** from parent containers (e.g., folders → files), which can silently expose objects when a parent ACL is overly permissive.
- Tools like `icacls`, `Get-Acl` (PowerShell), and **AccessChk** (Sysinternals) are used to audit ACLs during both administration and red team enumeration.

## Related concepts
[[Privilege Escalation]] [[Windows Security Principals]] [[Discretionary Access Control (DAC)]] [[Mandatory Access Control (MAC)]] [[Audit Logging]]