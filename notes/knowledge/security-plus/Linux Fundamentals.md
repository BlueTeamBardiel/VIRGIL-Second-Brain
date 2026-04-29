# Linux Fundamentals

## What it is
Think of Linux like a transparent glass-walled house — unlike Windows, you can see every pipe, wire, and support beam if you know where to look. Linux is an open-source, Unix-based operating system kernel that underlies the majority of servers, cloud infrastructure, and security tooling in enterprise environments, managed through a command-line interface and a hierarchical file system.

## Why it matters
During the 2021 Kaseya VSA ransomware attack, threat actors specifically targeted Linux-based backend servers to maximize infrastructure damage before defenders could respond. Defenders who understood Linux process management and log locations (`/var/log/syslog`, `/var/log/auth.log`) were able to identify lateral movement artifacts that Windows-focused analysts initially missed.

## Key facts
- **File permissions** use octal notation (e.g., `chmod 755`) and the rwx model — misconfigurations like world-writable files (`777`) are a primary privilege escalation vector
- **SUID/SGID bits** allow executables to run as the file owner (often root), making them high-value targets; find them with `find / -perm -4000 2>/dev/null`
- **Critical log files**: `/var/log/auth.log` tracks authentication attempts; `/etc/passwd` and `/etc/shadow` store user credentials (shadow is root-readable only)
- **Cron jobs** (`/etc/crontab`, `/var/spool/cron`) are frequently abused for persistence — a common CySA+ exam scenario involves identifying a malicious scheduled task
- **Linux namespaces and cgroups** form the backbone of container security (Docker/Kubernetes), meaning Linux misconfigurations cascade into cloud security failures

## Related concepts
[[Privilege Escalation]] [[File System Permissions]] [[Log Analysis]] [[Cron Job Abuse]] [[Container Security]]