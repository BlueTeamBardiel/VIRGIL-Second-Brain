# containerized

## What it is
Think of a shipping container on a cargo ship — it holds everything the cargo needs (its own tools, environment, dependencies) and can be moved anywhere without affecting other containers or the ship itself. Containerization is the same idea applied to software: applications are bundled with their dependencies into isolated user-space instances (containers) that share the host OS kernel but remain logically separated from each other.

## Why it matters
In a real-world attack scenario, an attacker who compromises a vulnerable web application running in a Docker container faces a significant barrier — escaping the container namespace to reach the host OS or other containers requires a separate privilege escalation exploit (container escape). Conversely, defenders use containers to implement micro-segmentation, limiting blast radius so that a compromised service cannot freely pivot across the entire server environment.

## Key facts
- Containers share the **host kernel** — unlike VMs, there is no hypervisor, making container escapes (e.g., CVE-2019-5736 runc exploit) a critical attack vector
- The **principle of least privilege** applies: containers should run as non-root users and drop unnecessary Linux capabilities
- **Image integrity** matters — supply chain attacks target public registries (e.g., Docker Hub) with malicious or backdoored images
- Container orchestration platforms like **Kubernetes** introduce additional attack surface: misconfigured RBAC, exposed API servers, and insecure pod security policies are common findings in CySA+ exam scenarios
- Runtime security tools (e.g., Falco, Sysdig) monitor **syscall behavior** inside containers to detect anomalies like unexpected shell spawning

## Related concepts
[[virtualization]] [[least privilege]] [[supply chain attack]] [[micro-segmentation]] [[privilege escalation]]