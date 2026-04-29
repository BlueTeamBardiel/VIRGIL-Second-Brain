# Sysinternals

## What it is
Think of Sysinternals as a mechanic's X-ray machine for Windows — it lets you see exactly what's happening beneath the hood that the normal dashboard won't show you. It is a suite of free, Microsoft-owned advanced utilities designed for deep inspection, troubleshooting, and monitoring of Windows systems. Tools like Process Explorer, Autoruns, and ProcMon expose process behavior, registry changes, file access, and network activity at a granular level.

## Why it matters
During incident response, a malware analyst investigating a ransomware infection can run **Autoruns** to immediately identify persistence mechanisms — such as a malicious DLL registered under `HKCU\Software\Microsoft\Windows\CurrentVersion\Run` — that survive reboots and evade standard Task Manager visibility. Without Sysinternals, that persistence entry might go unnoticed while the threat lingers. Defenders also use **Process Monitor** to catch fileless malware injecting shellcode into legitimate processes like `svchost.exe`.

## Key facts
- **Process Explorer** is a supercharged Task Manager that shows parent-child process relationships, helping detect process injection or masquerading (e.g., a fake `svchost.exe` spawned by `cmd.exe`)
- **Autoruns** is considered the most comprehensive tool for identifying persistence mechanisms across 30+ autostart locations
- **ProcMon (Process Monitor)** captures real-time file system, registry, and process/thread activity — critical for dynamic malware analysis
- **Sysmon (System Monitor)** integrates with Windows Event Log and is heavily used in SIEM pipelines for threat hunting using event IDs like 1 (process creation) and 3 (network connections)
- All tools are **digitally signed by Microsoft** and hosted at live.sysinternals.com, meaning they can be run directly from a UNC path without installation

## Related concepts
[[Process Injection]] [[Windows Registry Persistence]] [[Sysmon]] [[Incident Response]] [[Threat Hunting]]