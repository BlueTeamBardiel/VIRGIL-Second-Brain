# kernel space

## What it is
Think of a hospital's sterile operating room versus the public waiting area — only authorized surgeons in scrubs can enter the OR, while everyone else stays in the lobby. Kernel space is the privileged memory region where the OS kernel executes, with unrestricted access to hardware, memory, and CPU instructions. User-mode processes run in the separate "waiting area" (user space) and must request services via system calls to cross that boundary.

## Why it matters
Rootkits like the infamous *Necurs* malware target kernel space specifically because code running there is invisible to most security tools, which themselves operate in user space. By injecting a malicious kernel module, an attacker can intercept system calls, hide processes from `ps`, and suppress file listings — achieving near-total persistence. Kernel-level security controls like Windows Kernel Patch Protection (PatchGuard) exist precisely to prevent unauthorized code from operating at this level.

## Key facts
- Kernel space runs at **Ring 0** in the x86 privilege model; user space runs at **Ring 3** — the gap between them enforces memory protection
- A process crash in user space kills only that process; a crash in kernel space causes a full system failure (BSOD / kernel panic)
- **Kernel exploits** (e.g., Dirty COW — CVE-2016-5195) escalate privileges by abusing vulnerabilities in kernel code to gain Ring 0 access from Ring 3
- **System calls** are the only legitimate, controlled bridge between user space and kernel space — each call is a numbered interface entry point
- **eBPF (Extended Berkeley Packet Filter)** allows limited, sandboxed kernel-space execution for monitoring — both a defensive tool and an emerging attacker technique

## Related concepts
[[privilege escalation]] [[system calls]] [[rootkits]] [[ring protection]] [[memory protection]]