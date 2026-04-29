# fd-based syscalls

## What it is
Like a coat-check ticket at a restaurant — you hand over your coat once and receive a small numbered stub you use for all future interactions, file descriptors (FDs) are integer handles the kernel issues when a process opens a resource. FD-based syscalls (`read`, `write`, `close`, `dup2`, `sendfile`) operate on these integers rather than file paths, meaning the kernel resolves permissions *at open time*, not at operation time.

## Why it matters
This TOCTOU-resistant property is exploited in privilege escalation: an attacker who inherits an open FD from a privileged parent process can call `read()`/`write()` on it even after dropping privileges or changing the filesystem path. A classic example is a SUID binary that opens `/etc/shadow`, forks a child, and carelessly leaks the FD — the child can now read password hashes without ever having permission to open the file itself.

## Key facts
- FDs 0, 1, and 2 are reserved: stdin, stdout, and stderr — attackers redirect these with `dup2()` to hijack I/O during shellcode execution.
- `fcntl(fd, F_SETFD, FD_CLOEXEC)` sets the close-on-exec flag; missing this flag causes FD leaks across `execve()` calls, a common misconfiguration.
- `/proc/<PID>/fd/` exposes every open FD as a symlink — attackers with local access enumerate these to find sensitive open files.
- `sendfile()` and `splice()` are FD-based syscalls that transfer data kernel-side, bypassing userland buffers and potentially evading memory-scanning defenses.
- Seccomp-BPF filters frequently allowlist specific FD-based syscalls while blocking path-based ones (`open`, `openat`) to sandbox processes after initialization.

## Related concepts
[[TOCTOU Race Conditions]] [[Privilege Escalation]] [[Seccomp Sandboxing]]