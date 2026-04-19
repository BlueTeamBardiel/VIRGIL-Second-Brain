# Process Discovery (T1057)

Adversaries enumerate running processes to understand common software/applications on target systems and inform follow-on attack behaviors. Elevated access typically yields more detailed process information.

## Overview

**Tactic:** [[Discovery]]
**Platforms:** ESXi, Linux, Network Devices, Windows, macOS
**ID:** T1057
**Created:** 31 May 2017
**Last Modified:** 24 October 2025

## Techniques by Platform

### Windows
- [[tasklist]] utility via cmd
- [[Get-Process]] via [[PowerShell]]
- Native API calls: [[CreateToolhelp32Snapshot]]

### macOS & Linux
- `ps` command
- `/proc` filesystem enumeration

### ESXi
- `ps` command
- `esxcli system process list`

### Network Devices
- Network Device CLI commands (e.g., `show processes`)

## Procedure Examples

Notable threat actors and malware families using process discovery:
- [[APT1]], [[APT28]], [[APT3]], [[APT37]], [[APT38]] – tasklist enumeration
- [[4H RAT]], [[Agent Tesla]], [[Apostle]] – process listing and inspection
- [[AsyncRAT]] – debugger detection via process inspection
- [[Avaddon]], [[AvosLocker]] – process enumeration for ransomware propagation

## Mitigation & Detection

Process discovery is difficult to mitigate but can be detected through:
- Monitoring execution of process enumeration utilities
- Analyzing API call patterns
- Tracking suspicious process queries in security event logs

## Tags

#attack #discovery #t1057 #process-enumeration #reconnaissance

---
_Ingested: [[2026-04-15]] 22:02 | Source: https://attack.mitre.org/techniques/T1057/_
