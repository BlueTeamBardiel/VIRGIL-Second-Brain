# WSL

## What it is
Like running a Linux brain inside a Windows body — same hardware, two personalities sharing the same house. Windows Subsystem for Linux (WSL) is a compatibility layer built into Windows 10/11 that lets users run a full Linux environment (including a real kernel in WSL2) natively, without a virtual machine or dual-boot.

## Why it matters
Attackers increasingly abuse WSL to execute Linux-native malware (ELF binaries) that completely bypasses Windows Defender and most EDR solutions, which are tuned to scan PE/EXE files, not ELF binaries. In documented campaigns, threat actors have deployed reverse shells packaged as ELF executables inside WSL, escaping traditional Windows AV detection while still having full access to the Windows filesystem via `/mnt/c/`. Blue teamers must explicitly configure EDR tools to monitor WSL process trees (particularly `wsl.exe` spawning child processes) to catch this technique.

## Key facts
- **WSL2 uses a real Linux kernel** running in a lightweight Hyper-V utility VM — this is architecturally different from WSL1's syscall translation layer
- **Defense evasion technique**: ELF binaries run under WSL are largely invisible to Windows AV engines that only scan PE-format executables
- **Filesystem bridge**: WSL can read/write the Windows filesystem at `/mnt/c/`, meaning malware in WSL can exfiltrate or modify Windows files freely
- **Detection pivot**: Monitoring for `wsl.exe`, `bash.exe`, and unexpected child processes in Windows Event Logs (Event ID 4688) is a key blue-team indicator
- **Feature can be disabled**: Group Policy and DISM can block WSL installation — organizations with no Linux dev need should disable it as an attack surface reduction measure

## Related concepts
[[Living off the Land (LotL)]] [[Defense Evasion]] [[Attack Surface Reduction]] [[Endpoint Detection and Response (EDR)]] [[Windows Event Logging]]