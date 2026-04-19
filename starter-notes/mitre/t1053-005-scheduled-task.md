# T1053.005: Scheduled Task

Adversaries abuse Windows Task Scheduler to execute malicious code on initial, recurring, or scheduled basis for persistence, execution, lateral movement, and privilege escalation.

## Overview

**Technique ID:** T1053.005  
**Sub-technique of:** [[T1053]] (Scheduled Task/Job)  
**Tactics:** [[Execution]], [[Persistence]], [[Privilege Escalation]]  
**Platforms:** [[Windows]]  
**Last Modified:** 24 October 2025

## Description

Adversaries leverage the Windows [[Task Scheduler]] for malicious task scheduling. Access methods include:

- **schtasks utility** – direct command-line execution
- **Task Scheduler GUI** – via Administrator Tools in Control Panel
- **.NET wrapper** – programmatic access
- **netapi32 library** – Windows API
- **[[WMI]]** (Windows Management Instrumentation) – task creation
- **PowerShell Cmdlet** – `Invoke-CimMethod` via WMI class `PS_ScheduledTask` and XML paths

## Use Cases

- **Persistence:** Execute programs at system startup or on recurring schedule
- **Execution:** Remote code execution as part of [[Lateral Movement]]
- **Privilege Escalation:** Run processes under SYSTEM or other privileged accounts
- **Defense Evasion:** Mask execution under signed/trusted system processes (similar to [[System Binary Proxy Execution]])

## Evasion Techniques

Adversaries create "hidden" scheduled tasks not visible to defender tools and manual enumeration:

- Delete the Security Descriptor (SD) registry value (requires SYSTEM permissions)
- Alter metadata (e.g., Index value) in associated registry keys

## Related Procedures

- **Sandworm Team** – Leveraged scheduled tasks via GPO to execute [[CaddyWiper]] during 2022 Ukraine Electric Power Attack
- **APT29, APT3, APT-C-36** – Used scheduled tasks for persistence
- **Agent Tesla, Anchor, Apostle, AppleJeus** – Malware families exploiting scheduled tasks

## Mitigation & Detection

Monitor:
- schtasks command execution
- Task Scheduler registry modifications
- WMI-based task creation
- PowerShell scheduled task operations

## Tags

#attack/technique #persistence #execution #privilege-escalation #windows #task-scheduler #scheduled-task

---
_Ingested: [[2026-04-15]] 22:02 | Source: https://attack.mitre.org/techniques/T1053/005/_
