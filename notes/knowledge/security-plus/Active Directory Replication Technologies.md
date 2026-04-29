# Active Directory Replication Technologies

## What it is
Think of Active Directory replication like a postal network between post offices — when one branch updates its address book, it mails copies to neighboring branches, which forward them onward until every office holds identical records. Precisely: AD replication is the process by which Domain Controllers (DCs) synchronize directory data — users, groups, policies, credentials — across a forest using the **Microsoft Replication Service**, operating over RPCs via the **DRS (Directory Replication Service) protocol**. Replication can occur within a site (intrasite, triggered automatically) or between sites (intersite, scheduled via site links).

## Why it matters
Attackers exploit AD replication through the **DCSync attack**, where a compromised account with `DS-Replication-Get-Changes-All` privileges impersonates a Domain Controller and requests credential replication — pulling NTLM password hashes for any account, including krbtgt, without touching LSASS. This enables golden ticket creation and full domain compromise, making replication permission auditing a critical defensive control.

## Key facts
- **DRS protocol (MS-DRSR)** is the underlying RPC-based protocol; tools like Mimikatz's DCSync module weaponize it legitimately-looking traffic
- Replication requires three AD permissions: `DS-Replication-Get-Changes`, `DS-Replication-Get-Changes-All`, and `Replicating Directory Changes in Filtered Set`
- **USN (Update Sequence Numbers)** track changes per DC; **High-Watermark vectors** prevent redundant replication cycles
- **KCC (Knowledge Consistency Checker)** automatically builds the replication topology; attackers who disable KCC can fragment replication as a denial-of-service
- Detecting DCSync requires monitoring **Event ID 4662** for directory service access with replication GUIDs, or network anomalies from non-DC machines initiating DRS requests

## Related concepts
[[DCSync Attack]] [[Kerberos Golden Ticket]] [[NTLM Hash Extraction]] [[Privileged Access Management]] [[Active Directory Permissions]]