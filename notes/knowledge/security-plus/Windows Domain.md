# Windows Domain

## What it is
Think of a Windows Domain like a hotel with a front desk: guests don't get individual room keys from each door — they check in once at the front desk and get a keycard that works everywhere. A Windows Domain is a centralized network administration model where a **Domain Controller (DC)** authenticates users once and grants access to shared resources across the network. Authentication is handled via **Kerberos** and managed through **Active Directory (AD)**.

## Why it matters
In the 2020 SolarWinds attack, adversaries moved laterally across victim networks by compromising domain-joined machines and eventually reaching the Domain Controller — at that point, they owned everything. Defenders must treat the DC as crown jewels: a compromised DC means attackers can forge Kerberos tickets (Golden Ticket attack), impersonate any user, and persist indefinitely even after password resets.

## Key facts
- **Domain Controller (DC)** runs Active Directory Domain Services (AD DS) and is the central authentication authority for the domain
- **Kerberos** is the default authentication protocol in Windows domains (port 88); NTLM is the legacy fallback
- A **Golden Ticket attack** forges a Kerberos TGT using the `KRBTGT` account hash, granting unlimited, persistent domain access
- **Group Policy Objects (GPOs)** are applied domain-wide from the DC, making them both a powerful hardening tool and a high-value attacker target
- Domain accounts are stored in AD; **local accounts** exist only on individual machines and do not authenticate against the DC

## Related concepts
[[Active Directory]] [[Kerberos Authentication]] [[Golden Ticket Attack]] [[Lateral Movement]] [[Group Policy]]