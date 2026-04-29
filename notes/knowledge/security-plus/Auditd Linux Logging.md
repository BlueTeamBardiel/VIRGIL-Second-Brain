# Auditd Linux Logging

## What it is
Think of auditd as a courtroom stenographer permanently embedded inside the Linux kernel — it records every syscall, file touch, and login attempt before any process can lie about it. Auditd (the Linux Audit Daemon) is a userspace component that interfaces with the kernel's audit subsystem to capture security-relevant events and write them to `/var/log/audit/audit.log`. Rules define what gets recorded; the daemon ensures nothing slips through unlogged.

## Why it matters
During a post-breach forensic investigation, an attacker who deleted bash history and wiped application logs was still caught because auditd had recorded every `execve()` syscall — capturing the exact commands, timestamps, and UIDs used during lateral movement. Without auditd, the kernel-level trail simply doesn't exist, and defenders are left reconstructing an attack from silence.

## Key facts
- Auditd rules are configured in `/etc/audit/audit.rules` and loaded at boot; temporary rules can be added live with `auditctl`
- The `-w` flag watches a file/directory for access; `-a always,exit` flags monitor specific syscalls (e.g., `-a always,exit -F arch=b64 -S execve` captures all executed commands)
- `ausearch` queries audit logs by UID, time, or syscall; `aureport` generates human-readable summaries — both are exam-relevant tools
- Auditd can be locked into immutable mode (`auditctl -e 2`) so that rules cannot be changed without a reboot, preventing attacker tampering
- Log files are owned by root and written by the kernel subsystem directly, making them significantly harder to tamper with than application-level logs

## Related concepts
[[Linux File Permissions]] [[SIEM Log Ingestion]] [[Syslog and Rsyslog]] [[Forensic Chain of Custody]] [[SELinux]]