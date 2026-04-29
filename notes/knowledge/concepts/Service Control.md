# Service Control

## What it is
Think of service control like a bouncer at a club who doesn't just check IDs at the door, but can also kick people out mid-party, change the dress code in real time, and shut the whole venue down. Service control is the mechanism by which an operating system or administrator starts, stops, pauses, enables, disables, and configures background processes (services) that run independently of user sessions.

## Why it matters
During incident response, an attacker may install a malicious service (like a backdoor disguised as `svchost.exe`) to maintain persistence across reboots. A defender using `sc.exe` or PowerShell's `Set-Service` can disable and stop the rogue service immediately while forensic evidence is preserved — but only if they act before the attacker's service restarts itself via a watchdog process.

## Key facts
- **Windows `sc.exe`** is the primary command-line tool for service control; `sc query`, `sc stop`, and `sc config start= disabled` are critical incident response commands
- Services run under security contexts (LocalSystem, LocalService, NetworkService, or custom accounts) — privilege escalation often targets services running as SYSTEM
- **Unquoted service paths** are a classic misconfiguration where Windows searches for a service binary in unintended locations, allowing binary planting for privilege escalation
- In Linux, `systemctl stop/disable` (systemd) and `service` (SysV) are the equivalents; attackers target `/etc/systemd/system/` for persistence
- The principle of least privilege demands services run under accounts with minimal rights — violation is a common CySA+ exam scenario

## Related concepts
[[Privilege Escalation]] [[Persistence Mechanisms]] [[Principle of Least Privilege]]