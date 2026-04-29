# CLI

## What it is
Think of the CLI like a direct phone line to the operating system's brain — no receptionist, no menus, just raw commands and immediate responses. The Command Line Interface (CLI) is a text-based interface that allows users to interact with an operating system or application by typing discrete commands, bypassing graphical abstractions entirely. It provides granular control over system processes, files, and network configurations.

## Why it matters
Attackers frequently abuse native CLI tools — a technique called Living off the Land (LotL) — using built-in utilities like `powershell.exe`, `cmd.exe`, or `bash` to execute malicious payloads without dropping suspicious binaries to disk. For defenders, monitoring CLI activity through tools like Windows Event ID 4688 (process creation) or Sysmon is a primary detection strategy for catching lateral movement and privilege escalation. A threat actor who compromises a low-privilege account can use CLI commands like `net user` and `whoami` to quietly enumerate the environment before escalating.

## Key facts
- PowerShell and cmd.exe are top attack vectors; defenders should log `ScriptBlockLogging` and `ModuleLogging` for PowerShell
- CLI commands can be obfuscated using encoding (e.g., `powershell -enc <Base64>`) to evade signature-based detection
- `netstat`, `ipconfig`, `arp`, and `route` are common CLI recon tools used by both admins and attackers
- Bash history files (`~/.bash_history`) and Windows command auditing (Event ID 4688) are forensic gold mines
- Restricting CLI access via AppLocker, WDAC, or sudo rules is a principle-of-least-privilege control

## Related concepts
[[PowerShell]] [[Living off the Land]] [[Event Logging]] [[Privilege Escalation]] [[AppLocker]]