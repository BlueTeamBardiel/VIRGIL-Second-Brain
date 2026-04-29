# MITRE ATT&CK T1086 - PowerShell

## What it is
Think of PowerShell as a master key that was originally cut for the building's maintenance crew — legitimate, trusted, and capable of opening every door. Attackers abuse this same trusted key to execute malicious commands, download payloads, and move laterally without ever dropping a suspicious `.exe` on disk. T1086 documents adversary use of PowerShell as an execution and post-exploitation vehicle within Windows environments.

## Why it matters
In the 2017 NotPetya campaign and countless APT intrusions, attackers used PowerShell's `Invoke-Expression` (IEX) combined with `Net.WebClient.DownloadString()` to pull remote payloads entirely in memory — leaving minimal forensic artifacts on disk. Defenders who only monitor file writes would miss the attack entirely, making PowerShell logging and AMSI (Antimalware Scan Interface) integration critical detection controls.

## Key facts
- **Script Block Logging** (Event ID 4104) captures the full decoded content of PowerShell scripts, including obfuscated or Base64-encoded commands — the single most important detection control for this technique.
- PowerShell's `-ExecutionPolicy Bypass` and `-EncodedCommand` flags are commonly used to evade default restrictions and conceal intent; neither requires admin privileges.
- **Living-off-the-Land (LotL)** is the core attacker advantage — PowerShell is signed by Microsoft, whitelisted by default, and trusted by EDR tools.
- AMSI hooks PowerShell at runtime to scan content before execution, making it a key prevention layer even against fileless attacks.
- T1086 is now subsumed under **T1059.001** (Command and Scripting Interpreter: PowerShell) in ATT&CK v9+, but the original ID appears on many certification exams and older threat reports.

## Related concepts
[[Living-off-the-Land Attacks]] [[Windows Event Log Monitoring]] [[Antimalware Scan Interface (AMSI)]] [[Fileless Malware]] [[Execution Policy Bypass]]