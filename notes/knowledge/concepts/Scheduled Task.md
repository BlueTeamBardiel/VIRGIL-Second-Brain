# Scheduled Task

## What it is
Like a restaurant's prep cook who arrives before anyone else to get things ready, a scheduled task is a job pre-programmed to run automatically at a specific time or trigger — without anyone clicking "go." In Windows environments, the Task Scheduler service manages these jobs, while Linux uses cron. Attackers abuse this mechanism to ensure their malicious code survives reboots and runs with minimal interaction.

## Why it matters
APT groups frequently plant scheduled tasks as a persistence mechanism after initial compromise. For example, after gaining a foothold via phishing, an attacker may create a task that re-executes a PowerShell payload every 15 minutes, meaning even if a defender kills the malicious process, it respawns automatically — making detection and remediation significantly harder without examining the task registry.

## Key facts
- **MITRE ATT&CK T1053** classifies Scheduled Task/Job as a persistence and privilege escalation technique
- Windows stores scheduled tasks in `C:\Windows\System32\Tasks\` and the registry under `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache`
- Attackers commonly use `schtasks.exe` (command-line) or the COM API to create tasks that blend in with legitimate system jobs
- Tasks can run under `SYSTEM` privileges if created by an admin, enabling **privilege escalation** from a lower-privileged initial foothold
- Linux `cron` persistence uses files in `/etc/cron.*` directories or `/var/spool/cron/crontabs/` — both are common blue-team hunting targets
- Detection focus: look for tasks pointing to `%TEMP%`, `AppData`, or encoded PowerShell commands — these are high-fidelity red flags

## Related concepts
[[Persistence Mechanisms]] [[Privilege Escalation]] [[Living Off the Land Binaries (LOLBins)]] [[PowerShell Abuse]] [[MITRE ATT&CK Framework]]