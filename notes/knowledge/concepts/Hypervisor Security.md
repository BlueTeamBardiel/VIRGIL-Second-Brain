# Hypervisor Security

## What it is
Think of a hypervisor as the air traffic control tower at a busy airport — it manages multiple planes (VMs) flying in the same airspace, keeping them from colliding while controlling who lands where. Precisely, a hypervisor is software (or firmware) that creates and manages virtual machines by abstracting physical hardware, existing either directly on bare metal (Type 1, like VMware ESXi) or atop a host OS (Type 2, like VirtualBox). Securing it means protecting this control layer, because whoever owns the hypervisor owns every VM running beneath it.

## Why it matters
In 2015, researchers demonstrated "VENOM" (CVE-2015-3456), a vulnerability in the virtual floppy disk controller used by QEMU/KVM that allowed an attacker inside a guest VM to escape the sandbox and execute code on the host hypervisor — instantly compromising every other VM on that machine. This "VM escape" scenario is the nightmare threat model for cloud providers, since one compromised tenant could pivot to another's environment.

## Key facts
- **Type 1 hypervisors** (bare-metal: ESXi, Hyper-V, Xen) have a smaller attack surface than **Type 2** (hosted: VirtualBox, VMware Workstation), making them preferred in enterprise/cloud environments
- **VM escape** is the highest-severity hypervisor attack — breaking out of a guest VM to reach the host or sibling VMs
- **VM sprawl** is a management risk: unpatched, forgotten VMs accumulate vulnerabilities across the environment
- **Hyperjacking** is a theoretical attack where malicious code installs a rogue hypervisor beneath a legitimate OS, making detection nearly impossible
- Hypervisor logs and integrity checks (e.g., Secure Boot, TPM attestation) are critical detective controls for identifying tampering

## Related concepts
[[VM Escape]] [[Virtualization Security]] [[Cloud Security]] [[Privilege Escalation]] [[Containerization Security]]