# eBPF

## What it is
Think of eBPF like a USB port for the Linux kernel — it lets you safely plug in custom mini-programs that run inside the kernel without recompiling or rebooting it. Precisely, eBPF (extended Berkeley Packet Filter) is a Linux kernel technology that allows sandboxed programs to execute in kernel space, enabling real-time observation and manipulation of system calls, network packets, and kernel events. A verifier checks each program before execution to prevent crashes or malicious behavior.

## Why it matters
Security tools like Falco and Cilium use eBPF to intercept system calls in real time — if a container suddenly spawns `/bin/bash`, eBPF-based agents catch it at the kernel level before any userspace detection tool even sees it. Conversely, attackers have begun deploying malicious eBPF rootkits (like the "Pamspy" credential harvester) that hook kernel functions to hide processes, exfiltrate data, or intercept SSH passwords — all while remaining invisible to traditional endpoint tools that operate in userspace.

## Key facts
- eBPF programs are verified by the kernel's built-in verifier before loading, preventing infinite loops and illegal memory access
- Requires root or `CAP_BPF` / `CAP_SYS_ADMIN` privileges to load programs — privilege escalation exploits targeting eBPF are a documented attack vector (CVE-2021-3490)
- eBPF rootkits can hide files, network connections, and processes by hooking functions like `getdents64` or `tcp_seq_show`
- Used defensively in runtime security (Falco), network policy enforcement (Cilium), and performance observability (BCC toolkit)
- Unlike kernel modules, eBPF programs are sandboxed — but a verifier bypass turns this safety net into a kernel-level code execution primitive

## Related concepts
[[Linux Privilege Escalation]] [[Rootkits]] [[Kernel Exploitation]] [[Container Security]] [[System Call Monitoring]]