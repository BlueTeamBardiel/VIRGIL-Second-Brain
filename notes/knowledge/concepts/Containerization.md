# Containerization

## What it is
Think of containerization like shipping containers on a cargo ship — each sealed metal box carries its own goods and can't contaminate adjacent boxes, yet they all share the same ship. In computing, containerization packages an application and its dependencies into an isolated unit (a container) that shares the host OS kernel but runs in its own namespaced environment. Docker and Kubernetes are the dominant platforms implementing this model.

## Why it matters
In 2019, attackers compromised a misconfigured Docker API exposed to the internet, deployed cryptomining containers, and escaped to the host by mounting the host filesystem inside a privileged container. This illustrates the critical threat: containers provide *process isolation*, not full virtualization — a privileged container or kernel vulnerability can allow container escape, giving attackers host-level access across every workload on the machine.

## Key facts
- Containers share the **host OS kernel** — unlike VMs, there is no hypervisor layer, making kernel exploits a direct path to container escape
- **Privileged containers** (`--privileged` flag in Docker) disable most namespace isolation and are a known high-risk misconfiguration
- **Image supply chain attacks** target public registries (Docker Hub); malicious base images can backdoor every container built from them
- The **principle of least privilege** applies: containers should run as non-root users and use read-only filesystems where possible
- **Namespaces** (PID, network, mount, IPC) and **cgroups** are the two Linux kernel features that technically implement container isolation

## Related concepts
[[Virtual Machines]] [[Privilege Escalation]] [[Supply Chain Attacks]] [[Least Privilege]] [[Microservices Security]]