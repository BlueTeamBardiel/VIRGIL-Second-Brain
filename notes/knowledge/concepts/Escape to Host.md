# Escape to Host

## What it is
Imagine a prisoner who doesn't just break out of their cell, but tunnels through the prison walls entirely and emerges outside the building. Escape to Host is a vulnerability where an attacker operating inside a virtual machine (VM) or container breaks out of that isolated environment and gains unauthorized access to the underlying hypervisor or physical host system. This collapses the fundamental security boundary that virtualization is designed to enforce.

## Why it matters
In 2015, the "VENOM" vulnerability (CVE-2015-3456) demonstrated this precisely: a flaw in the virtual floppy disk controller allowed an attacker inside a VM to execute arbitrary code on the host, potentially compromising every other VM running on the same physical server. Cloud providers take this class of vulnerability extremely seriously because one tenant escaping to the host means every neighboring tenant's data is at risk.

## Key facts
- **Hypervisor types matter**: Type 1 (bare-metal) hypervisors like VMware ESXi and Hyper-V have a smaller attack surface than Type 2 (hosted) hypervisors like VirtualBox, which run atop a conventional OS.
- **Common attack vectors**: Exploiting vulnerabilities in virtual device drivers, shared memory regions, or guest-to-host communication channels (e.g., VMware Tools).
- **Container escape is a variant**: Docker/Kubernetes container escapes (e.g., via runc CVE-2019-5736) follow the same principle but exploit OS-level namespace isolation rather than hypervisor boundaries.
- **Mitigation**: Keeping hypervisor software patched, minimizing exposed virtual hardware features, and applying least-privilege to VM configurations significantly reduces attack surface.
- **Defense-in-depth applies**: Even after escape, host-level endpoint detection, network segmentation, and privileged access controls can limit blast radius.

## Related concepts
[[Hypervisor Security]] [[Container Security]] [[Privilege Escalation]] [[Virtualization]] [[Lateral Movement]]