# MITRE ATT&CK T1059.001

## What it is
Think of PowerShell like a master key that ships pre-installed on every Windows building — legitimate maintenance staff use it daily, but adversaries love stealing that same key. T1059.001 describes adversary abuse of PowerShell, Windows' native scripting engine, to execute malicious commands, download payloads, and interact with the OS while blending into normal administrative activity.

## Why it matters
During the 2020 SolarWinds supply chain attack, threat actors used PowerShell to execute encoded commands that staged SUNBURST malware and exfiltrated data — precisely because PowerShell traffic looked identical to routine IT operations. Defenders who had enabled PowerShell Script Block Logging caught the encoded payloads in Event Log 4104, demonstrating why logging configuration is a frontline defense.

## Key facts
- Attackers frequently use `-EncodedCommand` (Base64 encoding) and `-ExecutionPolicy Bypass` flags to evade basic script restrictions and run unsigned code
- PowerShell Constrained Language Mode (CLM) and AMSI (Antimalware Scan Interface) are Microsoft's primary built-in mitigations; AMSI passes script content to AV engines before execution
- Script Block Logging (Event ID 4104) and Module Logging capture decoded PowerShell commands, making them critical forensic artifacts for CySA+ scenarios
- PowerShell remoting (WinRM, port 5985/5986) enables lateral movement without dropping executables on disk — a key indicator during threat hunting
- "Living off the Land" (LotL) attacks favor PowerShell precisely because it's a signed, trusted Microsoft binary, bypassing application whitelisting

## Related concepts
[[AMSI]]
[[Living Off the Land Binaries (LOLBins)]]
[[PowerShell Script Block Logging]]
[[T1059 Command and Scripting Interpreter]]
[[Constrained Language Mode]]