# T1059 - Command and Scripting Interpreter

## What it is
Like a master key that opens every door in a building, scripting interpreters give attackers native access to an entire operating system through its own trusted tools. T1059 describes adversaries using built-in command-line interfaces and scripting environments — PowerShell, Bash, Python, cmd.exe, VBScript — to execute malicious commands, often blending invisibly with legitimate administrative activity.

## Why it matters
In the 2020 SolarWinds supply chain attack, threat actors used PowerShell to execute encoded payloads and move laterally across compromised networks, specifically because PowerShell is trusted, logged inconsistently, and rarely blocked by defenders. Detecting this requires enabling PowerShell Script Block Logging and monitoring for Base64-encoded command strings — a direct CySA+ defensive control.

## Key facts
- **Sub-techniques matter**: T1059 has 9 sub-techniques including T1059.001 (PowerShell), T1059.003 (Windows Command Shell), and T1059.007 (JavaScript), each requiring different detection signatures
- **LOLBins connection**: Attackers favor interpreters because they are "Living Off the Land" — using trusted, whitelisted binaries that bypass application control policies
- **Obfuscation is common**: PowerShell payloads are frequently Base64-encoded or use character substitution to evade signature-based detection
- **Detection via logging**: Windows Event ID 4104 captures PowerShell script block content; Event ID 4688 logs process creation including command-line arguments
- **AMSI (Antimalware Scan Interface)** was introduced specifically to inspect scripts at runtime before execution, making it a primary defense against T1059 variants

## Related concepts
[[Living Off the Land Binaries (LOLBins)]] [[PowerShell Logging and AMSI]] [[Defense Evasion T1027 - Obfuscated Files]] [[Application Whitelisting]] [[Windows Event Log Monitoring]]