# PsExec (MITRE S0029)

PsExec is a free Microsoft Sysinternals tool that executes programs on remote computers, widely used by IT administrators and attackers for lateral movement and privilege escalation.

## Overview
- **ID**: S0029
- **Type**: TOOL
- **Platforms**: Windows
- **Created**: 31 May 2017
- **Last Modified**: 25 September 2024

## Techniques Used

| Technique | ID | Use |
|-----------|----|---------|
| [[Create Account - Domain Account]] | T1136.002 | Remote account creation on target systems |
| [[Create or Modify System Process - Windows Service]] | T1543.003 | Privilege escalation from admin to SYSTEM via -s argument |
| [[Lateral Tool Transfer]] | T1570 | Download/upload files over network shares |
| [[Remote Services - SMB/Windows Admin Shares]] | T1021.002 | Executes commands via ADMIN$ network share |
| [[System Services - Service Execution]] | T1569.002 | Execute binaries remotely using temporary Windows services |

## Threat Groups Using PsExec

Extensively used by 40+ threat groups including:
- [[Volt Typhoon]]
- [[Turla]]
- [[APT29]]
- [[FIN5]] (customized version)
- [[Wizard Spider]]
- [[Sandworm Team]]
- [[HAFNIUM]]
- [[Ember Bear]]
- [[Medusa Group]] (execution, lateral movement, defense evasion, exfiltration)

## Tags
#mitre #tool #lateral-movement #privilege-escalation #windows #remote-execution

---
_Ingested: [[2026-04-15]] 22:04 | Source: https://attack.mitre.org/software/S0029/_
