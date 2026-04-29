# File and Directory Permissions Modification

## What it is
Like a thief who steals a master key and then quietly duplicates it so they can return anytime, attackers modify file and directory permissions to grant themselves persistent, unauthorized access to sensitive resources. Precisely, this is the act of changing access control settings on files or directories — using commands like `chmod`, `chown`, `icacls`, or `attrib` — to weaken restrictions, escalate privileges, or maintain access after initial compromise.

## Why it matters
In the 2020 SolarWinds attack, adversaries manipulated file permissions on log directories to prevent security tools from recording their activity, effectively blinding defenders. Defenders monitor for unexpected permission changes on critical paths like `/etc/shadow`, `/etc/sudoers`, or `C:\Windows\System32` as high-fidelity indicators of compromise.

## Key facts
- **MITRE ATT&CK T1222** catalogs File and Directory Permissions Modification as a Defense Evasion and Privilege Escalation technique on both Linux (T1222.002) and Windows (T1222.001) subtechniques.
- On Linux, `chmod 777` removes all ownership restrictions; attackers use this to make malicious binaries world-executable without needing root post-drop.
- `chown root:root + chmod u+s` sets the SUID bit, allowing any user to execute a file with root privileges — a classic privilege escalation vector.
- Windows `icacls` can grant `Everyone:(F)` (Full Control) silently, bypassing NTFS ACL protections on sensitive registry hives or executables.
- SIEM rules should alert on permission changes to files in `/etc/`, `/bin/`, startup folders, and scheduled task directories — these are low-noise, high-value detection signals.

## Related concepts
[[Privilege Escalation]] [[Defense Evasion]] [[Access Control Lists]] [[SUID and SGID Bits]] [[Least Privilege]]