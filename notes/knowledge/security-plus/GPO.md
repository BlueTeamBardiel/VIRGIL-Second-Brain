# GPO

## What it is
Think of a GPO like a master thermostat in a hotel — one setting controls the temperature in hundreds of rooms simultaneously, without staff visiting each one. A Group Policy Object (GPO) is a collection of settings in Active Directory that administrators apply to users and computers across an entire domain, OU, or site from a single centralized location.

## Why it matters
Attackers who compromise a Domain Controller can create or modify GPOs to push malicious scripts to every machine in a domain — a technique seen in ransomware campaigns like Ryuk, where GPOs were weaponized to disable antivirus and deploy payloads network-wide in minutes. Defenders use GPOs to enforce security baselines: disabling LLMNR, restricting PowerShell execution policy, and mandating SMB signing across thousands of endpoints simultaneously.

## Key facts
- GPOs are stored in two locations: the **Group Policy Container** (Active Directory) and the **Group Policy Template** (SYSVOL share on DCs), both required for proper function
- GPOs are processed in **LSDOU order**: Local → Site → Domain → Organizational Unit; later policies override earlier ones by default
- **Enforced (No Override)** GPOs cannot be blocked by child OUs — critical for mandatory security settings
- Abusing GPO write permissions is a privilege escalation path — tools like **BloodHound** map these misconfigurations specifically
- The default **Domain Policy** and **Default Domain Controllers Policy** GPOs exist in every AD environment and are high-value targets for persistence

## Related concepts
[[Active Directory]] [[Privilege Escalation]] [[SYSVOL]] [[BloodHound]] [[Lateral Movement]]