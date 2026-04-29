# Android

## What it is
Like a busy open-air market compared to Apple's walled shopping mall — Android is an open-source, Linux-based mobile operating system developed by Google that allows broad third-party customization, sideloading of apps, and manufacturer modifications to the core OS.

## Why it matters
In 2023, attackers distributed trojanized versions of legitimate apps (like Telegram) through third-party APK sites, exploiting Android's sideloading capability to deploy spyware. Because Android allows installation outside the Google Play Store, users who bypass official channels face dramatically elevated malware risk — defenders must enforce MDM policies that restrict unknown sources.

## Key facts
- **Sideloading** (installing APKs outside the Play Store) is enabled by toggling "Unknown Sources" — a major attack vector absent on stock iOS
- Android uses a **permission model** where apps request capabilities at install or runtime; over-permissioned apps are a primary data-exfiltration pathway
- **Android Sandbox** isolates each app in its own Linux UID/process — privilege escalation exploits (like Stagefright) target this boundary
- **Fragmentation** is a critical security weakness: manufacturers and carriers delay OS patches, leaving millions of devices on vulnerable Android versions for months or years
- Google's **Play Protect** performs on-device and cloud-based malware scanning, but can be disabled — attackers frequently instruct victims to disable it before installing malicious APKs

## Related concepts
[[Mobile Device Management]] [[APK Analysis]] [[Android Permissions Model]] [[Sideloading]] [[Privilege Escalation]]