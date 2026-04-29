# Group Policy Modification

## What it is
Think of Group Policy as the employee handbook baked directly into every workstation — it governs who can do what, where, and when across an entire Windows domain. Group Policy Modification is the attacker technique of altering these domain-wide configuration objects (GPOs) to push malicious settings, scripts, or persistence mechanisms to every machine in scope simultaneously. It falls under MITRE ATT&CK T1484.001.

## Why it matters
In the 2020 SolarWinds-related intrusions, threat actors with domain admin privileges modified GPOs to deploy scheduled tasks and maintain persistence across hundreds of endpoints simultaneously — a single GPO edit cascaded to every domain-joined machine at next refresh. This makes GPO modification exceptionally high-leverage: one change propagates everywhere without touching individual hosts, bypassing per-machine defenses entirely.

## Key facts
- GPOs are stored in SYSVOL (`\\domain\SYSVOL`) and Active Directory; write access to either enables modification
- Attackers need **CreateChild**, **WriteProperty**, or **GenericWrite** permissions on a GPO — or **GpLink** permissions on an OU to link a malicious GPO
- Default GPO refresh interval is **90 minutes** (± 30 min randomization); `gpupdate /force` can trigger immediate application
- Detection signature: Event ID **5136** (Directory Service Object Modified) logs GPO changes in the Domain Controller Security log
- BloodHound can enumerate which users/groups have dangerous GPO permissions, making this a common lateral movement path in AD environments

## Related concepts
[[Active Directory Attack Paths]] [[Scheduled Task Persistence]] [[Lateral Movement]] [[Privilege Escalation]] [[SYSVOL Security]]