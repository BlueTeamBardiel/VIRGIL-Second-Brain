# syscall

## What it is
Like a restaurant patron who can't enter the kitchen but must place an order through a waiter — a syscall is a formal request from a user-space program to the OS kernel to perform privileged operations it cannot do itself. Precisely: a system call is the programmatic interface through which applications request services like file I/O, network communication, or process creation from the kernel, crossing the user-mode/kernel-mode boundary.

## Why it matters
Attackers performing process injection or rootkit deployment often abuse syscalls directly — bypassing higher-level API hooks by invoking syscalls like `NtAllocateVirtualMemory` on Windows directly via assembly, evading EDR solutions that only monitor Win32 API calls. Defenders countering this use kernel-level monitoring (e.g., eBPF on Linux or ETW on Windows) to observe raw syscall activity and detect anomalous patterns regardless of API-layer evasion.

## Key facts
- Syscalls are identified by numeric IDs (e.g., Linux `read` = syscall 0 on x86-64); attackers use "direct syscalls" to call these numbers without touching monitored libraries
- The CPU switches from **Ring 3** (user mode) to **Ring 0** (kernel mode) during a syscall, enforcing privilege separation
- On Linux, `strace` traces syscalls in real time — invaluable for malware analysis and debugging
- **Seccomp** (Secure Computing Mode) on Linux allows whitelisting/blacklisting specific syscalls per process, a key container hardening technique
- Windows syscall numbers change between OS versions, making "direct syscall" malware version-dependent and detectable through behavioral anomalies

## Related concepts
[[privilege escalation]] [[kernel mode vs user mode]] [[process injection]] [[seccomp]] [[EDR evasion]]