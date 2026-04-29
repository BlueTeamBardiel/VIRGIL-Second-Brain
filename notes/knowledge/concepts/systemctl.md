# systemctl

## What it is
Think of systemctl as the master switchboard operator for a Linux system — it decides which services get phone lines (start), which get disconnected (stop), and which automatically receive calls on boot (enable). Precisely, `systemctl` is the primary command-line interface for **systemd**, the init system and service manager used in most modern Linux distributions to control daemons, mount points, and system states.

## Why it matters
Attackers who gain a foothold on a Linux system frequently use `systemctl enable` to install **persistence mechanisms** — creating malicious `.service` unit files that survive reboots and auto-restart if killed. Defenders performing incident response must audit `systemctl list-units --type=service` and inspect `/etc/systemd/system/` for unexpected or obfuscated service names alongside legitimate-sounding ones (e.g., `systemd-networkd-helper.service`).

## Key facts
- `systemctl status <service>` reveals whether a service is **active, inactive, or failed** and shows recent log output — critical for triage
- `systemctl enable` creates a symlink in `/etc/systemd/system/` so a service starts at boot; `disable` removes it — **persistence lives here**
- Unit files are stored in `/lib/systemd/system/` (package-managed) and `/etc/systemd/system/` (admin/attacker-controlled) — the latter takes precedence
- `systemctl list-units --type=service --state=running` enumerates all currently running services — a baseline comparison reveals anomalies
- `systemctl isolate rescue.target` drops the system to single-user mode — useful in incident response to isolate a compromised host without full shutdown

## Related concepts
[[Linux Persistence Mechanisms]] [[Cron Jobs]] [[Service Hardening]] [[Privilege Escalation]] [[Log Analysis]]