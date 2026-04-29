# At.exe

## What it is
Think of it like leaving a sticky note on a coworker's desk that says "run this program at 3am" — except the coworker is Windows itself. `At.exe` is a legacy Windows command-line utility that schedules tasks to run at a specified time, functioning as the predecessor to the modern Task Scheduler (`schtasks.exe`).

## Why it matters
Attackers use `at.exe` for persistence and lateral movement — after gaining initial access, they can schedule a malicious payload to execute repeatedly or at a specific time, surviving reboots without touching common autoruns. In the MITRE ATT&CK framework, this technique falls under **T1053.002 (Scheduled Task/Job: At)**. Defenders hunting for abuse look for unexpected `at.exe` entries or processes spawned by the `Task Scheduler` service from unusual directories.

## Key facts
- **Deprecated but present**: `At.exe` is deprecated since Windows 8/Server 2012, but remains on many systems for backward compatibility — making it an attractive living-off-the-land binary (LOLBin).
- **Requires elevated privileges**: Running `at.exe` requires local Administrator rights, so its use often signals prior privilege escalation.
- **Runs as SYSTEM**: Jobs scheduled via `at.exe` execute under the SYSTEM account by default — immediately granting maximum local privilege to the payload.
- **No GUI, less visibility**: Unlike Task Scheduler, `at.exe` jobs don't always appear prominently in the graphical Task Scheduler interface, aiding attacker evasion.
- **Detection artifact**: Scheduled jobs appear in the registry under `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache` and in `C:\Windows\System32\Tasks`.

## Related concepts
[[Scheduled Tasks]] [[Living Off the Land Binaries (LOLBins)]] [[Persistence Mechanisms]] [[Privilege Escalation]] [[MITRE ATT&CK T1053]]