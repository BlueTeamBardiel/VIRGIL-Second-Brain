# Domain Account

## What it is
Like a master key card that works at every door in a corporate campus — versus a room-specific key — a domain account is a centralized credential managed by a directory service (typically Active Directory) that grants authentication across all systems joined to that domain. Unlike local accounts, the credentials live on the domain controller, not on individual machines.

## Why it matters
In the 2020 SolarWinds attack, adversaries compromised domain accounts to move laterally across networks undetected, because a single set of valid domain credentials opened doors to dozens of systems simultaneously. Defenders monitor for anomalous domain account logins — especially off-hours access or logins spanning geographically distant systems within minutes — as key indicators of credential theft.

## Key facts
- Domain accounts authenticate against a **Domain Controller (DC)** using Kerberos (primary) or NTLM (fallback); compromising the DC means compromising all domain accounts
- **Domain Admin** accounts are the crown jewels — membership in this group grants full control over every machine in the domain
- Pass-the-Hash and Pass-the-Ticket attacks specifically target domain account credential material cached in memory (LSASS process)
- Security+ expects you to know that **least privilege** and **separation of duties** apply directly here — admins should have separate domain admin accounts distinct from daily-use accounts
- Domain accounts appear in **MITRE ATT&CK** under T1078.002 (Valid Accounts: Domain Accounts) as a common persistence and lateral movement technique

## Related concepts
[[Active Directory]] [[Kerberos]] [[Privilege Escalation]] [[Pass-the-Hash]] [[Lateral Movement]]