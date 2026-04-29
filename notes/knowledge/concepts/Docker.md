# Docker

## What it is
Think of Docker like a lunchbox that contains not just your sandwich, but also the plate, utensils, and napkin — everything needed to eat lunch, anywhere, without borrowing from the kitchen. Docker is a containerization platform that packages an application and all its dependencies into isolated, portable units called containers, which share the host OS kernel but remain logically separated from each other and the host.

## Why it matters
A misconfigured Docker deployment is a common real-world attack vector — specifically, an exposed Docker daemon socket (`/var/run/docker.sock`) on a host allows an attacker with container access to mount the host filesystem, escalate privileges, and fully compromise the underlying server. Defenders must audit container configurations for privileged mode flags (`--privileged`) and socket mounts, which effectively dissolve the container boundary entirely.

## Key facts
- Containers share the host OS kernel, making them lighter than VMs but providing **weaker isolation** — a kernel exploit can affect all containers on the host
- Running a container with `--privileged` grants it near-full host capabilities, essentially defeating containerization as a security boundary
- Docker images are built from layered instructions in a **Dockerfile**; hardcoded secrets in any layer remain recoverable via `docker history` even if deleted in a later layer
- The **Docker daemon runs as root by default** — compromising it equals root on the host; rootless Docker mode mitigates this
- Container images should be scanned for CVEs using tools like **Trivy** or **Clair** before deployment — outdated base images are a persistent vulnerability source

## Related concepts
[[Containerization]] [[Privilege Escalation]] [[Least Privilege]] [[Vulnerability Scanning]] [[Virtual Machines]]