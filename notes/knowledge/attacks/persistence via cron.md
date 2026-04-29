# persistence via cron

## What it is
Like a sleeper agent who checks a dead drop every night at midnight, cron is a Unix/Linux time-based job scheduler that runs commands automatically at defined intervals. Attackers abuse cron by inserting malicious entries into crontab files, ensuring their payload re-executes even after reboots or manual process kills — achieving persistence without touching startup scripts.

## Why it matters
During the 2014 Operation Windigo campaign, attackers compromised over 25,000 Linux servers and used cron jobs to periodically re-download and execute malware, making eradication extremely difficult — removing the running process alone was insufficient because the cron entry simply respawned it within minutes. Defenders learned to audit crontab files alongside process inspection during incident response.

## Key facts
- Crontab files exist in multiple locations: per-user files via `crontab -e`, system-wide `/etc/crontab`, and drop-in directories `/etc/cron.d/`, `/etc/cron.daily/`, `/etc/cron.hourly/`, etc. — all must be checked during forensics
- Attackers often hide malicious entries using obfuscated command strings, base64-encoded payloads, or by appending to legitimate-looking cron files to blend in
- MITRE ATT&CK maps this technique to **T1053.003** (Scheduled Task/Job: Cron) under the Persistence and Privilege Escalation tactics
- Root-level cron jobs (in `/etc/crontab` or root's crontab) can execute with full system privileges — an attacker with a brief root access window can plant long-term control
- Detection relies on monitoring crontab file modifications via file integrity monitoring (FIM) tools like AIDE or auditd rules watching `/var/spool/cron/`

## Related concepts
[[scheduled task persistence]] [[fileless malware]] [[privilege escalation]] [[file integrity monitoring]] [[MITRE ATT&CK T1053]]