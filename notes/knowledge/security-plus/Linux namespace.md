# Linux namespace

## What it is
Think of namespaces like one-way mirrors in an apartment building — each tenant sees only their own room, unaware the hallway or other apartments exist. Precisely: a Linux namespace is a kernel feature that wraps a global system resource (PIDs, network interfaces, mount points, users) into an isolated abstraction, so processes inside one namespace see only their own scoped view of that resource. Each container you run in Docker is fundamentally a collection of these namespaces stitched together.

## Why it matters
Container escape attacks target namespace boundaries — if a privileged process inside a container can call `unshare()` or exploit a kernel vulnerability to break out of its PID or mount namespace, it gains visibility into host processes and the filesystem. The 2019 `runc` vulnerability (CVE-2019-5736) exploited this: a malicious container could overwrite the host's `runc` binary by escaping mount namespace protections, achieving host code execution as root.

## Key facts
- There are **8 namespace types**: Mount (mnt), PID, Network (net), IPC, UTS (hostname), User, Cgroup, and Time
- **User namespaces** are the most dangerous — they allow unprivileged users to map themselves to UID 0 *inside* the namespace, which can be exploited for privilege escalation
- **PID namespace isolation** means a container's PID 1 appears as a different PID on the host — but host root can always see all PIDs from outside
- Namespaces are accessed via three syscalls: `clone()`, `unshare()`, and `setns()` — attackers exploiting containers often abuse `unshare()`
- Namespaces are **not security boundaries by themselves** — seccomp, AppArmor/SELinux, and dropping capabilities are required to harden them properly

## Related concepts
[[Container Security]] [[Privilege Escalation]] [[Linux Capabilities]] [[seccomp]] [[Kernel Exploitation]]