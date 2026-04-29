# Task Manager

## What it is
Think of Task Manager as the control tower at an airport — it sees every "flight" (process) taking off, landing, and taxiing, along with how much runway (CPU/memory) each one is consuming. Precisely, Task Manager is a Windows system utility that displays running processes, resource utilization (CPU, RAM, disk, network), startup programs, and active user sessions in real time.

## Why it matters
During incident response, an analyst investigating a suspected compromise will open Task Manager to spot anomalous processes — for example, a malware sample masquerading as `svchost.exe` running from `C:\Users\Public\` instead of `C:\Windows\System32\`. Legitimate svchost processes always originate from System32; the wrong path is an immediate red flag that warrants memory forensics and process tree analysis.

## Key facts
- Task Manager can be launched via `Ctrl+Shift+Esc`, `Ctrl+Alt+Del`, or `taskmgr.exe` — attackers sometimes kill it using tools like `taskkill /IM taskmgr.exe` to hinder live analysis.
- The **Details tab** exposes PID (Process ID), which correlates directly to network connections visible in `netstat -ano`, enabling analysts to map suspicious outbound traffic to a specific executable.
- Malware persistence can be partially revealed via the **Startup tab**, which mirrors entries in `HKCU\Software\Microsoft\Windows\CurrentVersion\Run`.
- Task Manager shows **parent-child process relationships** only superficially; tools like Process Explorer or Process Hacker provide full process trees and DLL injection visibility that Task Manager lacks.
- On CySA+/Security+ exams, Task Manager is classified under **host-based analysis** tools alongside `netstat`, `ipconfig`, and Event Viewer for first-responder triage.

## Related concepts
[[Process Hollowing]] [[Sysinternals Process Explorer]] [[Incident Response Triage]] [[Persistence Mechanisms]] [[netstat]]