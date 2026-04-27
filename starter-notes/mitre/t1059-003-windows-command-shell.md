# T1059.003: Windows Command Shell

Adversaries abuse the Windows command shell (cmd.exe) for execution and control of system functions. Batch files (.bat, .cmd) enable sequential command execution with scripting operations like conditionals and loops, commonly used for repetitive tasks or multi-system deployments.

## Overview

**ID:** T1059.003  
**Sub-technique of:** [[T1059]] (Command and Scripting Interpreter)  
**Tactic:** [[Execution]]  
**Platforms:** Windows  
**Last Modified:** 24 October 2025

## Description

The Windows command shell (cmd) is the primary command prompt on Windows systems and can control nearly all system aspects depending on permission levels. It can be invoked remotely via [[Remote Services]] such as [[SSH]].

Adversaries leverage cmd to:
- Execute single commands or payloads
- Abuse cmd interactively with I/O forwarded over command and control channels
- Execute batch files for sequential task execution

## Related Techniques

- [[T1059.001]] — PowerShell
- [[T1059.002]] — AppleScript
- [[T1059.004]] — Unix Shell
- [[T1059.005]] — Visual Basic
- [[T1059.006]] — Python

## Procedure Examples

| Actor/Campaign | Description |
|---|---|
| [[Sandworm Team]] | Used xp_cmdshell command in MS-SQL during 2016 Ukraine Electric Power Attack |
| [[4H RAT]] | Has capability to create a remote shell |

## Tags

#att&ck #execution #command-shell #windows #t1059

---
_Ingested: [[2026-04-15]] 22:02 | Source: https://attack.mitre.org/techniques/T1059/003/_
