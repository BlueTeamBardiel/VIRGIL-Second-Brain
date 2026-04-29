# MITRE ATT&CK T1059.003

## What it is
Like a master key hidden in plain sight inside every Windows building, cmd.exe sits pre-installed on every Windows system, ready for anyone who finds the door. T1059.003 (Windows Command Shell) describes adversaries executing commands through `cmd.exe` to interact with the operating system, run scripts, launch processes, and chain attacks — leveraging a tool Windows itself trusts completely.

## Why it matters
During the 2020 SolarWinds supply chain attack, threat actors used cmd.exe to execute reconnaissance commands and move laterally after initial access via the SUNBURST backdoor. Defenders monitoring for anomalous `cmd.exe` spawned from unusual parent processes (like a web server or Office application) could detect this activity before significant damage occurred.

## Key facts
- T1059.003 is a sub-technique of T1059 (Command and Scripting Interpreter); the parent covers all scripting environments
- Attackers commonly invoke cmd.exe via `CreateProcess()` or through a parent process like `powershell.exe`, `wscript.exe`, or a compromised service
- Detection focus: parent-child process relationships — `cmd.exe` spawned by `svchost.exe` or `outlook.exe` is a high-fidelity alert
- Defenders use Windows Event ID **4688** (Process Creation) with command-line auditing enabled to log cmd.exe invocations
- Mitigation includes AppLocker or WDAC policies to restrict which users/processes can execute cmd.exe, and disabling it for non-administrative users where possible

## Related concepts
[[T1059.001 PowerShell]] [[T1059.005 Visual Basic]] [[Living off the Land Binaries (LOLBins)]] [[Windows Event ID 4688]] [[AppLocker]]