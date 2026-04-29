# Cron

## What it is
Like a ship's log that automatically records entries at fixed intervals without anyone touching the wheel, cron is a Unix/Linux time-based job scheduler that executes commands or scripts at predefined times. It reads scheduling instructions from configuration files called crontabs (`/etc/crontab`, `/var/spool/cron/`) and runs tasks with the permissions of the owning user.

## Why it matters
Attackers who gain initial foothold on a Linux system frequently plant malicious cron jobs to establish **persistence** — scheduling a reverse shell to beacon home every five minutes even after a reboot. A defender performing incident response should treat `/etc/cron.d/`, `/etc/cron.daily/`, and individual user crontabs as prime locations to hunt for indicators of compromise, since attackers often hide entries among legitimate scheduled tasks.

## Key facts
- Crontab syntax follows five time fields: `minute hour day-of-month month day-of-week` followed by the command (mnemonic: *"My Hamster Doesn't Move Quietly"*)
- The `cron.d` directory and `/etc/cron.daily|weekly|monthly` directories allow system-wide job definitions separate from user crontabs
- Running `crontab -l` lists jobs for the current user; `sudo crontab -u root -l` reveals root's scheduled tasks during forensic review
- World-writable scripts called by root cron jobs are a classic **privilege escalation** vector — an attacker modifies the script, root executes it
- On systemd-based systems, **systemd timers** are increasingly replacing cron but cron remains heavily tested and widely deployed in enterprise environments

## Related concepts
[[Persistence (MITRE ATT&CK)]] [[Privilege Escalation]] [[Linux File Permissions]] [[Scheduled Tasks]] [[Incident Response]]