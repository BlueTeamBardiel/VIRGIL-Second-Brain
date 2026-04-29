# Linux kernel

## What it is
Think of the Linux kernel as the air traffic controller at a busy airport — every application (plane) must request permission to use runways (hardware resources), and the controller decides who gets access, when, and how. Precisely, the Linux kernel is the core of the Linux OS: the privileged software layer that manages hardware resources, enforces process isolation, and mediates all system calls between user-space applications and physical hardware.

## Why it matters
In 2021, the **Dirty Pipe vulnerability (CVE-2022-0847)** allowed unprivileged users to overwrite read-only files by exploiting a flaw in how the kernel handled pipe buffers — achieving full root privilege escalation in minutes. This illustrates why kernel vulnerabilities are crown-jewel targets: compromise the kernel, and every security boundary above it collapses, including containerized workloads like Docker.

## Key facts
- The kernel runs in **Ring 0** (highest CPU privilege), while user applications run in Ring 3 — this separation is the foundation of OS security boundaries
- **System calls** are the only sanctioned gateway from user space to kernel space; attackers often target syscall handlers for privilege escalation
- **Kernel modules** (`.ko` files) load directly into kernel space — malicious modules are a common rootkit technique
- Linux uses **Discretionary Access Control (DAC)** by default, but **SELinux** and **AppArmor** add Mandatory Access Control (MAC) at the kernel level
- **KASLR (Kernel Address Space Layout Randomization)** randomizes kernel memory locations to complicate exploitation, but can be defeated via information-leak vulnerabilities

## Related concepts
[[Privilege Escalation]] [[Rootkits]] [[SELinux]] [[System Calls]] [[Container Security]]