# seccomp

## What it is
Think of seccomp like a nightclub bouncer with a strict guest list — your process can only call the system calls on the approved list, and anything else gets immediately ejected (killed). Seccomp (Secure Computing Mode) is a Linux kernel feature that restricts which system calls a process is permitted to make, enforced at the kernel level before the call executes. In strict mode it allows only four calls; in filter mode (seccomp-BPF) you define custom rules using Berkeley Packet Filter programs.

## Why it matters
In 2019, container escape vulnerabilities like CVE-2019-5736 (runc overwrite) demonstrated how a compromised process could exploit kernel interfaces to break out of a container. Docker's default seccomp profile blocks over 40 dangerous syscalls — including `ptrace`, `mount`, and `reboot` — meaning even if an attacker achieves code execution inside a container, they hit a wall before they can weaponize kernel-level primitives to escalate.

## Key facts
- **Two modes:** SECCOMP_MODE_STRICT (only `read`, `write`, `exit`, `sigreturn`) and SECCOMP_MODE_FILTER (custom BPF rules via `prctl()` or `seccomp()` syscall)
- **Enforcement is kernel-side:** filtering happens before the syscall reaches kernel code, so a vulnerable kernel function never executes
- **Actions available in filter mode:** ALLOW, KILL (process or thread), TRAP, ERRNO (return fake error), LOG, TRACE
- **Docker uses seccomp by default:** its default profile is a JSON allowlist; `--security-opt seccomp=unconfined` disables it — a significant red flag in CTF and audit scenarios
- **Cannot be disabled once set:** a process can only make its seccomp policy more restrictive, never less — this property is called *no-new-privs* monotonicity

## Related concepts
[[Linux Capabilities]] [[Namespaces]] [[AppArmor]] [[Container Security]] [[Privilege Escalation]]