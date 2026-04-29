# File and Directory Discovery

## What it is
Like a burglar who, before stealing anything, quietly opens every drawer and cabinet to map out what's in the house — attackers enumerate files and directories on a target system to understand what's available before taking action. Precisely, File and Directory Discovery (MITRE ATT&CK T1083) is a reconnaissance technique where adversaries list file system contents to locate credentials, configuration files, scripts, or sensitive data that can be leveraged for further exploitation.

## Why it matters
During the 2020 SolarWinds supply chain attack, threat actors used file and directory enumeration post-compromise to locate sensitive configuration files and identify installed security tools — allowing them to operate stealthily for months. Defenders who implement least-privilege access and monitor for unusual directory traversal commands (e.g., `dir /s`, `find`, `ls -la`) can detect attackers in this early post-exploitation phase before data is exfiltrated.

## Key facts
- MITRE ATT&CK classifies this under **Discovery (TA0007)**, meaning it typically occurs *after* initial access, not during initial compromise
- Common commands used: `dir`, `tree`, `ls`, `find / -name *.conf`, `Get-ChildItem` (PowerShell)
- Attackers specifically hunt for files like `web.config`, `.bash_history`, `id_rsa`, `passwd`, and database connection strings
- Detection relies heavily on **SIEM correlation rules** flagging recursive directory listings by non-admin accounts or at unusual hours
- On Linux, world-readable sensitive files are a misconfiguration red flag; **SUID/SGID file discovery** is a direct path to privilege escalation

## Related concepts
[[Credential Dumping]] [[Privilege Escalation]] [[MITRE ATT&CK Framework]] [[Log Analysis and SIEM]] [[Least Privilege]]