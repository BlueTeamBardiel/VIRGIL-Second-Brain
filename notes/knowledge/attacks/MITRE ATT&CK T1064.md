# MITRE ATT&CK T1064

## What it is
Like a burglar who disguises their break-in tools inside a pizza delivery box, adversaries use scripting languages to wrap malicious actions in familiar, trusted formats. T1064 (Scripting) describes the technique where attackers leverage scripting languages — PowerShell, Bash, VBScript, Python, JavaScript — to execute commands, automate attack stages, and evade defenses that focus on binary executables.

## Why it matters
During the 2016 Democratic National Committee breach, APT28 used PowerShell scripts to execute in-memory payloads that never touched disk, bypassing antivirus tools that scanned only files. Defenders responded by enabling PowerShell Script Block Logging, which captures script content before execution and became a cornerstone of endpoint detection strategies.

## Key facts
- T1064 was deprecated in ATT&CK v9 and split into more specific sub-techniques under **T1059 (Command and Scripting Interpreter)**, including T1059.001 (PowerShell) and T1059.005 (VBScript)
- Scripts execute within **trusted host processes** (wscript.exe, powershell.exe, cmd.exe), making process-based whitelisting ineffective without deep inspection
- **AMSI (Antimalware Scan Interface)** was introduced specifically to allow security tools to inspect script content at runtime before execution
- Fileless malware heavily depends on scripting — scripts run in memory, leaving minimal forensic artifacts compared to traditional executables
- Detection relies on **PowerShell Script Block Logging (Event ID 4104)**, **Module Logging**, and **Transcription Logging** — all configurable via Group Policy

## Related concepts
[[T1059 Command and Scripting Interpreter]] [[PowerShell Empire]] [[Fileless Malware]] [[AMSI Bypass]] [[Living off the Land Binaries]]