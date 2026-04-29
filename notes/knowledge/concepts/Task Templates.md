# Task Templates

## What it is
Like a cookie cutter that stamps out identical shapes from dough, a task template is a pre-configured blueprint that defines what a scheduled or automated task should do, how it should run, and under what privileges. In Windows environments, Task Scheduler uses XML-based templates to define triggers, actions, conditions, and security contexts for recurring jobs.

## Why it matters
Attackers abuse task templates for persistence and privilege escalation — a technique catalogued as MITRE ATT&CK T1053.005. By dropping a malicious XML template into `C:\Windows\System32\Tasks\` or modifying an existing one, an adversary can schedule code execution under SYSTEM privileges that survives reboots without touching the registry run keys that defenders commonly monitor.

## Key facts
- Windows Task Scheduler templates are stored as XML files and can be imported/exported via `schtasks /create` or the Task Scheduler GUI — defenders should baseline these files for unauthorized changes
- Legitimate software frequently uses task templates for updates (e.g., Google Update, Windows Defender) — attackers clone these naming conventions to blend in (living-off-the-land)
- A task template specifies the **security principal** (user context), meaning a template configured to run as SYSTEM is a high-value target for modification
- `schtasks /query /fo LIST /v` reveals all scheduled tasks and their associated templates — a critical CySA+ enumeration command for threat hunting
- Fileless variants write the task template directly to the registry under `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks` rather than the filesystem, evading file-based detection

## Related concepts
[[Scheduled Tasks]] [[Privilege Escalation]] [[Persistence Mechanisms]] [[Living Off the Land]] [[Windows Registry]]