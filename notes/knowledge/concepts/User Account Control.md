# User Account Control

## What it is
Think of UAC like a bouncer at a VIP club: even if you're already inside the building (logged in as an admin), you still need to show your wristband again before entering the back room. User Account Control is a Windows security feature that enforces privilege separation by prompting users for explicit consent or credentials before allowing processes to run with elevated (administrator-level) privileges.

## Why it matters
In 2021, attackers using the Conti ransomware leveraged UAC bypass techniques — specifically abusing `fodhelper.exe`, a trusted Windows binary that auto-elevates — to escalate privileges silently without triggering a UAC prompt. This allowed malicious payloads to run with admin rights while the victim saw nothing unusual, demonstrating how UAC bypasses are a critical step in many post-exploitation chains.

## Key facts
- UAC operates on an **integrity level model**: Low, Medium, High, and System — standard users run at Medium, elevated processes run at High
- The **Secure Desktop** feature dims the screen during UAC prompts to prevent other processes from spoofing the dialog
- UAC has **four configurable levels** in Windows, ranging from always notify to never notify (disabled); the default notifies only for app changes
- UAC is **not a security boundary** per Microsoft's official stance — it's a convenience feature; a determined local attacker can bypass it
- Common UAC bypass methods include **DLL hijacking**, **token impersonation**, and abusing **auto-elevate COM objects** or trusted binaries like `eventvwr.exe`

## Related concepts
[[Privilege Escalation]] [[Least Privilege]] [[Access Tokens]] [[Integrity Levels]] [[Windows Registry]]