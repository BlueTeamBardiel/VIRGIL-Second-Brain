# Proxmox

## What it is
Think of Proxmox like a hotel building that houses hundreds of separate rooms (VMs and containers), each with its own locks and guests, all managed from a single front desk. Precisely: Proxmox Virtual Environment (PVE) is an open-source Type 1 bare-metal hypervisor built on Debian Linux, combining KVM (full virtualization) and LXC (container-based virtualization) with a centralized web management interface.

## Why it matters
In enterprise environments, a misconfigured Proxmox node exposes a powerful web GUI (default port 8006) that — if left with default credentials or no MFA — gives an attacker full control over every virtual machine on the host, enabling mass ransomware deployment across all guests in minutes. Defenders use Proxmox's built-in snapshot and backup features to create rapid recovery points, which is a critical ransomware resilience strategy.

## Key facts
- Proxmox runs on **port 8006** (HTTPS) for its web interface; exposure of this port to the internet without access controls is a high-severity misconfiguration
- Supports both **KVM** (full VM isolation with separate kernels) and **LXC containers** (shared kernel, lighter but smaller attack surface boundary)
- **VM escape vulnerabilities** are a top concern — a compromised guest VM could potentially break out to the Proxmox host, compromising all sibling VMs
- Proxmox uses **role-based access control (RBAC)** with realms including PAM, PVE internal users, and LDAP integration
- The **Proxmox Backup Server (PBS)** supports immutable backups via datastore protection, a direct defense against backup-targeting ransomware

## Related concepts
[[Hypervisor Security]] [[VM Escape]] [[Virtualization]] [[Container Security]] [[Type 1 vs Type 2 Hypervisor]]