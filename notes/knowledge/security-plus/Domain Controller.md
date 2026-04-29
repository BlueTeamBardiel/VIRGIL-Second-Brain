# Domain Controller

## What it is
Think of it as the bouncer, guest list manager, and keys-to-the-building holder all rolled into one server — if you're not in its book, you're not getting in anywhere. A Domain Controller (DC) is a Windows server running Active Directory Domain Services (AD DS) that authenticates and authorizes users, computers, and devices within a Windows domain. It stores the directory database, enforces security policies, and handles Kerberos ticket issuance for the entire domain.

## Why it matters
Compromising a Domain Controller is effectively game over for an enterprise network — attackers who reach a DC can perform a **DCSync attack**, mimicking replication traffic to silently extract every user's password hash from Active Directory without ever touching the DC directly. This technique, weaponized in tools like Mimikatz, lets adversaries dump credentials including the `krbtgt` hash, enabling Golden Ticket attacks that grant persistent, nearly unrevocable domain access. Defenders monitor for unauthorized replication requests (Directory Replication Service calls from non-DC machines) as a key detection signal.

## Key facts
- Domain Controllers store the **NTDS.dit** file — the Active Directory database containing all password hashes for the domain
- The **krbtgt** account's hash is the crown jewel; compromising it enables Golden Ticket forgery, which can persist even after password resets unless reset *twice*
- DCs use **Kerberos (port 88)** as the primary authentication protocol; LDAP (389/636) for directory queries
- A domain should have **at least two DCs** for redundancy — the Primary Domain Controller Emulator (PDC Emulator) FSMO role handles time sync and password changes
- DC replication uses **port 445 (SMB)** and dynamic RPC ports — abnormal replication partners are a red flag for DCSync activity

## Related concepts
[[Active Directory]] [[Kerberos]] [[Golden Ticket Attack]] [[NTDS.dit]] [[Privilege Escalation]]