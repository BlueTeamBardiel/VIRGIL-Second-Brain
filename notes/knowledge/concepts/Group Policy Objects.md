# Group Policy Objects

## What it is
Think of GPOs like a master rulebook that a school principal distributes to every classroom simultaneously — teachers (computers/users) must follow those rules the moment they walk in. Precisely: Group Policy Objects are containers of configuration settings in Active Directory that define security policies, software installations, and user restrictions, automatically applied to Organizational Units (OUs), domains, or sites during user login or machine startup.

## Why it matters
Attackers who gain Domain Admin privileges frequently abuse GPOs to achieve persistent, domain-wide compromise — pushing malicious scripts or disabling Windows Defender across every machine simultaneously. In the 2020 SolarWinds attack, adversaries leveraged GPO modification to move laterally and maintain persistence. Defensively, security teams use GPOs to enforce password complexity, disable LLMNR/NBT-NS (mitigating LLMNR poisoning), and restrict removable media across an entire enterprise at once.

## Key facts
- GPOs are processed in **LSDOU order**: Local → Site → Domain → Organizational Unit; later policies override earlier ones unless "Enforced" is set
- **Restricted Groups** within GPOs control local administrator group membership, a critical hardening control
- GPOs are stored in two locations: the **Group Policy Container** (in Active Directory) and the **Group Policy Template** (in SYSVOL on domain controllers)
- `gpresult /r` and `gpresult /h report.html` are the primary tools for auditing applied GPOs on a Windows endpoint
- Attackers use tools like **BloodHound** to identify GPOs with over-permissioned edit rights, making GPO misconfiguration a significant privilege escalation vector

## Related concepts
[[Active Directory]] [[Privilege Escalation]] [[LLMNR Poisoning]] [[Organizational Units]] [[BloodHound]]