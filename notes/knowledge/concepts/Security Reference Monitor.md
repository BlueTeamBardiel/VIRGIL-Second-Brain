# Security Reference Monitor

## What it is
Think of it as the bouncer at an exclusive club who checks every single person against a guest list — no exceptions, no side doors, no bribing the staff. The Security Reference Monitor (SRM) is a kernel-level component in operating systems that mediates *every* access request between a subject (user/process) and an object (file/resource), enforcing access control policy on each attempt. It is the hardware and software mechanism that makes mandatory access control enforceable rather than advisory.

## Why it matters
In 2017, the Petya/NotPetya ransomware exploited Windows privilege escalation to bypass access controls and write to protected disk sectors. A correctly enforced SRM would have blocked a low-privileged process from requesting write access to the Master Boot Record — the SRM's job is precisely to intercept that request before it reaches the resource. When the SRM is compromised or circumvented (e.g., via kernel exploits), the entire security model of the OS collapses.

## Key facts
- The SRM must satisfy three design requirements: **tamper-proof**, **always invoked** (no bypass path), and **small enough to be analyzed and tested** (this is called being *verifiable*)
- These three properties together define the **Reference Monitor Concept**, formalized in the Anderson Report (1972)
- A **Security Kernel** is the hardware/software implementation of the reference monitor concept
- The **Trusted Computing Base (TCB)** encompasses the SRM plus all other components that must be trusted for security to hold
- Windows implements the SRM as a kernel-mode component (`ntoskrnl.exe`) working alongside the Local Security Authority (LSA) to enforce access tokens against object DACLs/SACLs

## Related concepts
[[Mandatory Access Control]] [[Trusted Computing Base]] [[Privilege Escalation]] [[Access Control Matrix]] [[Security Kernel]]