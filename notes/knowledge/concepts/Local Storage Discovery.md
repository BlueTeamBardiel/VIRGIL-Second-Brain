# Local Storage Discovery

## What it is
Like a burglar who, before cracking a safe, first rifles through every unlocked drawer looking for Post-it notes with passwords — local storage discovery is the attacker technique of systematically examining files, directories, and storage locations on a compromised host to find sensitive data. It maps to MITRE ATT&CK T1005 (Data from Local System), covering the enumeration of files, credentials, configuration data, and documents stored directly on the target machine.

## Why it matters
After an attacker gains an initial foothold on an endpoint, local storage discovery is frequently the bridge between access and credential theft. In real-world ransomware campaigns, threat actors like LockBit operators use automated scripts to enumerate file shares, browser credential stores, and configuration files before exfiltration — ensuring they grab the most valuable data (domain credentials, VPN configs, database connection strings) before deploying encryption payloads.

## Key facts
- Attackers commonly target browser storage locations (e.g., `%APPDATA%\Local\Google\Chrome\User Data\Default\Login Data`) for plaintext or weakly encrypted credentials
- Windows Registry, `%TEMP%` folders, and application config files (`.env`, `web.config`) are high-priority discovery targets
- The technique is largely fileless-friendly — tools like PowerShell `Get-ChildItem` or `findstr` leave minimal artifacts
- Detection relies on monitoring abnormal file access patterns via EDR/SIEM using file integrity monitoring (FIM) and process-to-file access correlation
- CySA+ expects analysts to recognize bulk file enumeration events in logs (Windows Event ID 4663 — object access) as a discovery indicator

## Related concepts
[[Credential Dumping]] [[Data Exfiltration]] [[File and Directory Discovery]] [[Windows Registry Analysis]] [[MITRE ATT&CK Framework]]