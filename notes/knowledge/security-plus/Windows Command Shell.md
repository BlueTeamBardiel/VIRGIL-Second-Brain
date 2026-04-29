# Windows Command Shell

## What it is
Think of it as a direct telephone line to the operating system's engine room — no graphical middleman, just raw instructions and immediate responses. CMD (cmd.exe) is the legacy command-line interpreter built into Windows, providing direct access to the OS kernel through text-based commands. It executes batch scripts (.bat/.cmd), runs system utilities, and manages processes, files, and network configurations.

## Why it matters
Attackers frequently abuse cmd.exe as a post-exploitation tool because it's present on every Windows system and can be invoked remotely through WMI, PsExec, or compromised services. In the 2020 SolarWinds attack, threat actors used cmd.exe spawned as a child process of legitimate software to execute reconnaissance commands, a pattern defenders now flag as a high-fidelity detection signal. Blue teams monitor for suspicious parent-child process relationships — like a web server spawning cmd.exe — as a core endpoint detection rule.

## Key facts
- **LOLBin context**: cmd.exe is a "Living off the Land" binary — attackers use it to avoid dropping custom malware, making it harder to detect via traditional signature scanning
- **MITRE ATT&CK T1059.003**: Windows Command Shell is specifically catalogued under the Command and Scripting Interpreter technique
- **Obfuscation risk**: Attackers use cmd.exe features like `^` (caret escaping) and environment variable substitution to obfuscate malicious commands from log analysis
- **Audit trail**: Windows Event ID 4688 (Process Creation) logs cmd.exe execution when command-line auditing is enabled — critical for forensic investigation
- **Restricted by policy**: AppLocker and Software Restriction Policies can block or restrict cmd.exe execution, a common hardening control in CIS Benchmarks

## Related concepts
[[PowerShell Scripting]] [[LOLBins]] [[MITRE ATT&CK Framework]] [[Process Injection]] [[Windows Event Logging]]