# Task Scheduler

## What it is
Like a restaurant prep cook who arrives before anyone else to chop vegetables before service begins, Task Scheduler is Windows' built-in automation engine that executes programs or scripts at predefined times or triggering events — without requiring a logged-in user. It manages scheduled tasks through the `svchost.exe`-hosted `Schedule` service, storing task definitions as XML files under `C:\Windows\System32\Tasks\`.

## Why it matters
Attackers abuse Task Scheduler as a **persistence mechanism**: after initial compromise, malware creates a scheduled task that re-executes a dropper every time the system boots, surviving reboots and even user account password changes. APT groups like APT29 have used this exact technique (MITRE ATT&CK T1053.005) to maintain footholds in enterprise environments long after the initial intrusion vector was patched.

## Key facts
- Scheduled tasks run under specified user contexts — SYSTEM-level tasks are especially dangerous because they execute with maximum privileges regardless of who is logged in
- Task definitions live in `C:\Windows\System32\Tasks\` and the registry at `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\`
- The command-line tool `schtasks.exe` and PowerShell's `Register-ScheduledTask` cmdlet are common attacker tools for creating malicious tasks
- Defenders should audit tasks using `schtasks /query /fo LIST /v` and look for tasks with suspicious binary paths, random names, or entries in unusual directories like `%APPDATA%` or `%TEMP%`
- Task Scheduler is classified under **MITRE ATT&CK T1053: Scheduled Task/Job**, a Persistence and Privilege Escalation tactic

## Related concepts
[[Persistence Mechanisms]] [[Privilege Escalation]] [[Windows Registry]] [[Living off the Land Binaries (LOLBins)]] [[MITRE ATT&CK Framework]]