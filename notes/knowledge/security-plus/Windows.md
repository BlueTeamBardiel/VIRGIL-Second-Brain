# Windows

## What it is
Like a massive office building with thousands of rooms, hallways, and service entrances — most staff only use the front door, but attackers look for unlocked side doors and maintenance tunnels. Windows is Microsoft's dominant desktop and server operating system, built on a kernel architecture with user/kernel mode separation, Active Directory integration, and a registry-based configuration system.

## Why it matters
In the 2017 WannaCry ransomware attack, attackers exploited EternalBlue — an SMBv1 vulnerability in Windows — to spread laterally across unpatched systems and encrypt data at scale, affecting over 200,000 machines in 150 countries. Organizations running Windows must maintain aggressive patch cycles and disable legacy protocols like SMBv1 precisely because Windows' ubiquity makes it the highest-value target in any environment.

## Key facts
- **NTLM and Kerberos** are the two primary authentication protocols; Kerberos is preferred, but NTLM fallback creates pass-the-hash attack opportunities
- **Windows Registry** stores system and application configurations — attackers frequently use `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run` for persistence
- **UAC (User Account Control)** separates standard and elevated privileges; bypassing UAC is a common privilege escalation technique logged under Event ID 4688
- **Windows Event Logs** (Security, System, Application) are critical for forensics — Event ID 4624 = successful logon, 4625 = failed logon, 4648 = explicit credential use
- **SMB (Server Message Block)** on port 445 is historically the most exploited Windows service — EternalBlue, NotPetya, and lateral movement tools like PsExec all leverage it

## Related concepts
[[Active Directory]] [[NTLM Pass-the-Hash]] [[Kerberos]] [[Windows Registry]] [[SMB Protocol]] [[Privilege Escalation]]