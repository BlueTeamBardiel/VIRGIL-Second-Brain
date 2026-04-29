# hypervisor

## What it is
Like a hotel manager who rents out identical rooms to different guests while ensuring they can't wander into each other's spaces, a hypervisor is software that creates and manages multiple virtual machines (VMs) on a single physical host. Each VM gets its own slice of CPU, memory, and storage while remaining isolated from its neighbors. Type 1 hypervisors (bare-metal) run directly on hardware; Type 2 hypervisors run on top of a host OS.

## Why it matters
In a **VM escape attack**, a malicious actor exploits a vulnerability in the hypervisor to break out of their guest VM and gain access to the host system or other VMs — effectively bypassing all tenant isolation. The 2015 VENOM vulnerability (CVE-2015-3456) demonstrated this: a flaw in QEMU's virtual floppy disk controller allowed attackers to escape the guest and execute arbitrary code on the host, potentially compromising every VM on that server.

## Key facts
- **Type 1 (bare-metal):** Runs directly on hardware (VMware ESXi, Microsoft Hyper-V, Xen) — smaller attack surface, used in enterprise/cloud
- **Type 2 (hosted):** Runs on a host OS (VirtualBox, VMware Workstation) — more attack surface because the host OS itself can be compromised first
- **VM escape** is the highest-severity hypervisor attack; success means an attacker owns the entire physical host and all VMs
- **Hyperjacking** is a stealthy attack where malware installs a rogue hypervisor beneath a legitimate OS, making the real OS a guest without its knowledge
- Cloud providers like AWS and Azure rely on hardened Type 1 hypervisors as the primary isolation boundary between customer workloads

## Related concepts
[[virtual machine]] [[VM escape]] [[cloud security]] [[containerization]] [[privilege escalation]]