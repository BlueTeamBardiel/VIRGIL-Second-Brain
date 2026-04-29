# Directory Service

## What it is
Think of it as a phone book for a corporate network — but instead of names and numbers, it maps usernames to permissions, devices, policies, and passwords. A directory service is a centralized database that stores, organizes, and provides access to information about network resources and users. LDAP (Lightweight Directory Access Protocol) is the most common protocol used to query and modify this directory.

## Why it matters
Active Directory (AD) is the most widely deployed directory service, and it is also one of the most targeted attack surfaces in enterprise breaches. An attacker who compromises a Domain Controller gains the ability to forge Kerberos tickets (Golden Ticket attack), reset any user's password, and own every machine in the domain — a scenario known as domain compromise. Defenders monitor AD for anomalous privilege escalations, unusual replication requests (DCSync), and unauthorized Group Policy Object (GPO) modifications.

## Key facts
- **Active Directory** uses Kerberos for authentication and LDAP for directory queries; it runs on port **389** (LDAP) and **636** (LDAPS)
- **DCSync attacks** abuse AD replication privileges to extract password hashes without ever touching the Domain Controller directly
- **LDAP injection** is an attack where unsanitized user input manipulates directory queries, analogous to SQL injection but targeting directory services
- **Privileged accounts** in AD (Domain Admins, Enterprise Admins) are primary targets; their compromise is equivalent to full network ownership
- **Group Policy Objects (GPOs)** are distributed through AD and can be weaponized by attackers to deploy malware or backdoors across all domain-joined machines

## Related concepts
[[Kerberos Authentication]] [[LDAP]] [[Active Directory]] [[Privilege Escalation]] [[Golden Ticket Attack]]