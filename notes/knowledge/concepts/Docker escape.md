# Docker escape

## What it is
Imagine a prisoner escaping their cell not by breaking the bars, but by exploiting a flaw in the prison's shared plumbing system that connects all cells to the warden's office. A Docker escape is when an attacker running code inside a container exploits a vulnerability or misconfiguration to break out of the container's isolation and gain access to the underlying host operating system or other containers.

## Why it matters
In 2019, a critical vulnerability (CVE-2019-5736) in **runc** — the container runtime used by Docker — allowed a malicious container to overwrite the host's runc binary, granting full root access to the host. A single compromised microservice in a Kubernetes cluster could pivot to owning every workload running on that node, turning a contained breach into a full infrastructure takeover.

## Key facts
- **Privileged containers** (`--privileged` flag) are the most common escape vector; they grant the container nearly identical capabilities to the host, including mounting the host filesystem.
- **Exposed Docker sockets** (`/var/run/docker.sock` mounted inside a container) allow an attacker to spawn new privileged containers, effectively escaping confinement.
- **Kernel vulnerabilities** are the deepest escape path — since all containers share the host kernel, a kernel exploit (e.g., Dirty COW, CVE-2016-5195) bypasses container namespacing entirely.
- **Namespace and cgroup misconfigurations** are the architectural controls that *prevent* escapes; escapes succeed when these boundaries are improperly configured.
- Defense includes running containers as non-root, using **seccomp profiles**, enabling **AppArmor/SELinux**, and scanning images with tools like Trivy or Falco for runtime anomalies.

## Related concepts
[[Container security]] [[Privilege escalation]] [[Kernel exploitation]] [[Namespace isolation]] [[Least privilege]]