# MITRE ATT&CK T1059.1

## What it is
Like a burglar using the building's own master key instead of breaking a window, attackers use PowerShell — Windows' built-in automation shell — to run malicious commands through a trusted, pre-installed tool. T1059.1 specifically covers adversary abuse of PowerShell for execution, including running encoded commands, downloading payloads, and spawning reverse shells.

## Why it matters
In the 2020 SolarWinds supply chain attack, threat actors used PowerShell scripts to execute SUNBURST backdoor commands and exfiltrate data — all while blending into normal IT administrative traffic. Defenders who lack PowerShell script block logging missed these activities entirely, demonstrating why logging `4104` events in the Windows Event Log is critical for detection.

## Key facts
- Attackers frequently use `-EncodedCommand` (Base64 encoding) to obfuscate malicious PowerShell payloads and bypass basic string-based detection
- PowerShell `DownloadString` and `Invoke-Expression (IEX)` are classic combo techniques for fileless malware — pulling and executing code entirely in memory
- **AMSI (Antimalware Scan Interface)** is Microsoft's native defense; attackers actively attempt to bypass or patch it in memory before running malicious scripts
- Enabling **Script Block Logging** (Event ID 4104), **Module Logging**, and **Transcription** are the three key PowerShell visibility controls for defenders
- PowerShell Constrained Language Mode (CLM) limits dangerous capabilities and is a practical hardening countermeasure

## Related concepts
[[Living Off the Land (LOLBins)]] [[Windows Script Host (T1059.5)]] [[AMSI Bypass Techniques]] [[Fileless Malware]] [[Defense Evasion]]