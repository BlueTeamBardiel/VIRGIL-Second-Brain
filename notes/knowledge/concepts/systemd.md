# systemd

## What it is
Think of systemd as the head chef of a restaurant kitchen — it decides what gets cooked, in what order, and fires staff who don't show up on time. Precisely, systemd is the init system and service manager used by most modern Linux distributions, responsible for bootstrapping userspace, managing system services (units), and handling logging via journald. It replaces the older SysV init and controls virtually everything that starts when Linux boots.

## Why it matters
Attackers frequently abuse systemd for persistence by dropping malicious `.service` files into `/etc/systemd/system/` or user-level paths like `~/.config/systemd/user/`, ensuring their payload survives reboots without touching cron or rc.local. Defenders hunting for persistence should audit enabled service units with `systemctl list-units --type=service` and compare against known-good baselines, as rogue services are a common post-exploitation foothold in Linux environments.

## Key facts
- **Unit files** define services, timers, sockets, and mounts — each lives in `/etc/systemd/system/`, `/lib/systemd/system/`, or user-scope directories
- **Timers** (`.timer` units) are a direct cron alternative and are frequently overlooked during incident response; list them with `systemctl list-timers`
- **journald** centralizes logs; `journalctl -u <service>` retrieves service-specific logs, critical for forensic analysis
- **Privilege escalation** vectors include writable unit files or misconfigured `ExecStart` paths that run as root — a common GTFOBins-adjacent finding
- User-level systemd services run without root and persist under `~/.config/systemd/user/`, making them stealthy persistence locations that survive user logins

## Related concepts
[[Linux Persistence Mechanisms]] [[Privilege Escalation]] [[Log Management]] [[Cron Jobs]] [[Boot Process Security]]