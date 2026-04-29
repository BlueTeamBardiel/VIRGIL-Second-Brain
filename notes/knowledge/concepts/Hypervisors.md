# Hypervisors

## What it is
Like a landlord who divides a single house into multiple apartments — each tenant lives in their own isolated unit, unaware of the others sharing the same foundation — a hypervisor is software that partitions one physical machine into multiple isolated virtual machines (VMs). Precisely: a hypervisor is a virtualization layer that abstracts hardware resources and allocates them to guest operating systems, each believing it has exclusive access to the hardware beneath it.

## Why it matters
In cloud environments, hypervisors are the critical security boundary separating one customer's VM from another's on the same physical host. A "VM escape" attack — where malicious code in a guest VM breaks out of its isolation and gains code execution on the hypervisor or adjacent VMs — is one of the most dangerous exploits in cloud security. The 2015 VENOM vulnerability (CVE-2015-3456) demonstrated this by exploiting a flaw in QEMU's virtual floppy controller to escape the guest entirely.

## Key facts
- **Type 1 (bare-metal) hypervisors** run directly on hardware (e.g., VMware ESXi, Microsoft Hyper-V, Xen) and are more performant and secure than Type 2
- **Type 2 (hosted) hypervisors** run atop a conventional OS (e.g., VirtualBox, VMware Workstation) — the host OS becomes an additional attack surface
- **VM escape** is the highest-severity hypervisor threat; it breaks the foundational isolation guarantee of virtualization
- **Hypervisor-based rootkits** (e.g., Blue Pill) insert themselves below the OS, making detection from within the guest nearly impossible
- Type 1 hypervisors are used in **VDI (Virtual Desktop Infrastructure)**, cloud platforms (AWS Nitro, Azure Hyper-V), and security sandboxing environments

## Related concepts
[[Virtual Machines]] [[VM Escape]] [[Cloud Security]] [[Containerization]] [[Rootkits]]