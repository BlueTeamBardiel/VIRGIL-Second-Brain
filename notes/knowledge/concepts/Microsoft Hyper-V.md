# Microsoft Hyper-V

## What it is
Like a hotel that rents out identical rooms to different guests while keeping each room completely private from the others, Hyper-V is Microsoft's Type-1 (bare-metal) hypervisor that creates and manages isolated virtual machines directly on Windows Server or Windows 10/11 hardware. It sits between the physical hardware and guest operating systems, allocating CPU, memory, and storage resources to each VM independently.

## Why it matters
In 2024, CVE-2024-21407 allowed an authenticated attacker inside a Hyper-V guest VM to execute arbitrary code on the *host* machine — a classic **VM escape** vulnerability that collapsed the hotel-wall isolation entirely. This class of attack is critical because organizations use Hyper-V to isolate sensitive workloads (e.g., domain controllers in VMs), and a single escape can compromise the entire physical host and every VM running on it.

## Key facts
- **Type-1 vs Type-2**: Hyper-V is Type-1 (bare-metal); it runs directly on hardware, not inside a host OS like VMware Workstation (Type-2), making it faster but a higher-value attack target
- **VM Escape** is the primary threat model — malicious code in a guest VM exploiting the hypervisor to reach the host or other guests
- **Secure Boot and vTPM** are Hyper-V features that protect VM integrity and support BitLocker inside guest VMs
- **Hyper-V Isolation** is used by Windows Defender Application Guard (WDAG) and Windows Sandbox to run untrusted content in throwaway VMs
- **CVE scoring context**: VM escape vulnerabilities consistently score CVSS 8.0+ because confidentiality, integrity, and availability of the *entire host* are at risk

## Related concepts
[[Virtualization Security]] [[VM Escape]] [[Type-1 vs Type-2 Hypervisor]] [[Windows Defender Application Guard]] [[Privilege Escalation]]