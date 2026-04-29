# Active Directory Domain Services

## What it is
Think of AD DS like a city hall that issues ID badges, maintains the phone book, and decides who gets a key to which building — all in one place. Active Directory Domain Services is Microsoft's centralized directory service that authenticates and authorizes users, computers, and other resources within a Windows domain network. It stores objects (users, groups, computers) in a hierarchical structure and enforces security policies across the entire domain.

## Why it matters
In the 2020 SolarWinds attack, threat actors moved laterally through victim networks by abusing Active Directory trust relationships and stealing Kerberos ticket-granting tickets (Golden Ticket attack) — giving them persistent, nearly invisible domain-level access. Defenders monitoring AD DS for unusual LDAP queries, new privileged group memberships, or DCSync replication requests can catch attackers before they achieve full domain compromise.

## Key facts
- **Domain Controllers (DCs)** host AD DS and are the highest-value targets in any Windows environment — compromising one typically means compromising everything
- **LDAP (port 389/636)** is the protocol used to query AD DS; unencrypted LDAP is a common credential interception vector
- **Group Policy Objects (GPOs)** are distributed through AD DS and can enforce password policies, software restrictions, and security baselines domain-wide
- **Kerberos** is the default authentication protocol in AD DS (port 88); NTLM is the legacy fallback — both are heavily targeted
- **Privileged groups** such as Domain Admins, Enterprise Admins, and Schema Admins grant sweeping control and are primary targets for privilege escalation attacks

## Related concepts
[[Kerberos Authentication]] [[LDAP]] [[Group Policy Objects]] [[Privilege Escalation]] [[Golden Ticket Attack]]