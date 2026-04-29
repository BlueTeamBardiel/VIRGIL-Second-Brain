# startup folder

## What it is
Think of it like a "to-do list" taped to the inside of a front door — whatever's on it gets executed automatically the moment someone walks in (logs on). Precisely, the Windows Startup Folder is a special directory (`%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup` per-user, or `%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup` system-wide) where any shortcut or executable placed inside will automatically run when a user logs into Windows.

## Why it matters
Attackers use the Startup Folder as a classic persistence mechanism — after initial compromise, they drop a malicious payload or shortcut into the folder so their backdoor relaunches every time the victim logs in, surviving reboots without touching the registry. Defenders hunting for persistence (as in CySA+ incident response scenarios) specifically audit this folder alongside registry Run keys to detect implants left by malware like Agent Tesla or commodity RATs.

## Key facts
- **Two scope levels:** per-user (`APPDATA`) executes only for one account; system-wide (`ProgramData`) executes for *all* users — attackers prefer the latter for broader impact.
- **MITRE ATT&CK T1547.001** covers Boot/Logon Autostart Execution via Startup Folders as a recognized persistence technique.
- Items placed here run in the context of the logged-on user, meaning privilege level matters — system-wide placement doesn't grant SYSTEM privileges automatically.
- Legitimate software (Slack, OneDrive) commonly populates the user-level folder, making malicious entries easy to camouflage.
- Monitoring tools like Autoruns (Sysinternals) and EDR solutions flag unexpected entries in both startup folder locations during threat hunting.

## Related concepts
[[persistence mechanisms]] [[registry Run keys]] [[privilege escalation]] [[MITRE ATT&CK]] [[autoruns]]