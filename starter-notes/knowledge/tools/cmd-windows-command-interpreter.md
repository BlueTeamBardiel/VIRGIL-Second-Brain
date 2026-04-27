# cmd (Windows Command-Line Interpreter)

cmd is the Windows command-line interpreter used to interact with systems and execute processes and utilities. It contains native functionality for file operations, system discovery, and lateral movement.

## Overview
- **ID**: S0106
- **Type**: TOOL
- **Platforms**: Windows
- **Associated Software**: cmd.exe
- **Created**: 31 May 2017
- **Last Modified**: 16 April 2025

## Native Capabilities
- List files and directories (e.g., `dir`)
- Delete files (e.g., `del`)
- Copy files (e.g., `copy`)
- Execute programs and commands

## ATT&CK Techniques Used

| Technique ID | Technique Name | Use Case |
|---|---|---|
| T1059.003 | Command and Scripting Interpreter: Windows Command Shell | Execute programs and actions at CLI |
| T1083 | File and Directory Discovery | Find files/directories via `dir` |
| T1070.004 | Indicator Removal: File Deletion | Delete files from filesystem |
| T1105 | Ingress Tool Transfer | Copy files to/from external systems |
| T1570 | Lateral Tool Transfer | Copy files to/from internal systems |
| T1082 | System Information Discovery | Find OS information |

## Threat Groups Using This Software
- [[GALLIUM]] (G0093)
- [[BRONZE BUTLER]] (G0060)
- [[APT18]] (G0026)
- [[menuPass]] (G0045)
- [[Orangeworm]] (G0071)
- [[Volt Typhoon]] (G1017)

## Associated Campaigns
- [[Operation Honeybee]] (C0006)

## Tags
#tool #windows #command-line #mitre-attack #s0106

---
_Ingested: 2026-04-15 20:48 | Source: https://attack.mitre.org/software/S0106/_
