# cron job

## What it is
Think of cron like a night-shift janitor who shows up every night at 2 AM to empty the trash — nobody watches him, but he has keys to every room. A cron job is a scheduled task on Unix/Linux systems managed by the `cron` daemon, executing scripts or commands automatically at defined intervals specified in a `crontab` file. The timing syntax uses five fields (minute, hour, day, month, weekday) to define the schedule.

## Why it matters
Attackers who gain a foothold on a Linux system frequently plant malicious cron jobs to establish persistence — for example, writing a reverse shell command into `/etc/cron.d/` that reconnects to a C2 server every five minutes, surviving reboots and manual process kills. Defenders monitor cron directories and the output of `crontab -l` for all users (including root) as a standard persistence-hunting technique during incident response. This is a textbook MITRE ATT&CK technique: T1053.003 (Scheduled Task/Job: Cron).

## Key facts
- Cron tables live in `/etc/crontab`, `/etc/cron.d/`, `/var/spool/cron/crontabs/`, and user-specific files edited via `crontab -e`
- Running `crontab -l` lists jobs for the current user; `sudo crontab -u root -l` checks root's jobs specifically
- World-writable scripts called by cron are a privilege escalation vector — an attacker edits the script, cron runs it as root
- The `@reboot` special string schedules a job to run once at system startup, a stealthy persistence mechanism
- Cron logs execution in `/var/log/syslog` or `/var/log/cron`, making log review critical for detection

## Related concepts
[[persistence mechanisms]] [[privilege escalation]] [[scheduled tasks]] [[MITRE ATT&CK]] [[least privilege]]