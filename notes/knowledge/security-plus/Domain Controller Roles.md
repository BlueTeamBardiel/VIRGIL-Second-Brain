# Domain Controller Roles

## What it is
Think of a Domain Controller like a strict courthouse clerk who holds every citizen's ID, enforces who can enter which rooms, and keeps the master registry — if someone bribes the clerk, they own the building. Precisely, a Domain Controller (DC) is a Windows Server that authenticates users, enforces Group Policy, and manages the Active Directory database for a domain. Special FSMO (Flexible Single Master Operations) roles divide critical responsibilities across DCs to prevent conflicts.

## Why it matters
In a DCSync attack, an adversary who has compromised a privileged account mimics a legitimate Domain Controller's replication behavior to pull password hashes for every user — including krbtgt — from a primary DC, without ever touching the DC directly. Once the attacker has the krbtgt hash, they can forge Golden Tickets and impersonate any user indefinitely. Monitoring for unauthorized DC replication requests (Event ID 4662) is a frontline defense against this.

## Key facts
- **Five FSMO roles exist**: Schema Master and Domain Naming Master are forest-wide (one per forest); RID Master, PDC Emulator, and Infrastructure Master are domain-wide (one per domain).
- **PDC Emulator** is the most critical for security — it handles password changes, account lockouts, and acts as the authoritative time source (Kerberos requires clocks within 5 minutes).
- **RID Master** allocates pools of Relative Identifiers used to construct SIDs; if it goes offline, new objects cannot be created.
- **Tiered administration models** restrict who can log into DCs directly — a compromised Tier 0 asset means the entire domain is compromised.
- **Read-Only Domain Controllers (RODCs)** store a filtered subset of AD credentials and are used in branch offices to limit blast radius if physically compromised.

## Related concepts
[[Active Directory]] [[Kerberos Authentication]] [[Golden Ticket Attack]] [[Group Policy Objects]] [[Privilege Escalation]]