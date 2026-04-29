# Active Directory Structure and Storage Technologies

## What it is
Think of Active Directory like a massive phone book for a corporation — except it also contains job titles, office keys, group memberships, and login credentials, all stored in one queryable database. Active Directory (AD) is Microsoft's directory service that stores information about network objects (users, computers, groups, policies) and controls authentication and authorization across a Windows domain. The core database file is **NTDS.dit**, stored on Domain Controllers, which contains all directory data including password hashes.

## Why it matters
Attackers who compromise a Domain Controller and extract NTDS.dit can perform offline password cracking against every domain account — a technique called **NTDS.dit dumping**, used in tools like `secretsdump.py`. This single file is effectively the crown jewel of a Windows enterprise environment; its exfiltration enables full domain compromise without touching another system. Defenders monitor for unauthorized access to `%SystemRoot%\NTDS\NTDS.dit` and restrict DC replication privileges to prevent DCSync attacks.

## Key facts
- **NTDS.dit** is the Active Directory database file stored by default at `C:\Windows\NTDS\NTDS.dit` on every Domain Controller
- AD uses the **Extensible Storage Engine (ESE)** — a B-tree structured database — to manage NTDS.dit read/write operations
- The **SYSVOL** folder (replicated via DFSR) stores Group Policy Objects and logon scripts, and historically contained cleartext passwords in GPP files (MS14-025)
- AD replication uses **Remote Procedure Calls (RPC)** over port 135 and dynamic high ports; DCSync exploits legitimate replication APIs to pull password hashes
- The **Schema partition** defines every object class and attribute in AD; the **Domain partition** stores actual user/computer objects; the **Configuration partition** stores forest-wide topology data

## Related concepts
[[NTDS.dit Credential Dumping]] [[DCSync Attack]] [[Kerberos Authentication]] [[Group Policy Objects]] [[Privilege Escalation]]