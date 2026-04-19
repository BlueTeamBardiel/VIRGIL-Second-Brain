# T1112: Modify Registry

Adversaries interact with the Windows Registry to aid in defense evasion, persistence, and execution. Registry modifications can hide malicious payloads, impair defenses, enable lateral movement, and conceal persistence mechanisms.

## Overview

**Technique ID:** T1112  
**Platforms:** Windows  
**Tactics:** Defense Evasion, Persistence  
**Last Modified:** 24 October 2025

## Description

Adversaries may interact with the Windows Registry as part of various attack techniques. Access to specific Registry areas depends on account permissions, with some keys requiring administrator-level access.

### Common Tools & Methods
- Built-in Windows command-line utility `reg.exe` for local or remote Registry modification
- Remote access tools with Windows API Registry functionality

### Attack Patterns

**Obfuscation & Hiding:**
- Hide configuration information or [[malware]] payloads via [[Obfuscated Files or Information]]
- Prepend key names with null characters to cause errors or be ignored by standard utilities
- Conceal payloads/commands used for [[persistence]]

**Defense Impairment:**
- Enable macros for all Microsoft Office products
- Allow privilege escalation without user alerts
- Increase maximum outbound requests
- Modify systems to store plaintext credentials in memory

**Lateral Movement:**
- Modify Registry on remote systems to aid execution
- Requires remote Registry service running on target
- Requires [[Valid Accounts]] and access to remote SMB/Windows Admin Shares for RPC communication

## Procedure Examples

| Campaign | Details |
|----------|----------|
| **2015 Ukraine Electric Power Attack** (C0028) | [[Sandworm Team]] modified in-registry Internet settings to lower security before executing `rundll32.exe` to launch malware communicating with C2 servers |

## Related Concepts

- [[Obfuscated Files or Information]]
- [[Impair Defenses]]
- [[Valid Accounts]]
- [[Persistence]]
- [[Defense Evasion]]

## Tags

#attack-technique #windows #registry #defense-evasion #persistence #t1112

---
_Ingested: [[2026-04-15]] 22:02 | Source: https://attack.mitre.org/techniques/T1112/_
