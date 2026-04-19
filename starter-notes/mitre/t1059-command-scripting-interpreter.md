# T1059: Command and Scripting Interpreter

Adversaries abuse command and script interpreters to execute commands, scripts, or binaries. These are common features across platforms—Unix shells on macOS/Linux, PowerShell and Command Shell on Windows, plus cross-platform tools like Python and JavaScript.

## Summary
- **ID**: T1059
- **Tactic**: [[Execution]]
- **Platforms**: Windows, macOS, Linux, ESXi, IaaS, Identity Provider, Network Devices, Office Suite
- **Version**: 2.6 (Last Modified: 24 October 2025)

## Sub-techniques (13)

| ID | Name |
|---|---|
| [[T1059.001]] | PowerShell |
| [[T1059.002]] | AppleScript |
| [[T1059.003]] | Windows Command Shell |
| [[T1059.004]] | Unix Shell |
| [[T1059.005]] | Visual Basic |
| [[T1059.006]] | Python |
| [[T1059.007]] | JavaScript |
| [[T1059.008]] | Network Device CLI |
| [[T1059.009]] | Cloud API |
| [[T1059.010]] | AutoHotKey & AutoIT |
| [[T1059.011]] | Lua |
| [[T1059.012]] | Hypervisor CLI |
| [[T1059.013]] | Container CLI/API |

## Execution Methods
- Embed commands/scripts in Initial Access payloads (lure documents)
- Download secondary payloads from C2
- Execute via interactive terminals/shells
- Utilize remote services for remote execution

## Notable Groups & Tools Using This Technique
- **Groups**: [[APT19]], [[APT32]], [[APT37]], [[APT39]], [[Dragonfly]], [[FIN5]], [[FIN6]], [[FIN7]]
- **Malware**: [[Bandook]], [[CHOPSTICK]], [[DarkComet]], [[Empire]], [[FIVEHANDS]]

## Tags
#mitre #attack #t1059 #execution #command-line #scripting #persistence

---
_Ingested: [[2026-04-10]] 14:18 | Source: https://attack.mitre.org/techniques/T1059/_
