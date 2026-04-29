# namespaces

## What it is
Think of namespaces like separate aquariums stacked in the same room — each fish tank has its own ecosystem, and the fish inside can't see or touch fish in adjacent tanks, even though they all share the same building. In Linux, namespaces are kernel-level isolation mechanisms that partition global system resources — processes, network interfaces, mount points, user IDs — so that processes inside one namespace see only their own isolated view of those resources. Containers like Docker are built almost entirely on top of namespaces.

## Why it matters
A container escape attack exploits a misconfigured namespace to break the isolation boundary. For example, if a container runs with a shared PID namespace (`--pid=host`), a malicious process inside the container can see and signal host processes, effectively letting an attacker kill or probe processes outside their sandboxed environment. Defenders audit container configurations specifically for namespace flags that collapse isolation.

## Key facts
- Linux has 8 namespace types: **mnt, pid, net, ipc, uts, user, cgroup, time** — each isolates a different resource class
- The **user namespace** is the most dangerous to misconfigure; it allows mapping container root (UID 0) to an unprivileged host UID, but errors here can grant real root privileges on the host
- `unshare` and `nsenter` are the primary Linux CLI tools for creating and entering namespaces — both are red-team favorites for privilege escalation enumeration
- Docker uses namespaces + cgroups together: namespaces provide *visibility* isolation; cgroups provide *resource* limits — they are complementary, not redundant
- CVE-2019-5736 (runc escape) exploited namespace boundaries in container runtimes, allowing container root to overwrite the host `runc` binary

## Related concepts
[[Linux privilege escalation]] [[container security]] [[cgroups]] [[Docker hardening]] [[process isolation]]