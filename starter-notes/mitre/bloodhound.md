# BloodHound

BloodHound is an [[Active Directory]] reconnaissance tool that reveals hidden relationships and identifies attack paths within AD environments. It is widely used by threat actors for post-compromise domain enumeration and privilege escalation planning.

## Overview

- **MITRE ID**: S0521
- **Type**: TOOL
- **Platforms**: Windows
- **Created**: 28 October 2020
- **Last Modified**: 12 March 2025

## Techniques Used

| Tactic | Technique | Subtechnique | Description |
|--------|-----------|--------------|-------------|
| Enterprise | T1087 | Account Discovery: Local Account | Identifies users with local administrator rights |
| Enterprise | T1087 | Account Discovery: Domain Account | Collects information about domain users and domain admins |
| Enterprise | T1560 | Archive Collected Data | Compresses collected data via SharpHound into ZIP files |
| Enterprise | T1059 | Command and Scripting Interpreter: PowerShell | Uses PowerShell to pull AD information |
| Enterprise | T1482 | Domain Trust Discovery | Maps domain trusts and identifies misconfigurations |
| Enterprise | T1615 | Group Policy Discovery | Collects local admin information via GPO |
| Enterprise | T1106 | Native API | Uses .NET API calls in SharpHound to retrieve AD data |
| Enterprise | T1069 | Permission Groups Discovery: Local Groups | Collects local group and membership information |
| Enterprise | T1069 | Permission Groups Discovery: Domain Groups | Collects domain group and membership information |
| Enterprise | T1018 | Remote System Discovery | Enumerates domain computers and domain controllers |
| Enterprise | T1033 | System Owner/User Discovery | Collects information on user sessions |

## Threat Groups

- [[Wizard Spider]] (G0102)
- [[APT29]] (G0016)
- [[Chimera]] (G0114)
- [[TA505]] (G0092)
- [[Play]] (G1040)
- [[Ember Bear]] (G1003) – profiled AD environments with BloodHound

## Campaigns

- [[Operation Wocao]] (C0014) – Threat actors used BloodHound to discover domain trusts

## Tags

#tool #active-directory #reconnaissance #post-exploitation #domain-enumeration

---
_Ingested: [[2026-04-15]] 22:04 | Source: https://attack.mitre.org/software/S0521/_
