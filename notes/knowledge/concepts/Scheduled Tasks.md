# scheduled tasks

## What it is
Like a building's automated sprinkler system that fires at 2 AM every night whether anyone is watching or not, scheduled tasks are instructions registered with the OS to execute programs or scripts automatically at defined times or trigger conditions. On Windows, the Task Scheduler service manages these jobs; Linux equivalents are cron jobs and systemd timers.

## Why it matters
Attackers love scheduled tasks for persistence: after gaining initial access, they register a malicious task to re-execute a backdoor every 15 minutes, surviving reboots and even manual process kills. APT29 (Cozy Bear) has used this technique extensively — planting tasks that masquerade as legitimate Windows maintenance jobs to maintain long-term footholds in compromised environments.

## Key facts
- **MITRE ATT&CK T1053** covers scheduled task/job abuse as a persistence and privilege escalation technique on Windows, Linux, and macOS
- Windows tasks are stored in `C:\Windows\System32\Tasks\` and can be inspected with `schtasks /query /fo LIST /v` or the Task Scheduler GUI
- Attackers can create tasks requiring SYSTEM-level privileges, achieving privilege escalation if the scheduled binary is writable (DLL hijacking opportunity)
- Defenders should baseline legitimate scheduled tasks immediately after deployment; any new task created outside a change window is a high-fidelity IOC
- On Linux, user crontabs live in `/var/spool/cron/` while system-wide jobs are in `/etc/cron.d/` and `/etc/crontab` — both must be audited

## Related concepts
[[persistence mechanisms]] [[privilege escalation]] [[living off the land]] [[MITRE ATT&CK]] [[cron jobs]]