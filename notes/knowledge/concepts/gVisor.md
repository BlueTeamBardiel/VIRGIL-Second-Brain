# gVisor

## What it is
Like a strict embassy that translates your visa requests to the host country without ever letting you touch their soil directly, gVisor is a user-space kernel that intercepts and handles container syscalls before they ever reach the host OS kernel. Developed by Google, it creates an additional isolation layer between containerized workloads and the underlying Linux kernel by implementing a sandboxed kernel in Go (called "Sentry") that services syscalls itself.

## Why it matters
In 2019, a container escape vulnerability (CVE-2019-5736) in runc allowed attackers with container access to overwrite the host runc binary and achieve full host root privileges. With gVisor deployed, that attack path is severed — because the container's syscalls never reach the real kernel or the host filesystem directly; the Sentry kernel intercepts them first, drastically reducing the exploitable attack surface.

## Key facts
- gVisor implements two interception modes: **ptrace** (slower, broader compatibility) and **KVM** (hardware-accelerated, production-preferred)
- The **Gofer** process mediates all filesystem access between the container and host, running as a separate, isolated process
- gVisor supports only a **subset of Linux syscalls** — applications requiring exotic syscalls may fail, making compatibility a known tradeoff
- It does **not** use a full VM or hypervisor like Kata Containers does — no separate kernel image is booted, making it lighter but offering less isolation than a full VM
- gVisor is integrated with **Kubernetes** via a `RuntimeClass` called `gvisor`, enabling per-pod sandboxing without changing application code

## Related concepts
[[Container Security]] [[Syscall Filtering]] [[Seccomp]] [[Kernel Exploit Mitigation]] [[Kata Containers]]