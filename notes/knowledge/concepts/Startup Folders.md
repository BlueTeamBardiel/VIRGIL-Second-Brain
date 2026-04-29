# Startup Folders

## What it is
Think of startup folders like a restaurant's morning prep list — anything written on it gets executed automatically before the doors open, no questions asked. Precisely, startup folders are special OS directories (on Windows: `C:\Users\<user>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup` and the all-users equivalent under `ProgramData`) whose contents are automatically launched when a user logs in or the system boots.

## Why it matters
Attackers frequently abuse startup folders to achieve **persistence** — placing a malicious script or executable there ensures their payload survives reboots without touching the registry or requiring elevated privileges for the user-specific folder. In the 2016 DNC breach, adversaries used multiple persistence mechanisms including startup folder drops to maintain long-term access across reboots while evading detection.

## Key facts
- **Two scope levels**: Per-user startup folder (requires only user privileges) vs. all-users startup folder (requires administrator privileges) — attackers choose based on their current access level.
- **MITRE ATT&CK T1547.001**: Startup folder abuse is classified under Boot or Logon Autostart Execution, a core persistence technique.
- **Detection artifact**: Blue teamers monitor `%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup` and `%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup` for unexpected files.
- **Common payload types dropped**: `.lnk` (shortcut) files, `.bat` scripts, and `.exe` binaries — LNK files are particularly stealthy as they can point to legitimate binaries while passing malicious arguments.
- **Defense**: Application control policies (e.g., AppLocker) and endpoint monitoring tools (Sysmon Event ID 11) can alert on new file creation within startup directories.

## Related concepts
[[Registry Run Keys]] [[Persistence Mechanisms]] [[Living off the Land Binaries]] [[Windows Autostart Locations]] [[Privilege Escalation]]