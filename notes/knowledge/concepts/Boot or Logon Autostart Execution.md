# Boot or Logon Autostart Execution

## What it is
Like a valet who slips a note into your jacket pocket so it's read every morning when you get dressed, autostart execution plants code in locations the OS automatically reads during startup or login. Precisely, it is a persistence technique (MITRE ATT&CK T1547) where adversaries configure malicious programs to execute automatically whenever the system boots or a user logs in, ensuring survival across reboots without requiring re-exploitation.

## Why it matters
The Emotet malware family heavily abused Windows Registry Run keys (`HKCU\Software\Microsoft\Windows\Run`) to persist on millions of endpoints — every time a user logged in, Emotet quietly reloaded itself before any analyst noticed. Defenders hunting this technique monitor registry autorun locations and startup folders using tools like Autoruns (Sysinternals) or EDR telemetry to catch entries that don't match known-good baselines.

## Key facts
- **Common Windows locations**: Registry Run/RunOnce keys, `%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup`, Winlogon keys, and scheduled tasks set to trigger at logon
- **Linux equivalents**: `/etc/rc.local`, systemd service unit files, cron `@reboot` entries, and shell profile files (`.bashrc`, `.profile`)
- **Sub-techniques include**: Registry Run Keys, Shortcut modification, Port Monitors, Time Providers, and Winlogon Helper DLLs (T1547.001–T1547.014)
- **Detection signal**: Unsigned binaries or unusual process parents (e.g., `explorer.exe` spawning a PowerShell child) appearing immediately after login are high-fidelity indicators
- **Sysinternals Autoruns** enumerates over 30 autostart locations and highlights entries not signed by Microsoft — a go-to triage tool in incident response

## Related concepts
[[Persistence]] [[Registry Run Keys]] [[Scheduled Tasks]] [[Privilege Escalation]] [[Living off the Land Binaries]]