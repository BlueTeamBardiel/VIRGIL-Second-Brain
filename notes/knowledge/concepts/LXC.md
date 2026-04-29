# LXC

## What it is
Think of LXC like individual apartments in a building — each tenant shares the same plumbing and electrical (the kernel), but has their own locked front door and private space. LXC (Linux Containers) is an OS-level virtualization method that creates isolated userspace environments on a single Linux host, sharing the host kernel rather than emulating separate hardware. Unlike full VMs, LXC containers are lightweight because they use kernel namespaces and cgroups to enforce isolation.

## Why it matters
In a 2019 runc vulnerability (CVE-2019-5736), attackers running malicious containers could overwrite the host's runc binary, escaping the container entirely and achieving full host compromise — a classic container escape attack. This scenario illustrates why container isolation is fundamentally weaker than hypervisor-based VM isolation: a kernel vulnerability can collapse the boundary between every container on that host simultaneously.

## Key facts
- LXC uses **Linux kernel namespaces** (PID, network, mount, UTS, IPC, user) to provide process isolation without a separate kernel
- **cgroups (control groups)** enforce resource limits — CPU, memory, I/O — preventing one container from starving others (denial-of-service mitigation)
- Running LXC containers in **unprivileged mode** (mapping root inside container to a non-root UID on host) significantly reduces escape risk
- A **privileged LXC container** with host filesystem mounts or raw device access is effectively equivalent to root on the host — a critical misconfiguration
- LXC is the foundation that Docker originally built upon, though Docker now uses its own **containerd/runc** runtime

## Related concepts
[[Container Security]] [[Namespaces and cgroups]] [[Privilege Escalation]] [[Docker Security]] [[Hypervisor Types]]