# Bring Your Own Vulnerable Driver

## What it is
Like smuggling a master key into a building by hiding it inside a legitimate maintenance worker's toolbox, BYOVD is a technique where an attacker loads a *signed but vulnerable* kernel driver onto a target system to gain ring-0 (kernel-level) privileges. Because the driver is legitimately signed, security tools and Windows Driver Signature Enforcement treat it as trusted — even though the attacker then exploits its known vulnerability to execute arbitrary code in kernel space.

## Why it matters
The BlackByte ransomware group used BYOVD in 2022, loading a vulnerable version of the MSI Afterburner driver (RTCore64.sys) to disable EDR and antivirus products before deploying their payload. This bypass is particularly dangerous because even fully patched systems are vulnerable — the *driver itself* is the weakness, not the OS.

## Key facts
- BYOVD abuses **Windows Driver Signature Enforcement (DSE)**: legitimate code signing certificates make malicious use invisible to many defenses
- Attackers commonly target drivers from GPU utilities, antivirus products, or hardware diagnostics — tools that require deep kernel access by design
- Microsoft maintains a **Windows Vulnerable Driver Blocklist** (enforced via HVCI/Memory Integrity) that defenders can enable to mitigate known BYOVD drivers
- **LOLDrivers.io** is the primary public database cataloguing known vulnerable drivers exploited in the wild
- This technique is frequently used as a **precursor step** to disable EDR tools (called EDR killing), not as a standalone attack — making detection at the driver-load event critical
- Requires the attacker to already have **local administrator privileges** to load drivers, so it escalates *from* admin *to* kernel, not from user to admin

## Related concepts
[[Kernel Exploitation]] [[EDR Evasion]] [[Windows Driver Signature Enforcement]] [[Living Off the Land]] [[Privilege Escalation]]