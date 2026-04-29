# Defense Evasion via Sandbox Evasion

## What it is
Like a cockroach that freezes motionless when the kitchen light turns on, malware detects when it's being watched and refuses to perform its malicious behavior. Sandbox evasion is a collection of techniques malware uses to detect automated analysis environments and either delay, alter, or suppress its payload execution to avoid behavioral detection.

## Why it matters
The Emotet banking trojan famously used sandbox evasion by checking for user activity — mouse movement, running processes, and system uptime — before decrypting and executing its payload. Security analysts relying solely on sandbox detonation received clean reports while real user machines were actively compromised, demonstrating why layered detection strategies are essential.

## Key facts
- **Time-based evasion**: Malware calls `sleep()` for extended periods or checks system clock values, betting that sandboxes time out analysis after 2-5 minutes
- **Environment fingerprinting**: Checks for sandbox artifacts like VMware registry keys (`HKLM\SOFTWARE\VMware, Inc.`), small disk sizes (<60GB), or low RAM (<2GB)
- **Human interaction checks**: Monitors for mouse movement, click history, or running process counts — real machines have dozens; sandboxes often have fewer than 20
- **CPUID and hypervisor detection**: Executes CPU instructions that return different values inside virtual machines versus bare metal hardware
- **Countermeasure**: Modern sandboxes use "human simulation" (synthetic mouse movement, browser history injection) and bare-metal analysis environments to defeat these checks

## Related concepts
[[Behavioral Analysis]] [[Dynamic Malware Analysis]] [[Anti-Forensics]] [[Indicator of Compromise]] [[Virtualization Security]]