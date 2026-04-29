# Operating Systems

## What it is
Think of an OS like a hotel manager: guests (applications) never touch the building's wiring or plumbing directly — they submit requests, and the manager decides what gets allocated. An operating system is the software layer that abstracts hardware resources, enforces privilege boundaries, and arbitrates access between running processes. It maintains the critical separation between user space (ring 3) and kernel space (ring 0).

## Why it matters
In the 2017 EternalBlue exploit (used in WannaCry), attackers targeted a vulnerability in Windows SMBv1 — a kernel-level service — meaning a successful exploit gave them SYSTEM-level privileges with no user interaction required. This demonstrates why OS hardening, timely patching, and disabling unused services are foundational defensive controls: a single unpatched OS component can hand attackers the keys to the entire machine.

## Key facts
- **Ring architecture**: x86 systems have privilege rings 0–3; OS kernel runs at ring 0 (most privileged), user applications at ring 3 — this separation prevents unprivileged code from directly accessing hardware
- **Kernel vs. user space**: A privilege escalation vulnerability allows code to jump from ring 3 to ring 0, bypassing access controls entirely
- **OS hardening benchmarks**: CIS Benchmarks and DISA STIGs provide prescriptive OS configuration standards tested on Security+/CySA+
- **Attack surface reduction**: Disabling unnecessary services, removing default accounts, and applying least privilege reduces the OS attack surface — a core CySA+ mitigation strategy
- **Mandatory Access Control (MAC)**: OSes like SELinux enforce MAC policies at the kernel level, confining processes even if they are compromised — contrast with discretionary access control (DAC) used by default in Windows NTFS

## Related concepts
[[Privilege Escalation]] [[Patch Management]] [[Mandatory Access Control]] [[Kernel Exploits]] [[Hardening]]