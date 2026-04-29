# AppLocker

## What it is
Think of AppLocker as a nightclub bouncer with a strict guest list — only pre-approved executables get past the door, and everything else gets turned away regardless of how it's dressed. AppLocker is a Windows application whitelisting feature (available in Enterprise/Ultimate editions) that allows administrators to define rules controlling which applications, scripts, installers, and DLLs are permitted to execute on a system. Rules can be based on publisher signatures, file paths, or file hashes.

## Why it matters
During a ransomware incident, attackers frequently drop malicious executables into user-writable directories like `%TEMP%` or `%APPDATA%` to evade detection. A properly configured AppLocker policy blocking execution from those paths stops the payload cold — even if the malware bypasses antivirus — because the OS itself refuses to run it. This makes AppLocker a critical defense-in-depth control against living-off-the-land and malware delivery techniques.

## Key facts
- AppLocker enforces rules across four categories: **Executable rules** (.exe/.com), **Windows Installer rules** (.msi/.msp), **Script rules** (.ps1, .bat, .vbs, .js), and **Packaged app rules** (AppX)
- Rules are configured via **Group Policy** (GPO) and stored under `Computer Configuration > Windows Settings > Security Settings > Application Control Policies`
- AppLocker operates in two modes: **Audit mode** (logs violations without blocking) and **Enforce mode** (actively blocks unauthorized execution)
- Requires the **Application Identity (AppIDSvc)** service to be running — disabling this service bypasses enforcement entirely
- AppLocker is **superseded by Windows Defender Application Control (WDAC)** in modern environments, which operates at the kernel level and is harder to bypass

## Related concepts
[[Windows Defender Application Control]] [[Group Policy Objects]] [[Least Privilege]] [[Allow-listing vs Deny-listing]] [[Defense in Depth]]