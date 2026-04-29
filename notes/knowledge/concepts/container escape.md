# container escape

## What it is
Like a prisoner discovering a loose brick that leads not just out of their cell, but out of the entire prison — a container escape occurs when a process inside a containerized environment (like Docker) exploits a vulnerability to break out of its isolated namespace and gain access to the underlying host OS. The attacker moves from limited container privileges to potentially full root access on the host machine.

## Why it matters
In 2019, a critical Docker vulnerability (CVE-2019-5736) allowed a malicious container to overwrite the host's `runc` binary — the tool Docker uses to spawn containers — giving attackers persistent root access to the host. This meant a single compromised container could compromise every other container running on that host, turning one small breach into a full infrastructure takeover.

## Key facts
- **Privileged containers** are a primary escape vector: running `docker run --privileged` disables most namespace isolation, making escape trivial
- **Mounted Docker socket** (`/var/run/docker.sock`) inside a container is effectively game over — it lets the container spawn new privileged containers on the host
- **Kernel exploits** work because all containers on a host share the same kernel; a kernel vuln exploitable from one container affects all
- **Namespace and cgroup misconfigurations** are root causes — containers rely on Linux namespaces (PID, network, mount) for isolation, not hypervisor-level hardware boundaries
- Defense includes **seccomp profiles**, **AppArmor/SELinux policies**, running containers as **non-root users**, and using **rootless container** engines like Podman

## Related concepts
[[privilege escalation]] [[namespace isolation]] [[Docker security]] [[kernel exploitation]] [[least privilege]]