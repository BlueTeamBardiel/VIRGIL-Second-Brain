# SID-History Injection

## What it is
Imagine a spy who keeps their old embassy badge alongside their new one — when challenged, they flash whichever badge opens the door they want. SID-History Injection is an attack where a threat actor adds a high-privileged Security Identifier (SID), typically from a Domain Admin or Enterprise Admin group, into the `sIDHistory` attribute of a compromised user account. Windows authentication blindly honors all SIDs in that attribute when building the user's access token, granting the attacker invisible elevated privileges.

## Why it matters
In a real-world post-exploitation scenario, an attacker who has obtained Domain Admin — perhaps via DCSync — can permanently backdoor a low-privilege account by injecting the Domain Admins SID into its history. Even after the initial compromise is "remediated" and the obvious backdoors are removed, this manipulated account silently retains domain-wide access, making it a persistent and stealthy re-entry mechanism that bypasses most standard account audits.

## Key facts
- The `sIDHistory` attribute was legitimately designed to preserve resource access during Active Directory domain migrations.
- Requires **Domain Admin** (or equivalent) privileges and is typically performed using tools like **Mimikatz** (`misc::addsid`) or PowerShell AD modules.
- Exploitation is classified as a **persistence and privilege escalation** technique — MITRE ATT&CK T1134.005.
- Detection relies on monitoring **Event ID 4765** (SID History added) and **4766** (SID History add attempt failed) in Windows Security logs.
- Injecting the **Enterprise Admins SID (S-1-5-21-[domain]-519)** grants forest-wide administrative access, not just domain-level.

## Related concepts
[[DCSync Attack]] [[Golden Ticket Attack]] [[Active Directory Privilege Escalation]] [[Access Token Manipulation]] [[Kerberos Authentication]]