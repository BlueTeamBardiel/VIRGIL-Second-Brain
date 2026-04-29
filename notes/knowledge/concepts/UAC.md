# UAC

## What it is
Think of UAC like a bouncer at a VIP club — even if you're already inside the building (logged in as an admin), you still have to show your wristband again before entering the back room. User Account Control is a Windows security feature that forces explicit confirmation before any process is granted elevated (administrator-level) privileges, even for users already in the admin group.

## Why it matters
UAC bypass is a staple technique in post-exploitation. An attacker who has landed a low-privilege shell on a Windows machine might use techniques like DLL hijacking in auto-elevated processes (e.g., `fodhelper.exe`) or COM object hijacking to silently escalate to SYSTEM without ever triggering a UAC prompt — making the victim see nothing unusual while the attacker gains full control.

## Key facts
- UAC operates on an **integrity level model**: Low, Medium, High, and System. Standard processes run at Medium; administrative actions require High.
- **Auto-elevation** is the key attack surface — certain trusted Windows binaries elevate silently without prompting, making them prime UAC bypass targets (e.g., `eventvwr.exe`, `fodhelper.exe`).
- UAC is **not a security boundary** according to Microsoft — it's a convenience feature. A determined local attacker with code execution can bypass it.
- UAC can be configured at four levels via Group Policy, ranging from "Always notify" (most secure) to "Never notify" (effectively disabled).
- UAC bypass techniques are catalogued under **MITRE ATT&CK T1548.002** (Abuse Elevation Control Mechanism: Bypass User Account Control).

## Related concepts
[[Privilege Escalation]] [[Windows Integrity Levels]] [[Access Tokens]] [[MITRE ATT&CK]] [[Least Privilege]]