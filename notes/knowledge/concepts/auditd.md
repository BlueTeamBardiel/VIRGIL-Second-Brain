# auditd

## What it is
Think of auditd as a courthouse stenographer who records every single action taken inside a Linux system — who opened what file, which user ran which command, every failed login — creating a verbatim transcript that can't easily be altered. Precisely, auditd is the Linux Audit Daemon, a kernel-level subsystem that intercepts and logs system calls, file access events, and security-relevant actions to `/var/log/audit/audit.log`. Rules are defined in `/etc/audit/audit.rules` to specify exactly what gets recorded.

## Why it matters
During incident response on a compromised Linux server, investigators used auditd logs to reconstruct exactly how an attacker escalated privileges — the logs showed the precise moment a SUID binary was exploited and a root shell was spawned, timestamped to the millisecond. Without auditd pre-configured, that forensic trail would have been completely invisible, and the attack vector would have remained unknown.

## Key facts
- **`auditctl`** is the command-line tool used to add, remove, and list audit rules in real time without restarting the daemon
- Audit rules use the `-w` (watch) flag for file/directory monitoring and `-a` (append rule) for syscall auditing; e.g., `-w /etc/passwd -p wa` watches for writes and attribute changes to `/etc/passwd`
- **`ausearch`** and **`aureport`** are companion tools for querying and summarizing audit logs by event type, user, or time range
- auditd operates at the **kernel level** — it cannot be bypassed by user-space rootkits the way application-level logging can
- Immutable mode (`-e 2` in audit rules) locks the audit configuration until reboot, preventing an attacker with root from disabling logging

## Related concepts
[[Security Information and Event Management (SIEM)]] [[Linux File Permissions]] [[Log Management]] [[Incident Response]] [[Privilege Escalation]]