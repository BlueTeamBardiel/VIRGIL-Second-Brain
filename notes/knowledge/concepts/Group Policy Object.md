# Group Policy Object

## What it is
Think of it like a rulebook stamped onto every employee's desk the moment they sit down — the rules apply automatically, no one has to remember to enforce them. A Group Policy Object (GPO) is a container of configuration settings in Active Directory that defines the security and operational behavior of users and computers within a Windows domain, applied automatically when systems authenticate.

## Why it matters
Attackers who compromise a Domain Controller can create or modify GPOs to push malware, disable Windows Defender, or add rogue admin accounts across *every* machine in the domain simultaneously — one poisoned rulebook, thousands of compromised desks. Conversely, defenders use GPOs to enforce baseline hardening: disabling LLMNR, enforcing NTLMv2, restricting PowerShell execution, and deploying AppLocker rules across the entire organization from a single configuration point.

## Key facts
- GPOs are linked to **Sites**, **Domains**, or **Organizational Units (OUs)**; processing order follows LSDOU (Local → Site → Domain → OU), with later policies winning by default
- **Enforced** (No Override) GPOs cannot be blocked by child OUs; **Block Inheritance** prevents parent GPOs from applying to an OU
- GPOs are stored in two places: the **Group Policy Container** (Active Directory) and the **Group Policy Template** (SYSVOL share on DCs)
- A compromised SYSVOL or writable GPO is a critical AD attack path — tools like **BloodHound** map GPO-based privilege escalation routes
- Default refresh interval is **90 minutes** (± 30 min offset) for workstations; `gpupdate /force` triggers immediate reapplication

## Related concepts
[[Active Directory]] [[Privilege Escalation]] [[Security Baseline]] [[AppLocker]] [[BloodHound]]