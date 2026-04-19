# Process Injection (T1055)

Process injection is a technique where adversaries inject code into running processes to evade detection and potentially escalate privileges. Execution via process injection masks malicious activity under legitimate process contexts.

## Overview

**Tactics:** Defense Evasion, Privilege Escalation
**Platforms:** Linux, Windows, macOS
**ID:** T1055

Adversaries inject code into processes to:
- Evade process-based defenses
- Elevate privileges
- Access process memory and system/network resources
- Hide execution from security products

Sophisticated samples may perform multiple injections to segment modules, using [[inter-process communication|IPC]] mechanisms like named pipes as communication channels.

## Sub-techniques

| ID | Name |
|---|---|
| [[T1055.001]] | Dynamic-link Library Injection |
| [[T1055.002]] | Portable Executable Injection |
| [[T1055.003]] | Thread Execution Hijacking |
| [[T1055.004]] | Asynchronous Procedure Call |
| [[T1055.005]] | Thread Local Storage |
| [[T1055.008]] | Ptrace System Calls |
| [[T1055.009]] | Proc Memory |
| [[T1055.011]] | Extra Window Memory Injection |
| [[T1055.012]] | Process Hollowing |
| [[T1055.013]] | Process Doppelgänging |
| [[T1055.014]] | VDSO Hijacking |
| [[T1055.015]] | ListPlanting |

## Procedure Examples

- **2015 Ukraine Electric Power Attack**: [[Sandworm Team]] loaded [[BlackEnergy]] into svchost.exe, which launched iexplore.exe for C2
- **3CX Supply Chain Attack**: [[AppleJeus]]'s VEILEDSIGNAL injected C2 code into Chrome, Firefox, or Edge browsers via named pipes
- **APT32**: Injected [[Cobalt Strike]] beacon into Rundll32.exe
- **APT37**: Injected ROKRAT variant into cmd.exe
- **APT38**: Injected payloads into explorer.exe
- **APT41**: Injected WINTERLOVE component into iexplore.exe

## Tags

#attack #evasion #privilege-escalation #defense-evasion #t1055

---
_Ingested: [[2026-04-15]] 22:02 | Source: https://attack.mitre.org/techniques/T1055/_
