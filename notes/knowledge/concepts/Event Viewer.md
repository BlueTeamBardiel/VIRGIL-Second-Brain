# Event Viewer

## What it is
Think of it as the ship's log on a vessel — every significant action, error, and system event gets recorded chronologically so you can reconstruct exactly what happened and when. Event Viewer is a built-in Windows MMC snap-in (`eventvwr.msc`) that provides a graphical interface to access and filter Windows Event Logs stored in `.evtx` format under `C:\Windows\System32\winevt\Logs`.

## Why it matters
During a ransomware incident response, an analyst opens Event Viewer and searches Security logs for Event ID 4624 (successful logon) and 4625 (failed logon) to identify credential stuffing attempts that preceded lateral movement. Filtering for Event ID 7045 (new service installed) in the System log can reveal the exact timestamp when the attacker installed a malicious service for persistence — turning a chaotic breach into a traceable timeline.

## Key facts
- **Critical Event IDs to memorize:** 4624 (logon success), 4625 (logon failure), 4648 (explicit credential logon), 4688 (process creation), 4720 (user account created), 7045 (service installed)
- Event logs are divided into **Windows Logs** (Security, System, Application) and **Applications and Services Logs** (including PowerShell/Operational)
- **Security log** requires elevated privileges to read — a normal user cannot access it, making it tamper-resistant under standard conditions
- Attackers commonly clear logs using `wevtutil cl Security` — Event ID **1102** (Security log cleared) and **104** (System log cleared) are your forensic tripwires for this action
- Event Viewer can connect to **remote machines** for centralized review, though enterprises prefer forwarding logs to a SIEM instead

## Related concepts
[[Windows Event Logs]] [[SIEM]] [[Log Analysis]] [[Incident Response]] [[Audit Policy]]