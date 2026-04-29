# WinPEAS

## What it is
Like a home inspector who methodically checks every window latch, loose floorboard, and unlocked door in a house, WinPEAS systematically scans a Windows system for every misconfiguration an attacker could exploit. It is an automated privilege escalation enumeration script (part of the PEAS-ng suite) that audits a compromised Windows host for weaknesses — unquoted service paths, weak registry permissions, stored credentials, and vulnerable scheduled tasks — that could allow a low-privileged user to become SYSTEM.

## Why it matters
During a penetration test, an attacker lands a reverse shell as a standard user account. Running WinPEAS within seconds reveals an unquoted service path in a third-party antivirus installation — placing a malicious executable in `C:\Program Files\Vendor.exe` gives SYSTEM-level execution when the service restarts. Defenders use WinPEAS outputs as a hardening checklist, treating every finding as a patch priority before attackers do.

## Key facts
- WinPEAS is part of the **PEASS-ng** (Privilege Escalation Awesome Scripts Suite) project, available on GitHub; it outputs color-coded findings (red = high priority)
- Commonly detected checks include: **unquoted service paths**, **AlwaysInstallElevated** registry keys, **weak folder permissions on service binaries**, and **cached credentials in DPAPI**
- WinPEAS is typically flagged by AV/EDR tools; attackers often obfuscate or reflectively load it in memory to avoid detection
- Outputs map directly to **MITRE ATT&CK Tactic TA0004** (Privilege Escalation) and several sub-techniques including T1574 (Hijack Execution Flow)
- Running WinPEAS requires **no administrative privileges** — it is designed specifically for post-exploitation from a low-privilege foothold

## Related concepts
[[Privilege Escalation]] [[Unquoted Service Paths]] [[Post-Exploitation Enumeration]] [[AlwaysInstallElevated]] [[MITRE ATT&CK]]