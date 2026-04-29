# VMware

## What it is
Like a magician running multiple puppet shows simultaneously on one stage — each puppet thinks it's the only show in town. VMware is a **Type 1 or Type 2 hypervisor platform** that creates isolated virtual machines (VMs) sharing a single physical host's hardware resources. Each VM runs its own OS and applications, unaware of its neighbors.

## Why it matters
In 2021–2022, attackers deploying **ESXiArgs ransomware** specifically targeted VMware ESXi servers, encrypting VM disk files (.vmdk) across thousands of organizations simultaneously — one compromised hypervisor meant every VM on that host was at risk. This "hypervisor jackpot" attack illustrates why VM escape vulnerabilities and hypervisor hardening are critical defensive priorities.

## Key facts
- **VM Escape** is the critical threat: malicious code breaks out of a guest VM to access the hypervisor or other VMs — CVE-2021-22045 (VMware SVGA) is a real example
- **VMware ESXi** is a Type 1 (bare-metal) hypervisor; **VMware Workstation** is Type 2 (runs on top of a host OS)
- Shared resources create **side-channel attack** opportunities — a compromised VM can potentially infer data from neighboring VMs via CPU cache timing
- **Snapshot files** (.vmem, .vmsn) contain memory captures that may hold credentials, encryption keys, or sensitive data in plaintext
- Security best practice: enable **VM isolation settings** (disable shared clipboard, drag-and-drop, and VMware Tools features not required)

## Related concepts
[[Hypervisor Security]] [[VM Escape]] [[Side-Channel Attacks]] [[Containerization]] [[Cloud Security]]