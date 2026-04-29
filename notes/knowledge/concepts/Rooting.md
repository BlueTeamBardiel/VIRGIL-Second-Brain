# Rooting

## What it is
Like picking the master lock to a hotel and getting a skeleton key that opens every room — rooting is the process of gaining unrestricted root (superuser) access on a device, bypassing the manufacturer's permission controls. On Android and Linux-based systems, the "root" account has complete authority over the OS, files, and hardware. Rooting deliberately dismantles the sandboxing model that separates user-space processes from privileged system functions.

## Why it matters
In 2015, the Stagefright vulnerability allowed attackers to send a crafted MMS message to an Android device, and on pre-rooted phones the exploit chain could achieve root-level code execution without user interaction — giving attackers complete device control including camera, microphone, and all stored credentials. Defenders use mobile device management (MDM) solutions that detect rooted devices and block them from accessing corporate resources, because a rooted device cannot be trusted to enforce policy.

## Key facts
- Rooting Android ≠ jailbreaking iOS — same concept, different terminology and exploit paths, but both bypass vendor security models
- Rooted devices typically fail **SafetyNet / Play Integrity API** checks, which apps use to detect compromised environments
- Root access allows bypassing **full-disk encryption** protections, app sandboxing, and SELinux policies
- Attackers use **privilege escalation exploits** (e.g., dirty COW — CVE-2016-5195) to achieve root without physical device access
- From a Security+/CySA+ perspective, rooting represents a **loss of integrity** in the device trust model and is a key indicator of compromise (IoC) in mobile forensics

## Related concepts
[[Privilege Escalation]] [[Jailbreaking]] [[Mobile Device Management]] [[Sandbox Escape]] [[SELinux]]