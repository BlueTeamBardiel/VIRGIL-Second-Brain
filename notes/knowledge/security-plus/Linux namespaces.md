# Linux namespaces

## What it is
Like placing a process inside a snow globe — it can see its own miniature world completely, but has no awareness of the vast room surrounding it. Linux namespaces are a kernel feature that partitions global system resources (PIDs, network interfaces, mount points, users, etc.) so that processes within a namespace perceive they have their own isolated instance of those resources.

## Why it matters
Container escapes — a critical class of privilege escalation attacks — frequently target namespace boundaries. In the 2019 `runc` vulnerability (CVE-2019-5736), an attacker inside a Docker container exploited a file descriptor race condition to overwrite the host's `runc` binary, effectively punching through the PID and mount namespace isolation to compromise the underlying host.

## Key facts
- There are **8 namespace types**: Mount (mnt), PID, Network (net), IPC, UTS (hostname), User, Cgroup, and Time
- **User namespaces** are the most dangerous from a security perspective — they allow unprivileged processes to appear as root *within* the namespace, enabling privilege escalation if misconfigured
- Docker and Kubernetes use network + PID + mount namespaces together to create container isolation; they do **not** always use user namespaces by default
- The `/proc/[pid]/ns/` directory exposes namespace file descriptors — attackers enumerate these to map container boundaries during post-exploitation
- Namespaces alone do not provide full security isolation — they must be combined with **cgroups** (resource limits) and **seccomp/AppArmor** (syscall filtering) for defense-in-depth

## Related concepts
[[Container Security]] [[Privilege Escalation]] [[Linux Capabilities]] [[cgroups]] [[Seccomp Profiles]]