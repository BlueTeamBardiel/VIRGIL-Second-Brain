# Working with Commands

## What it is
Like a chef who can either read a recipe card (GUI) or call out orders verbally in a kitchen (CLI), working with commands means interacting directly with an operating system or tool through text-based instructions rather than menus. Precisely, it refers to issuing structured syntax-driven directives to shells, interpreters, or APIs to perform security tasks, automate workflows, and inspect system state.

## Why it matters
During incident response, a compromised Windows host may have its GUI locked or corrupted by malware — an analyst who can drop into PowerShell and run `Get-Process`, `netstat -ano`, or `Get-EventLog` can still triage the system and identify malicious processes. Attackers exploit this same capability through "living off the land" techniques, using built-in command interpreters like `cmd.exe` or `bash` to avoid triggering antivirus alerts tied to foreign executables.

## Key facts
- **Windows CLI triage commands:** `netstat -ano` (active connections with PIDs), `tasklist` (running processes), `ipconfig /all` (network config), `net user` (local accounts)
- **Linux equivalents:** `ss -tulnp`, `ps aux`, `ifconfig`/`ip a`, `who`, `last` for session and network forensics
- **PowerShell is dual-use:** Used legitimately for administration but abused via encoded Base64 commands (`powershell -enc`) to evade logging — a major CySA+ red flag
- **Command injection** is a critical vulnerability class (OWASP Top 10) where unsanitized user input is passed directly to a system shell, enabling attackers to execute arbitrary OS commands
- **SIEM and scripting:** Security analysts chain CLI tools with pipes (`|`) and scripts to automate log parsing, artifact collection, and alerting across thousands of events

## Related concepts
[[Command Injection]] [[PowerShell Logging]] [[Living Off the Land Attacks]] [[Incident Response Procedures]] [[Shell Scripting]]