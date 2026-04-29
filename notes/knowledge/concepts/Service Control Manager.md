# Service Control Manager

## What it is
Think of the SCM as the head of HR for Windows background processes — it hires, fires, monitors, and restarts workers (services) according to their job descriptions. Technically, it is a core Windows component (`services.exe`) responsible for starting, stopping, pausing, and configuring system services and device drivers at boot and during runtime.

## Why it matters
Attackers frequently abuse the SCM to achieve persistence and privilege escalation. The classic technique is creating or modifying a Windows service via `sc.exe` or the SCM API to execute a malicious payload at startup under SYSTEM privileges — a technique heavily used in tools like Metasploit's `exploit/windows/local/service_permissions` and documented as MITRE ATT&CK T1543.003. Defenders monitor SCM event logs (Event IDs 7045 and 7036) to detect new or modified services as indicators of compromise.

## Key facts
- SCM runs as `services.exe` under SYSTEM context; compromising it or abusing its API grants high-privilege code execution
- **Event ID 7045** logs newly installed services — a critical detection point for malicious service installation
- Services can be configured with four failure recovery actions: restart the service, run a program, reboot the computer, or take no action — attackers exploit the "run a program" option for persistence
- The SCM database is stored in the registry at `HKLM\SYSTEM\CurrentControlSet\Services`
- Insecure service permissions (weak ACLs on service binaries or registry keys) are a common local privilege escalation vector exploitable with tools like PowerUp or WinPEAS

## Related concepts
[[Windows Registry]] [[Privilege Escalation]] [[Persistence Mechanisms]] [[Windows Event Logs]] [[MITRE ATT&CK]]