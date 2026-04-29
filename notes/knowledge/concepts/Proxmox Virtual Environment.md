# Proxmox Virtual Environment

## What it is
Think of it as a master switchboard operator running multiple phone calls simultaneously on the same hardware — each call isolated, but all sharing the same physical infrastructure. Proxmox VE is an open-source, bare-metal hypervisor platform that combines KVM (Kernel-based Virtual Machine) for full virtualization and LXC (Linux Containers) for lightweight containerization, managed through a centralized web interface.

## Why it matters
In enterprise blue-team environments, Proxmox is frequently used to host isolated malware analysis sandboxes and honeypots — spinning up a fresh VM snapshot after each detonation to prevent cross-contamination. Conversely, attackers who compromise a Proxmox host gain a hypervisor-level foothold, enabling VM escape attacks or mass snapshot theft, which can expose credentials and sensitive data across every hosted guest simultaneously.

## Key facts
- Proxmox uses **role-based access control (RBAC)** with granular permissions — misconfigured API tokens are a common attack vector granting full cluster control
- The **web GUI runs on port 8006** over HTTPS; exposing this port to the internet without MFA is a critical misconfiguration frequently found in threat intel reports
- **Snapshot and backup files (.vma format)** contain full disk images — an attacker exfiltrating these offline can mount and extract secrets without ever touching the live system
- Proxmox supports **cluster federation**, meaning one compromised node can pivot laterally to all nodes sharing the cluster trust relationship
- As a **Type 1 (bare-metal) hypervisor**, compromise occurs below the OS layer, making traditional endpoint detection tools on guest VMs blind to host-level intrusions

## Related concepts
[[Hypervisor Security]] [[VM Escape]] [[Virtualization Hardening]] [[Containerization Security]] [[Privileged Access Management]]