# LAPS

## What it is
Imagine every apartment in a building shares the same master key — if one tenant copies it, every unit is compromised. LAPS (Local Administrator Password Solution) fixes this by giving each apartment a *unique*, automatically rotating key. Technically, it's a Microsoft solution that generates and manages unique, randomized local administrator passwords for each domain-joined Windows machine, storing them securely in Active Directory.

## Why it matters
Without LAPS, attackers who compromise one machine's local admin credentials can use **Pass-the-Hash** or credential reuse to pivot laterally across every machine in the domain sharing that same password — a technique called "same local admin password" lateral movement. With LAPS deployed, stealing credentials from one workstation yields a password useless anywhere else, breaking the lateral movement chain before it starts.

## Key facts
- Passwords are stored in the Active Directory computer object attribute `ms-Mcs-AdmPwd` and are readable only by explicitly delegated users/groups
- LAPS automatically rotates passwords based on a configurable expiration policy (default: 30 days)
- **Windows LAPS** (2023+) is built natively into Windows 11 22H2 and Server 2022, superseding the legacy standalone LAPS client
- Passwords can be backed up to **Azure AD (Entra ID)** in addition to on-premises AD, supporting hybrid environments
- A key attack against LAPS is reading `ms-Mcs-AdmPwd` if ACLs are misconfigured — tools like **LAPSToolkit** automate finding over-permissioned accounts that can read these attributes

## Related concepts
[[Pass-the-Hash]] [[Active Directory]] [[Privileged Access Management]] [[Lateral Movement]] [[Credential Stuffing]]