# MPD

## What it is
Like a bouncer at a club who checks IDs at the door before letting anyone touch the sound system, Mandatory Policy Deployment (MPD) — more commonly referenced as **Microsoft Policy Deployment** or **Mandatory Integrity Control policy enforcement** — but most precisely in security contexts: **MPD refers to Mobile Privileged Device** configurations or, in network security, **Multi-Path Data** routing. However, the dominant exam-relevant meaning is **Mandatory Policy Deployment**: a centralized mechanism that pushes and enforces Group Policy Objects (GPOs) or security baselines across endpoints, ensuring no machine can opt out.

## Why it matters
In a 2021-style ransomware scenario, attackers who compromise a single admin workstation often move laterally because endpoint security policies were inconsistently applied — some machines never received the "disable macros" GPO. MPD through Active Directory Group Policy ensures that critical hardening baselines (AppLocker rules, PowerShell Constrained Language Mode, Windows Defender settings) are uniformly enforced, closing the gaps attackers exploit for lateral movement.

## Key facts
- GPOs delivered via MPD are processed in **LSDOU order**: Local → Site → Domain → Organizational Unit (later policies override earlier ones)
- **Enforced (No Override)** flag on a GPO prevents child OUs from overriding it, making it a true mandatory deployment
- **Loopback Processing** allows computer-level policies to override user policies on specific machines (e.g., kiosk systems)
- Security baselines from **DISA STIGs** or **CIS Benchmarks** are commonly deployed via this mechanism
- Policy application can be verified with `gpresult /r` (summary) or `gpresult /h report.html` (full HTML report) — both are auditing tools for CySA+ scenarios

## Related concepts
[[Group Policy Objects]] [[Active Directory]] [[Security Baselines]] [[Least Privilege]] [[Configuration Management]]