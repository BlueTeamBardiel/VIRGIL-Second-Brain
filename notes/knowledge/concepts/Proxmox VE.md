# Proxmox VE

## What it is
Think of Proxmox VE as a Swiss Army knife bolted directly onto bare metal — it's a single platform that handles both full virtual machines *and* lightweight containers without needing a separate host OS underneath. Technically, it's an open-source Type 1 hypervisor built on Debian Linux, combining KVM (for VMs) and LXC (for containers) with a web-based management interface.

## Why it matters
Security labs and SOC teams frequently deploy Proxmox to isolate attacker and defender environments on a single physical server — running a vulnerable Windows target VM alongside a Kali attacker VM with network segmentation enforced at the hypervisor layer. Conversely, a misconfigured Proxmox node exposed to the internet with default credentials (admin/admin) becomes a catastrophic single point of failure: an attacker who compromises the hypervisor owns every VM running on it — a classic **VM escape to host** risk multiplied across the entire infrastructure.

## Key facts
- Proxmox uses **KVM** for full hardware virtualization and **LXC** for OS-level container isolation — two distinct isolation boundaries with different attack surfaces
- The web UI runs on **port 8006** over HTTPS; leaving this exposed without firewall rules or MFA is a critical misconfiguration
- **VLANs and virtual bridges** (vmbr) control inter-VM network traffic; improper bridge configuration can allow VM-to-VM lateral movement
- Proxmox supports **role-based access control (RBAC)** with granular permissions — principle of least privilege applies to VM operators vs. administrators
- Snapshots and **backup encryption** are built-in; unencrypted VM backups stored on shared storage are a high-value data exfiltration target

## Related concepts
[[Hypervisor Security]] [[VM Escape]] [[Network Segmentation]] [[Container Security]] [[Least Privilege]]