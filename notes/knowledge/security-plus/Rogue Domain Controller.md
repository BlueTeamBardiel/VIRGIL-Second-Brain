# Rogue Domain Controller

## What it is
Imagine a counterfeit postal sorting office secretly inserted into a city's mail network — every letter routed through it can be read, altered, or misdirected before passing along normally. A rogue domain controller (DC) is an unauthorized Windows server promoted to DC status within an Active Directory environment, allowing an attacker to replicate directory data, intercept authentication, and manipulate group policy across the domain.

## Why it matters
In a DCSync attack, an adversary who has compromised a privileged account can simulate a rogue DC by calling replication APIs (specifically `DsGetNCChanges`) to pull password hashes for every user — including `krbtgt` — from a legitimate DC without ever touching the DC's disk. This technique was central to the 2020 SolarWinds intrusion, where attackers harvested credentials silently using exactly this replication mechanism.

## Key facts
- **DCSync** does not require physically standing up a server; it abuses legitimate DC replication protocols using tools like Mimikatz's `lsadump::dcsync`
- A true rogue DC requires `DS-Install-Replica` rights (typically Domain Admin or delegated privileges) to be promoted via `dcpromo` or PowerShell
- Rogue DCs can distribute malicious **Group Policy Objects (GPOs)**, pushing backdoors or disabling defenses domain-wide
- Detection relies on monitoring **Event ID 4742** (computer account changes) and **Event ID 4929** (AD replication source removed) alongside replication traffic anomalies
- **Tiered administration** and restricting `Replicating Directory Changes All` permissions are primary mitigations against DCSync-style abuse

## Related concepts
[[Active Directory]] [[DCSync Attack]] [[Pass-the-Hash]] [[Golden Ticket Attack]] [[Privilege Escalation]] [[Group Policy Object Abuse]]