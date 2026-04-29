# DCSync

## What it is
Imagine you're a fake branch bank calling headquarters and saying "Hey, I need a copy of all the safe combinations for my records" — and headquarters just hands them over because you look like a legitimate branch. DCSync is exactly that: an attack where an adversary with sufficient Active Directory privileges impersonates a Domain Controller and uses the legitimate replication protocol (MS-DRSR) to request password hashes for any account — including Domain Admins and krbtgt — directly from a real DC, no malware on the DC required.

## Why it matters
In the 2020 SolarWinds breach, attackers who gained high-privilege footholds used DCSync-style techniques to harvest credential hashes and move laterally across government and enterprise networks silently. Defenders monitor for non-DC machines initiating Directory Replication Service (DRS) calls, because legitimate replication only happens between Domain Controllers — any workstation or member server doing it is a red flag.

## Key facts
- **Required privileges:** Requires `Replicating Directory Changes` and `Replicating Directory Changes All` permissions — typically held by Domain Admins, Enterprise Admins, or any account explicitly granted these rights
- **Tool of choice:** Mimikatz implements DCSync via the `lsadump::dcsync` module; no code execution on the DC is needed
- **What it extracts:** NTLM hashes and Kerberos keys (including the krbtgt hash, enabling Golden Ticket attacks)
- **Detection signal:** SIEM alerts on Event ID 4662 (object access with replication GUIDs) from non-DC source machines
- **Mitigation:** Audit and restrict replication permissions; privileged account tiering prevents workstation-level compromise from reaching DC-level rights

## Related concepts
[[Pass-the-Hash]] [[Golden Ticket Attack]] [[Kerberos]] [[Active Directory Privilege Escalation]] [[NTLM Authentication]]