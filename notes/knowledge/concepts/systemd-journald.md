# systemd-journald

## What it is
Like a ship's black box that records everything from engine temperature to crew conversations, `systemd-journald` is the binary logging daemon in Linux systems that captures kernel messages, syslog output, stdout/stderr from services, and audit records into a structured, indexed journal. Unlike traditional text-based syslog, it stores logs in a binary format queryable via `journalctl`.

## Why it matters
During incident response on a compromised Linux host, an attacker who achieves root may attempt to tamper with or delete journal logs to cover their tracks — but because `journald` can forward logs to a remote `syslog` server in real time, defenders can preserve evidence even after local logs are wiped. Conversely, misconfigured persistence (logs stored only in `/run/log/journal/` rather than `/var/log/journal/`) means all logs vanish on reboot, creating an unintentional blind spot for forensic analysts.

## Key facts
- **Storage location**: Volatile logs live in `/run/log/journal/` (lost on reboot); persistent logs require `/var/log/journal/` to exist and `Storage=persistent` in `/etc/systemd/journald.conf`
- **Binary format**: Logs are not human-readable text files — `journalctl` is required to parse them, which means standard `grep`-based log tools won't work directly
- **Log forwarding**: `journald` can forward to a traditional syslog daemon (e.g., `rsyslog`) via `ForwardToSyslog=yes`, enabling SIEM ingestion
- **Rate limiting**: Built-in rate limiting (`RateLimitIntervalSec`, `RateLimitBurst`) can silently drop log entries under high-volume conditions — an attacker generating noise can cause legitimate events to be missed
- **Integrity**: Journal files include sealing/FSS (Forward Secure Sealing) to detect tampering, but this feature must be explicitly enabled

## Related concepts
[[Syslog Protocol]] [[Linux Audit Framework (auditd)]] [[Log Tampering and Anti-Forensics]] [[SIEM Log Ingestion]]