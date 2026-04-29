# Windows Scheduled Tasks

## What it is
Think of it like a building's automated thermostat — it triggers actions at preset times without anyone touching the controls. Windows Scheduled Tasks (managed via the Task Scheduler service) allow programs, scripts, or commands to execute automatically based on time triggers, system events, or user logon conditions.

## Why it matters
Attackers love scheduled tasks because they survive reboots — making them one of the most common persistence mechanisms found during incident response. A threat actor who compromises a system might create a task named `WindowsUpdateHelper` that calls back to a C2 server every 30 minutes, blending into legitimate-looking scheduled activity. Blue teamers hunting persistence should always audit `schtasks /query /fo LIST /v` and compare against known-good baselines.

## Key facts
- **MITRE ATT&CK T1053.005**: Scheduled Task/Job is a well-documented persistence and privilege escalation technique used by APTs including FIN7 and Lazarus Group
- Tasks are stored as XML files in `C:\Windows\System32\Tasks\` and in the registry under `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache`
- Malicious tasks often run under **SYSTEM** privileges, enabling privilege escalation if an attacker can modify or create tasks
- The command `schtasks /create` requires Administrator rights by default, but attackers with local admin access can weaponize this instantly
- Legitimate tasks run by `svchost.exe` hosting the Task Scheduler service (`taskeng.exe` on older systems) — unusual parent-child process relationships here are red flags

## Related concepts
[[Persistence Mechanisms]] [[Privilege Escalation]] [[MITRE ATT&CK Framework]] [[Windows Registry]] [[Living off the Land Binaries]]