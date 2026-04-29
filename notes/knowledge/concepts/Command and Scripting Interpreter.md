# Command and Scripting Interpreter

## What it is
Think of a scripting interpreter like a bilingual translator standing between you and the operating system — you hand it a script written in human-friendly language, and it converts each line into machine actions in real time. Precisely, a Command and Scripting Interpreter is any program (PowerShell, Bash, Python, cmd.exe, etc.) that executes instructions written in a scripting or command language without requiring prior compilation. MITRE ATT&CK catalogs abuse of these interpreters as Technique T1059, one of the most commonly observed techniques in real-world intrusions.

## Why it matters
During the 2020 SolarWinds attack, adversaries used PowerShell scripts executed via legitimate interpreter processes to blend malicious activity into normal administrative traffic, making detection extraordinarily difficult. Defenders responded by enabling PowerShell Script Block Logging and Constrained Language Mode to limit what attackers could execute, illustrating that the interpreter itself becomes a critical chokepoint for both attackers and defenders.

## Key facts
- **T1059** is one of the top-ranked techniques in MITRE ATT&CK frequency rankings, appearing in the majority of ransomware and APT campaigns.
- **Living-off-the-land (LotL)** attacks exploit built-in interpreters like PowerShell and WMI so no additional malware binary needs to touch disk, evading signature-based AV.
- **PowerShell Constrained Language Mode** restricts access to .NET types and COM objects, significantly limiting attacker capabilities without disabling the interpreter entirely.
- **AMSI (Antimalware Scan Interface)** allows security products to inspect scripts at runtime inside the interpreter before execution — a key defensive control tested on CySA+.
- Disabling or downgrading PowerShell to version 2 (which bypasses AMSI) is a documented attacker evasion technique — monitoring for `powershell -version 2` invocations is a detection signal.

## Related concepts
[[Living Off the Land]] [[PowerShell Logging]] [[AMSI]] [[WMI Abuse]] [[Fileless Malware]]