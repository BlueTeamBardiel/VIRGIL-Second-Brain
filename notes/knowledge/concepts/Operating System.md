# Operating System

## What it is
Think of an OS like a hotel concierge — it stands between guests (applications) and the building's infrastructure (hardware), allocating rooms, managing keys, and enforcing who gets access to what. An operating system is the foundational software layer that manages hardware resources, provides services to applications, and enforces privilege boundaries between processes. It is the single most critical piece of software on any machine because every other security control ultimately runs on top of it.

## Why it matters
In the 2017 WannaCry ransomware attack, unpatched Windows OS kernels exposed a vulnerability in the SMBv1 protocol (MS17-010), allowing attackers to execute code at the kernel level — the highest privilege ring — and spread laterally across 200,000 machines without any user interaction. Keeping the OS patched is the single highest-ROI defensive action a security team can take.

## Key facts
- Operating systems use **privilege rings** (Ring 0–3); the kernel runs in Ring 0 with unrestricted hardware access, while user applications run in Ring 3 — exploits that escape Ring 3 into Ring 0 are called **privilege escalation** attacks
- **ASLR (Address Space Layout Randomization)** is a built-in OS defense that randomizes memory addresses to defeat buffer overflow exploits
- Windows, Linux, and macOS all use a **Security Reference Monitor** to enforce access control decisions on every object request
- The **TCB (Trusted Computing Base)** is the minimal set of OS components that must be correct for security to hold — smaller TCB = smaller attack surface
- OS hardening benchmarks (CIS Benchmarks, DISA STIGs) are standard frameworks used to reduce default attack surface by disabling unnecessary services and enforcing secure configurations

## Related concepts
[[Privilege Escalation]] [[Kernel Exploits]] [[Patch Management]] [[Access Control]] [[Hardening]]