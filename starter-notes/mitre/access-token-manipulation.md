# Access Token Manipulation

Adversaries modify [[Windows]] access tokens to operate under different user or system security contexts, bypassing access controls and elevating privileges. This technique enables attackers to make processes appear as children of different processes or belonging to different users.

## Overview

[[Windows]] uses access tokens to determine process ownership. Adversaries can:
- **Steal tokens** from existing processes using [[Windows API]] functions
- **Apply tokens** to existing processes ([[T1134.001|Token Impersonation/Theft]])
- **Spawn new processes** with stolen tokens ([[T1134.002|Create Process with Token]])
- **Create custom tokens** ([[T1134.003|Make and Impersonate Token]])
- **Spoof parent process IDs** ([[T1134.004|Parent PID Spoofing]])
- **Inject SID-History** for privilege escalation ([[T1134.005|SID-History Injection]])

## Attack Flow

Token stealing typically requires administrator context. However, standard users can create impersonation tokens via `runas` command or [[Windows API]]. Once stolen, tokens enable:
- Privilege escalation from administrator to SYSTEM
- Lateral movement with impersonated account credentials
- Bypass of access controls and UAC mechanisms

## Exploitation Methods

- **SeDebugPrivilege abuse** — Grant debugging permissions for token manipulation
- **Named-pipe impersonation** — Escalate via pipe communication (e.g., JuicyPotato, BADPOTATO)
- **Active Directory fields** — Modify tokens via AD attributes
- **PowerSploit Invoke-TokenManipulation** — Automated token abuse framework

## Notable Malware & Campaigns

| Actor | Tool/Method | Impact |
|-------|-------------|--------|
| [[APT41]] | ConfuserEx/BADPOTATO | Named-pipe impersonation → SYSTEM escalation |
| [[Blue Mockingbird]] | JuicyPotato | Web app pool → SYSTEM escalation |
| [[FIN6]] | Metasploit named-pipe | Privilege escalation |
| [[HermeticWiper]] | AdjustTokenPrivileges | SeDebugPrivilege, SeBackupPrivilege, SeLoadDriverPrivilege |
| [[Empire]] | PowerSploit Invoke-TokenManipulation | Post-exploitation automation |
| [[Cuba]] | SeDebugPrivilege + AdjustTokenPrivileges | Privilege escalation |
| [[Duqu]] | Token harvesting | Process-specific privilege enumeration |
| [[BlackCat]] | Token modification | Ransomware privilege escalation |
| [[Gelsemium]] | UAC bypass | Windows 7 elevation |

## Mitigation

- Enforce least privilege; minimize accounts with SeDebugPrivilege
- Restrict token manipulation via [[Windows]] security policies
- Monitor token creation and privilege adjustment API calls
- Implement mandatory access controls and process signing

## Detection

- Monitor [[Windows API]] calls: `OpenProcess`, `DuplicateToken`, `AdjustTokenPrivileges`
- Audit privilege escalation logs (Event ID 4672, 4673, 4674)
- Track process creation with unusual parent-child relationships
- Alert on `runas` usage outside expected patterns

## References

- **MITRE ATT&CK:** T1134 (Enterprise)
- **Tactics:** Defense Evasion, Privilege Escalation
- **Platforms:** [[Windows]]
- **Last Modified:** 24 October 2025

## Tags

#attack-technique #privilege-escalation #defense-evasion #windows #token-abuse #lateral-movement

---
_Ingested: [[2026-04-15]] 22:02 | Source: https://attack.mitre.org/techniques/T1134/_
