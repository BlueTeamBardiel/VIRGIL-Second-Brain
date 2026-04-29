# Cron Jobs

## What it is
Like a restaurant prep cook who arrives at 5am every day without being asked — cron is a Unix/Linux time-based job scheduler that executes scripts or commands automatically at defined intervals. Configured through a crontab file using a five-field time syntax (minute, hour, day, month, weekday), it runs tasks without any human trigger.

## Why it matters
Attackers who gain a foothold on a Linux system frequently drop malicious scripts into `/etc/cron.d/` or edit a user's crontab to establish persistence — the malware re-executes every few minutes even if the original process is killed. During incident response, forensic analysts specifically audit crontab files and cron directories as one of the first persistence mechanism checks, making cron awareness critical for threat hunters.

## Key facts
- **Five cron directories to know:** `/etc/cron.hourly/`, `/etc/cron.daily/`, `/etc/cron.weekly/`, `/etc/cron.monthly/`, and `/etc/cron.d/` — all prime locations for malicious persistence
- **Crontab syntax:** `* * * * * /path/to/command` — the five asterisks represent minute (0-59), hour (0-23), day of month (1-31), month (1-12), and day of week (0-7)
- **Privilege escalation vector:** If a root-owned cron job calls a script that is world-writable, an attacker can overwrite that script to execute arbitrary code as root
- **Detection signal:** Unexpected entries in `/var/spool/cron/crontabs/` or new files in cron directories are high-fidelity indicators of compromise (IOC)
- **Windows equivalent:** Scheduled Tasks (`schtasks`) mirrors cron functionality and is abused identically for persistence in Windows environments

## Related concepts
[[Persistence Mechanisms]] [[Privilege Escalation]] [[Scheduled Tasks]] [[Linux File Permissions]] [[Indicator of Compromise]]