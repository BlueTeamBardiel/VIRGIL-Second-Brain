# Kernel

## What it is
Think of the kernel as the head chef in a restaurant kitchen — every waiter (application) must submit orders through the chef, who controls the stoves, knives, and walk-in freezer (hardware). The kernel is the core component of an operating system that runs in privileged CPU mode (Ring 0), managing memory, processes, device I/O, and system calls on behalf of all user-space applications.

## Why it matters
In 2018, the Meltdown vulnerability allowed user-space malware to read kernel memory by exploiting speculative CPU execution — effectively letting a waiter sneak into the walk-in freezer unescorted. This exposed passwords, encryption keys, and other secrets stored in kernel memory, requiring emergency patches across virtually every OS on the planet.

## Key facts
- The kernel operates in **Ring 0** (highest privilege); user applications run in Ring 3 — crossing this boundary requires a **system call**
- **Rootkits** target the kernel specifically because code running at Ring 0 can hide processes, files, and network connections from all security tools running at Ring 3
- **Kernel Patch Protection (KPP/PatchGuard)** on Windows blocks unauthorized kernel modifications — a direct defense against rootkit installation
- Linux uses **kernel modules** (`.ko` files) that load directly into kernel space, making malicious modules an attractive and dangerous attack vector
- **Secure Boot** and **UEFI** help ensure only signed, trusted kernels load at startup, defending against bootkits that replace or modify the kernel before the OS loads

## Related concepts
[[Privilege Escalation]] [[Rootkit]] [[Ring Protection Model]] [[Secure Boot]] [[System Call]]