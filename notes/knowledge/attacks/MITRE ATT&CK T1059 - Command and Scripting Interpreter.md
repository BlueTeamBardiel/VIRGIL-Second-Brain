# MITRE ATT&CK T1059 - Command and Scripting Interpreter

## What it is
Think of it like a contractor using a building's own master key to unlock every room — attackers abuse legitimate scripting environments already present on a system to execute malicious commands. T1059 describes adversary use of built-in command-line interfaces and scripting engines (PowerShell, Bash, Python, cmd.exe, WScript) to run attacker-controlled code, avoiding the need to drop external executables.

## Why it matters
In the 2020 SolarWinds supply chain attack, threat actors used PowerShell (T1059.001) to execute encoded commands that established backdoor persistence and exfiltrated data — all while appearing as routine administrative activity. Defenders who monitored only for unknown executables completely missed the attack because every tool used was native to Windows.

## Key facts
- T1059 is consistently one of the **top five most observed ATT&CK techniques** in real-world incident reports, appearing in roughly 40% of documented intrusions
- Sub-techniques include: **.001 PowerShell**, **.002 AppleScript**, **.003 Windows Command Shell**, **.004 Unix Shell**, **.005 Visual Basic**, **.006 Python**, **.007 JavaScript**
- PowerShell's `-EncodedCommand` flag is a red-flag indicator — it Base64-encodes commands to evade simple string-matching detection
- **AMSI (Antimalware Scan Interface)** was specifically built by Microsoft to inspect in-memory script content before execution, directly countering this technique
- Detection focus: command-line argument logging (Windows Event ID **4104** for PowerShell script block logging) is the primary forensic source

## Related concepts
[[Living Off the Land (LOLBins)]] [[PowerShell Logging and AMSI]] [[Windows Event Log Monitoring]] [[Obfuscation Techniques]] [[Execution Tactic (MITRE ATT&CK TA0002)]]