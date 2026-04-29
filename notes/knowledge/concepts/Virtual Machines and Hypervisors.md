# Virtual Machines and Hypervisors

## What it is
Like a theater stage that can be rapidly reconfigured to look like a kitchen, a courtroom, or a spaceship — a virtual machine (VM) is a software-defined computer running inside a real one, completely isolated from other "stages" sharing the same hardware. A **hypervisor** is the stage manager: software (Type 1 runs on bare metal, Type 2 runs atop a host OS) that allocates CPU, memory, and storage to each VM while enforcing boundaries between them. Multiple VMs share one physical machine without knowing each other exists.

## Why it matters
Malware analysts detonate suspicious files inside disposable VMs — if ransomware executes and encrypts everything, you simply delete the VM and restore the snapshot. However, sophisticated malware like the **Equation Group's** tools performs VM detection checks (inspecting CPU timing, registry artifacts, or hardware fingerprints) and stays dormant when it suspects a sandboxed analysis environment, actively evading this defense.

## Key facts
- **Type 1 hypervisors** (VMware ESXi, Hyper-V, Xen) run directly on hardware — smaller attack surface, used in enterprise/cloud
- **Type 2 hypervisors** (VirtualBox, VMware Workstation) run on a host OS — convenient for analysts, but inherit the host OS's vulnerabilities
- **VM escape** is the critical attack: malware breaks out of the VM boundary to compromise the hypervisor or host — CVE-2018-3646 (L1TF) demonstrated this via CPU speculation flaws
- **Snapshots** enable forensic rollback, making VMs ideal for malware detonation chambers and security testing
- Cloud environments (AWS, Azure) are entirely hypervisor-dependent — a hypervisor compromise is catastrophic, affecting all tenant VMs simultaneously (**VM sprawl** increases the attack surface)

## Related concepts
[[Sandboxing]] [[Cloud Security]] [[Containerization]]