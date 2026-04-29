# systemd-nspawn

## What it is
Think of it as a cardboard box inside your house — it looks contained, but a determined person can push through the walls. `systemd-nspawn` is a lightweight Linux container tool built into systemd that isolates processes using kernel namespaces and chroot, providing OS-level virtualization without the full overhead of VMs or Docker.

## Why it matters
In 2021, researchers demonstrated that misconfigured `systemd-nspawn` containers with `--private-users=off` or excessive capability flags allowed container breakout to the host root. Defenders use `systemd-nspawn` for safe malware analysis sandboxes — spinning up an isolated Linux environment to detonate suspicious binaries without risking the host system.

## Key facts
- Uses Linux **kernel namespaces** (PID, network, mount, UTS) for isolation — not a hypervisor; the host kernel is shared, making kernel exploits a legitimate escape vector
- By default, containers run as **root inside = root outside**, meaning a container escape immediately yields host root unless `--private-users` (user namespace mapping) is enabled
- Unlike Docker, `systemd-nspawn` is invoked as `systemd-nspawn -D /path/to/rootfs` and integrates directly with `machinectl` for lifecycle management
- **Capability dropping** is critical: running without `--capability=` restrictions leaves dangerous capabilities like `CAP_SYS_ADMIN` available, enabling mount-based escape techniques
- Isolation is weaker than VMs — a host kernel vulnerability (e.g., a dirty pipe-style flaw) can be exploited from inside the container to achieve full host compromise

## Related concepts
[[Linux Namespaces]] [[Container Security]] [[Privilege Escalation]] [[chroot Jails]] [[Capability-Based Security]]