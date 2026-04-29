# Domain Compromise

## What it is
Imagine a master skeleton key that opens every lock in a skyscraper — whoever holds it owns the entire building. Domain compromise is exactly that: an attacker gains control of an Active Directory domain by obtaining the credentials or privileges of a Domain Admin (or equivalent), giving them unrestricted access to every system, user, and resource in the network.

## Why it matters
In the 2020 SolarWinds attack, threat actors moved laterally through victim networks until they could forge Kerberos tickets (Golden Ticket attack) using stolen KRBTGT account hashes — effectively achieving domain compromise and persisting undetected for months. Defenders monitor for impossible logon patterns, unusual KRBTGT resets, and DCSync replication requests from non-DC machines to catch this early.

## Key facts
- **DCSync attack** allows an attacker with replication rights to pull password hashes from a Domain Controller without ever logging into it directly
- **Golden Ticket** = forged Kerberos TGT using the KRBTGT hash; valid for 10 years by default and survives password resets unless KRBTGT is reset *twice*
- **Pass-the-Hash (PtH)** and **Pass-the-Ticket (PtT)** are common lateral movement techniques used *en route* to domain compromise
- Indicators of domain compromise include unexpected AdminSDHolder modifications, new accounts added to Domain Admins, and replication traffic from non-DC hosts
- Remediation requires isolating Domain Controllers, resetting KRBTGT password twice (48 hours apart), and rebuilding trust for all privileged accounts

## Related concepts
[[Kerberos Authentication]] [[Pass-the-Hash]] [[Lateral Movement]] [[Privilege Escalation]] [[Active Directory Security]]