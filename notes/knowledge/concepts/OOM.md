# OOM

## What it is
Like a restaurant kitchen that runs out of counter space and starts throwing away half-prepared dishes to keep working, an operating system hit with Out-Of-Memory (OOM) conditions invokes its OOM killer — a kernel mechanism that forcibly terminates processes to reclaim RAM. Precisely: OOM is the state where a system cannot satisfy a memory allocation request, triggering emergency process termination scored by the kernel's heuristic badness algorithm.

## Why it matters
Attackers deliberately trigger OOM conditions as a denial-of-service vector — a technique called a "memory exhaustion attack" — by spawning processes or allocating buffers that consume all available RAM, forcing the OOM killer to terminate critical services like web servers, authentication daemons, or database processes. The 2018 Kubernetes OOM vulnerability allowed unprivileged containers to exhaust node memory, crashing the entire node and disrupting availability across co-hosted workloads.

## Key facts
- The Linux OOM killer scores each process 0–1000 using factors like memory usage, runtime, and privilege level; the highest-scored process gets killed first
- Setting `/proc/PID/oom_score_adj` to `-1000` makes a process immune to OOM killing — commonly used to protect critical system daemons
- Memory overcommit (`vm.overcommit_memory`) lets the kernel promise more RAM than physically exists; when the lie becomes reality, OOM killer triggers
- OOM conditions can be induced via fork bombs, large `malloc()` loops, or memory-mapped file abuse — all classic DoS primitives
- Container environments (Docker/Kubernetes) use cgroup memory limits to sandbox OOM events, preventing one container from killing another's processes

## Related concepts
[[Denial of Service]] [[Fork Bomb]] [[cgroups]] [[Memory Safety]] [[Resource Exhaustion]]