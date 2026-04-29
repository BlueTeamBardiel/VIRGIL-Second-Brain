# Docker Security

## What it is
Think of Docker containers like food trucks sharing a city street (the host kernel) — they're separate businesses with their own menus, but they all rely on the same underlying infrastructure. Docker security is the practice of hardening containerized environments by isolating workloads, limiting privileges, and ensuring that a compromised container cannot escape to the host OS or neighboring containers.

## Why it matters
In 2019, attackers exploited a vulnerability in `runc` (CVE-2019-5736) that allowed a malicious container to overwrite the host's `runc` binary, achieving full host compromise — a classic **container escape**. Defenders mitigate this by running containers as non-root users, applying seccomp profiles, and keeping container runtimes patched.

## Key facts
- **Containers are NOT VMs** — they share the host kernel, so a kernel exploit can break container isolation entirely
- Running containers with `--privileged` flag grants nearly full host access; this should almost never be used in production
- **Image scanning** (e.g., Trivy, Clair) detects known CVEs in base images *before* deployment — shift-left security
- Docker daemon runs as **root by default**; rootless Docker or Podman reduces the attack surface significantly
- Secrets should never be baked into Docker images (visible via `docker history`); use Docker Secrets or external vaults like HashiCorp Vault instead
- The **CIS Docker Benchmark** is the standard hardening checklist used in enterprise and exam contexts

## Related concepts
[[Container Escape]] [[Principle of Least Privilege]] [[Vulnerability Scanning]] [[Secrets Management]] [[Linux Namespaces]]