# VMware Cloud Infrastructure Software

## What it is
Think of it as the operating system for a data center — just as Windows manages hardware resources for your laptop, VMware's stack manages compute, storage, and networking resources across thousands of physical servers simultaneously. VMware Cloud Infrastructure is a suite of products (vSphere, vSAN, NSX, vCenter) that enables organizations to create, manage, and secure virtualized and software-defined infrastructure at enterprise scale.

## Why it matters
In 2021–2022, attackers specifically targeted VMware ESXi hypervisors with ransomware (ESXiArgs campaign), encrypting virtual machine files across hundreds of organizations simultaneously — one compromised hypervisor meant every VM running on that host was at risk. This illustrates why hypervisor security is a critical attack surface: compromise the management layer and you own every workload sitting on top of it.

## Key facts
- **vCenter Server** is the centralized management console — if compromised (CVE-2021-21985, CVSS 9.8), attackers gain administrative control over the entire virtual environment
- **NSX** provides micro-segmentation: east-west traffic filtering between VMs on the same host, which traditional firewalls cannot see
- **ESXi** is the bare-metal hypervisor (Type 1) — it runs directly on hardware with no host OS, reducing attack surface but also limiting endpoint agent visibility
- **vSphere** hardening includes disabling unnecessary services (MOB, SNMP), enabling lockdown mode, and restricting shell access to the ESXi host
- VMware infrastructure components are **high-value lateral movement targets** — attackers use stolen vCenter credentials to deploy backdoors across all hosted VMs simultaneously

## Related concepts
[[Hypervisor Security]] [[Type 1 vs Type 2 Hypervisors]] [[Micro-segmentation]] [[Lateral Movement]] [[Privileged Access Management]]