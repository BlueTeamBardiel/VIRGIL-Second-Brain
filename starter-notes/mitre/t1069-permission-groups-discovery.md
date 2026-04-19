# T1069: Permission Groups Discovery

Adversaries enumerate group and permission settings to identify available user accounts, group memberships, and elevated privilege holders in compromised environments. This discovery technique informs follow-on lateral movement and privilege escalation activities.

## Overview
- **ATT&CK ID:** T1069
- **Tactic:** [[Discovery]]
- **Platforms:** Containers, IaaS, Identity Provider, Linux, Office Suite, SaaS, Windows, macOS
- **Created:** 31 May 2017
- **Last Modified:** 24 October 2025

## Sub-techniques
- [[T1069.001]] – Local Groups
- [[T1069.002]] – Domain Groups
- [[T1069.003]] – Cloud Groups

## Procedure Examples

### Tools & Commands
- `net group` / `net group /domain` – Windows group enumeration
- [[PowerShell]] cmdlets (e.g., Get-ManagementRoleAssignment)
- `id`, `groups`, `getent group` – Linux/Unix group discovery
- `dscl`, `dscacheutil` – macOS group enumeration
- Kubernetes node permission checks

### Threat Actors
- [[APT3]], [[APT29]], [[APT41]] – Used net group commands and PowerShell for enumeration
- [[FIN13]] – Enumerated users and roles from treasury systems
- [[Scattered Spider]] – Targeted vSphere and ESX admin groups
- [[TA505]], [[Volt Typhoon]] – Group and user discovery via native tools
- Malware: [[IcedID]], [[MURKYTOP]], [[TrickBot]], [[Siloscape]], [[ShimRatReporter]], [[Carbon]]

## Mitigations
No preventive controls; based on abuse of legitimate system features. Focus on detection and response.

## Detection
- Monitor for `net.exe`, [[PowerShell]], and WMI group enumeration
- Track execution of `id`, `groups`, `getent`, `dscl`, `dscacheutil`
- Detect behavioral patterns preceding lateral movement or privilege escalation
- **Detection ID:** DET0179 (Behavioral Detection of Permission Groups Discovery)

## Tags
#attack-technique #discovery #enumeration #privilege-escalation #lateral-movement

---
_Ingested: [[2026-04-15]] 22:02 | Source: https://attack.mitre.org/techniques/T1069/_
