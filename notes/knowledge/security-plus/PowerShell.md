# PowerShell

## What it is
Think of PowerShell as a Swiss Army knife that also happens to speak fluent Windows internals — it can open files, but it can also reach deep into the operating system's bloodstream. Precisely, PowerShell is a Microsoft task automation framework combining a command-line shell and scripting language built on .NET, giving administrators (and attackers) direct access to system APIs, the registry, WMI, and network resources.

## Why it matters
In the 2017 NotPetya outbreak and countless APT campaigns, attackers used PowerShell's `Invoke-Expression` and `DownloadString` methods to pull malware directly into memory — never touching disk, bypassing traditional antivirus entirely. This "fileless malware" technique makes PowerShell one of the most abused living-off-the-land binaries (LOLBins) in modern threat actor playbooks.

## Key facts
- **ExecutionPolicy** is not a security boundary — it can be bypassed with `-ExecutionPolicy Bypass` or encoding scripts in Base64, making it a user convenience, not a defense
- **PowerShell logging** (Module Logging, Script Block Logging, Transcription) must be explicitly enabled via Group Policy; disabled by default on older systems
- **AMSI (Antimalware Scan Interface)** allows security tools to inspect PowerShell script content before execution — attackers actively attempt to patch or disable it in memory
- **Constrained Language Mode (CLM)** restricts PowerShell to a safe subset of commands and is enforced by AppLocker or WDAC policies
- **PowerShell Remoting** uses WinRM over port 5985 (HTTP) or 5986 (HTTPS) and is a common lateral movement vector in enterprise environments

## Related concepts
[[Fileless Malware]] [[Living Off the Land (LOLBins)]] [[AMSI]] [[Windows Management Instrumentation (WMI)]] [[AppLocker]]