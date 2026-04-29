# SFC

## What it is
Like a building inspector who checks every pipe, wire, and beam against the original blueprint, SFC (System File Checker) is a Windows built-in utility that scans all protected operating system files and replaces corrupted or modified ones with cached originals. It runs as `sfc /scannow` from an elevated command prompt and uses the Windows Resource Protection (WRP) mechanism to restore file integrity.

## Why it matters
After a malware infection, adversaries sometimes replace legitimate Windows system binaries (like `cmd.exe` or `svchost.exe`) with trojanized versions to maintain persistence. Running SFC as part of incident response can detect these substitutions and restore clean copies — though a sophisticated attacker who has compromised the WRP cache itself can defeat this check, meaning SFC is a first-responder tool, not a final verdict.

## Key facts
- Command syntax: `sfc /scannow` requires administrative privileges; logs results to `%WinDir%\Logs\CBS\CBS.log`
- SFC verifies digital signatures of protected files against known-good versions stored in the Windows Component Store (`WinSxS` folder)
- SFC alone cannot fix corruption if the Component Store itself is damaged — `DISM /Online /Cleanup-Image /RestoreHealth` must run first to repair it
- Results include three states: no violations found, violations found and repaired, or violations found but unable to repair
- SFC is relevant to the CySA+ objective of using built-in OS tools for system integrity verification during incident response

## Related concepts
[[Windows Resource Protection]] [[DISM]] [[File Integrity Monitoring]] [[Rootkit Detection]] [[Incident Response]]