# Rootkit Techniques

## What it is
Imagine a corrupt building inspector who rewires the security cameras to show empty hallways while criminals operate freely — that's a rootkit. A rootkit is malware that modifies the operating system kernel, system calls, or bootloader to conceal its presence and maintain persistent, privileged access by lying to the OS about what's actually running on the system.

## Why it matters
In the 2011 Sony rootkit incident (originally exposed in 2005), Sony BMG's DRM software used rootkit techniques to hide its processes from Windows Task Manager, inadvertently creating a hiding spot other malware exploited. Defenders discovered it only by comparing the raw disk byte count against what the OS reported — a classic integrity-check bypass detection method.

## Key facts
- **User-mode rootkits** hook API calls (e.g., `NtQuerySystemInformation`) to filter results; **kernel-mode rootkits** (ring 0) modify the SSDT or use DKOM (Direct Kernel Object Manipulation) to unlink processes from linked lists
- **Bootkits** infect the MBR or UEFI firmware, loading before the OS and surviving full OS reinstalls
- Detection techniques include memory forensics (comparing live memory to disk), cross-view detection, and Trusted Platform Module (TPM)-based Secure Boot validation
- **DKOM** hides malicious processes by unlinking them from the `EPROCESS` doubly-linked list in the Windows kernel — the process still runs but becomes invisible to `tasklist`
- Tools like **Volatility** detect rootkits by analyzing raw memory dumps and identifying discrepancies between process lists visible to the OS versus what's in physical memory

## Related concepts
[[Privilege Escalation]] [[Memory Forensics]] [[Secure Boot]]