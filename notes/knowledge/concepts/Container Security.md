# Container Security

## What it is
Think of containers like shipping containers on a cargo ship — they share the same vessel (the host OS kernel) but are supposed to keep their contents isolated from each other. Container security is the practice of hardening these isolated application environments (Docker, Kubernetes, etc.) to prevent breakout, privilege escalation, and lateral movement between containers or into the host system.

## Why it matters
In 2019, a misconfigured Docker daemon exposed its API on TCP port 2375 without authentication, allowing attackers to deploy cryptomining containers and ultimately escape to the host by mounting the host filesystem inside a new privileged container. This pattern — exposed API plus privileged container — remains one of the most common container compromise chains seen in cloud environments today.

## Key facts
- **Container breakout** occurs when an attacker escapes the container namespace and gains access to the host OS; running containers as `--privileged` or mounting `/var/run/docker.sock` are primary vectors
- **Image hardening** involves using minimal base images (e.g., Alpine or distroless), scanning images for CVEs with tools like Trivy or Clair before deployment
- **Namespaces and cgroups** are the Linux kernel primitives that provide container isolation — they are NOT a security boundary equivalent to a hypervisor/VM
- **Kubernetes RBAC** misconfigurations are a leading attack surface; excessive ServiceAccount permissions can allow pod-to-cluster-admin escalation
- **Runtime security tools** (Falco, seccomp profiles, AppArmor) provide behavioral monitoring and syscall filtering to detect anomalous container activity at runtime

## Related concepts
[[Virtualization Security]] [[Kubernetes Security]] [[Privilege Escalation]] [[Least Privilege]] [[Image Scanning]]