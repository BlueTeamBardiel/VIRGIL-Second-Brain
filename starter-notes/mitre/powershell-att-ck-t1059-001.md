# PowerShell (T1059.001)

Adversaries abuse PowerShell commands and scripts for execution, leveraging its powerful interactive CLI and scripting environment in Windows to perform discovery, code execution, and fileless malware deployment.

## Overview

**Technique ID:** T1059.001  
**Tactic:** [[Execution]]  
**Platforms:** Windows  
**Sub-technique of:** [[T1059]] (Command and Scripting Interpreter)

## Description

[[PowerShell]] is a built-in Windows scripting environment that adversaries exploit for:
- Discovery of system and network information
- Code execution via cmdlets like `Start-Process` and `Invoke-Command`
- Remote command execution (requires admin permissions)
- Downloading and executing payloads from the internet, in-memory or from disk
- Fileless malware execution without touching disk

## Execution Methods

- **Direct invocation:** powershell.exe binary
- **Indirect invocation:** Through .NET framework interfaces to `System.Management.Automation` assembly DLL and Windows CLI
- **Living-off-the-land:** Using built-in cmdlets and scripts

## Offensive Tools

- [[Empire]]
- [[PowerSploit]]
- [[PoshC2]]
- [[PSAttack]]

## Procedure Examples

### 2016 Ukraine Electric Power Attack (C0025)
[[Sandworm Team]] used PowerShell scripts to run credential harvesting tools in-memory to evade defenses.

### 2022 Ukraine Electric Power Attack (C0034)
[[Sandworm Team]] utilized a PowerShell utility called TANKTRAP to spread and launch a wiper using Windows Group Policy.

## Related Techniques

- [[T1059]] – Command and Scripting Interpreter
- [[T1059.002]] – AppleScript
- [[T1059.003]] – Windows Command Shell
- [[T1059.004]] – Unix Shell

## Tags

#execution #powershell #command-execution #fileless #evasion #att-ck

---
_Ingested: [[2026-04-15]] 22:02 | Source: https://attack.mitre.org/techniques/T1059/001/_
