# Tasks

## What it is
Like a sticky note on a chef's station telling them exactly what to prep next, a **task** in Windows is a scheduled unit of work the OS executes automatically at a defined trigger — a time, event, or condition. Precisely: Windows Task Scheduler manages these as XML-defined jobs stored in `C:\Windows\System32\Tasks`, running processes under specified user contexts.

## Why it matters
Attackers use scheduled tasks as a classic persistence mechanism — after gaining initial access, they create a task that re-executes their malware every time the system boots or a user logs in. In the 2020 SolarWinds campaign, adversaries leveraged scheduled tasks to maintain persistence and execute payloads even after reboots, making detection harder because tasks blend into normal system operations.

## Key facts
- **MITRE ATT&CK T1053.005** specifically catalogs Scheduled Task/Job abuse as a persistence and privilege escalation technique on Windows systems.
- Tasks can run as **SYSTEM**, making them a privilege escalation vector if an attacker can hijack a task's binary path (binary planting/DLL hijacking).
- The command `schtasks /query /fo LIST /v` enumerates all scheduled tasks — a critical command for both attackers during recon and defenders during incident response.
- Malicious tasks often disguise themselves with names mimicking legitimate ones (e.g., `MicrosoftEdgeUpdateTaskMachineCore`) to evade manual inspection.
- Task definitions are stored as **XML files** and can also be found under the registry key `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks`.

## Related concepts
[[Persistence Mechanisms]] [[Privilege Escalation]] [[Windows Registry]] [[MITRE ATT&CK Framework]] [[Autoruns and Startup Items]]