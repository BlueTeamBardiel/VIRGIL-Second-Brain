# Software Restriction

## What it is
Think of it like a nightclub bouncer with an explicit guest list — only approved programs get in, everything else is turned away at the door. Software Restriction Policies (SRP) and AppLocker are Windows mechanisms that define rules controlling which applications, scripts, and executables are permitted to run on a system based on criteria like path, hash, publisher certificate, or zone.

## Why it matters
In 2017, ransomware campaigns like WannaCry and NotPetya executed malicious payloads dropped into writable directories like `%TEMP%` and `%AppData%`. Organizations with AppLocker rules blocking unsigned executables from user-writable paths were largely unaffected — the restriction policy killed the payload before it could execute, demonstrating that application whitelisting is one of the most effective ransomware defenses available.

## Key facts
- **AppLocker** (Windows 7+) supersedes the older **Software Restriction Policies (SRP)** and supports rules based on publisher, path, or file hash — with enforcement per user or group
- AppLocker rule collections cover: **Executable rules, Windows Installer rules, Script rules, DLL rules, and Packaged app rules**
- The **default deny** posture (whitelist mode) is far stronger than blacklisting — attackers can rename malware, but a hash or publisher rule doesn't care about filenames
- AppLocker requires **Enterprise or Ultimate** editions of Windows; SRP works on Pro editions but is less granular
- **WDAC (Windows Defender Application Control)**, the successor to AppLocker, enforces restrictions at the kernel level, making it significantly harder to bypass via admin-level manipulation

## Related concepts
[[Application Whitelisting]] [[Windows Defender Application Control]] [[Least Privilege]] [[Group Policy]] [[Defense in Depth]]