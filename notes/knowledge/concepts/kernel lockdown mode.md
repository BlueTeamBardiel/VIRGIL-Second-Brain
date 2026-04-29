# kernel lockdown mode

## What it is
Think of it like a nuclear launch protocol that prevents even the president from overriding certain safeguards — kernel lockdown mode restricts what root (UID 0) and even kernel-level code can do to the running kernel itself. Introduced in Linux 5.4, it enforces a security boundary between userspace (including root) and kernel space by blocking operations that could compromise kernel integrity, such as loading unsigned modules or writing to `/dev/mem`.

## Why it matters
Without lockdown mode, an attacker who achieves root access can load a malicious kernel module, effectively becoming the kernel itself — bypassing all security controls including SELinux, audit logs, and Secure Boot protections. Lockdown mode closes this privilege escalation path, ensuring that Secure Boot's chain of trust extends through runtime, not just at boot time. This directly counters techniques like rootkit installation via `insmod` that security tools like rkhunter are designed to detect but cannot *prevent*.

## Key facts
- Operates in two levels: **integrity** (blocks reading/writing kernel memory) and **confidentiality** (also blocks extracting kernel secrets like hibernation images)
- Enabled automatically on systems with **UEFI Secure Boot** active on many distros (Fedora, RHEL, Ubuntu)
- Blocks `/dev/mem`, `/dev/kmem`, kprobes, and **unsigned kernel module loading** — all classic rootkit entry points
- Even **root cannot bypass it** without a reboot — the lockdown LSM (Linux Security Module) enforces this at the kernel level
- Can be set via kernel command line parameter `lockdown=integrity` or `lockdown=confidentiality`

## Related concepts
[[Secure Boot]] [[Linux Security Modules]] [[kernel rootkits]] [[privilege escalation]] [[integrity measurement architecture]]