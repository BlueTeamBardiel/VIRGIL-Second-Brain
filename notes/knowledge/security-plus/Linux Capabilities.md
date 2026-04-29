# Linux capabilities

## What it is
Think of traditional Linux permissions like a master key ring where you either carry all the keys (root) or almost none (user) — capabilities are like splitting that ring into 40+ individual keys you can hand out selectively. Precisely, Linux capabilities divide the monolithic root privilege into discrete units (e.g., `CAP_NET_BIND_SERVICE`, `CAP_SYS_PTRACE`) that can be granted to processes or binaries independently of UID 0.

## Why it matters
Attackers frequently exploit misconfigured capabilities as a privilege escalation path — a binary with `CAP_SETUID` set can silently escalate to root without any SUID bit, and tools like `linpeas` specifically hunt for these. Defenders use capabilities to harden services: giving a web server only `CAP_NET_BIND_SERVICE` means a compromised nginx process cannot, for example, load kernel modules (`CAP_SYS_MODULE`), containing the blast radius of exploitation.

## Key facts
- Capabilities are set on **files** (via `setcap`) or **threads** (inherited at runtime); `getcap -r /` recursively finds dangerous assignments
- Three sets govern a process: **Permitted** (maximum allowed), **Effective** (currently active), **Inheritable** (passed to child processes)
- `CAP_DAC_OVERRIDE` bypasses all file read/write/execute permission checks — essentially silent root for file access
- Containers (Docker) run with a **reduced capability set** by default; `--privileged` restores all capabilities and is a known container escape vector
- On CySA+/Security+ exams, capability abuse falls under **privilege escalation** and **least privilege** violation categories

## Related concepts
[[Privilege Escalation]] [[SUID and SGID]] [[Container Security]] [[Principle of Least Privilege]] [[Linux File Permissions]]