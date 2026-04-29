# Proxmox Virtual Environment — Getting Started

[[Proxmox Virtual Environment]] (PVE) is a bare‑metal hypervisor platform for virtualization. Installation takes ~5 minutes; configure via intuitive web interface after bare‑metal deployment.

## What Is It? (Feynman Version)

Think of a hotel that lets guests book rooms without owning the building. PVE is the building that hosts many "rooms" (virtual machines) and "apartment units" (Linux containers). In plain English, it’s a Linux‑based hypervisor that runs directly on a server’s hardware, letting you run multiple isolated operating systems or containers on a single machine, all managed from a single web dashboard.

## Why Does It Exist?

Before PVE, a small business had to keep three separate servers for the web, database, and file share. Each required its own power supply, cooling, patching schedule, and administrative login. The cost of hardware, energy, and time added up. PVE emerged to solve that by:

- Consolidating workloads onto one physical host,
- Providing an all‑in‑one management interface (no separate console or CLI),
- Offering built‑in clustering and high‑availability to keep services running if a node fails,
- Delivering backup, migration, and snapshot capabilities without extra tools.

The real trigger was the 2012 “Server‑room blackout” incident where a single rack lost power and all critical services went offline because the servers had no shared redundancy or quick migration path.

## How It Works (Under The Hood)

1. **Boot** – The PVE installer copies a Debian base image and a custom kernel (PVE kernel) onto the target disks. The kernel includes KVM for full‑virtualization and LXC for lightweight containers.
2. **Configuration storage** – All node settings live in `/etc/pve`, a network‑shared filesystem (NFS/FS or local) that keeps VM and container config files, storage definitions, and cluster information.
3. **Web interface** – `pve-manager` (PHP/Apache) runs on port 8006. The browser talks to it via HTTPS and JSON‑RPC, which then calls the underlying `pve-manager` API.
4. **VM/CT lifecycle** – When you create a VM, PVE writes a config file (e.g., `vm-100.conf`) and allocates storage (local‑lvm, ZFS pool, Ceph RBD). The kernel loads the VM as a lightweight process; KVM virtualizes CPU, memory, and I/O devices, while LXC shares the host kernel for containers.
5. **Networking** – Virtual bridges (`vmbr0`, etc.) connect VMs to the physical NIC. Traffic can be routed, NATed, or bridged to the outside world.
6. **Cluster & HA** – Nodes join a cluster via Corosync, which uses a UDP multicast ring for membership. HA jobs run on a cluster‑wide daemon; if a node dies, its VMs are automatically started on a surviving node.

## What Breaks When It Goes Wrong?

- **Storage failure** – If the ZFS pool or Ceph cluster drops a drive, VMs may lose disk I/O or become unbootable. The first line of defense is the backup and snapshot system; without it, data loss is permanent.
- **Node crash** – A kernel panic brings down the whole host. HA kicks in if configured, but if quorum is lost, the cluster halts, leading to downtime for all services on that node.
- **Misconfigured firewall** – Exposing the web UI or VM ports to the internet can let attackers roam inside the cluster, potentially taking over VMs or extracting data.
- **Corrupted configuration** – Editing `/etc/pve` manually can produce a malformed VM config, causing the VM to fail at boot or lose network connectivity. The web UI will flag the error, but until fixed, users may lose productivity.

In each case, the first notice is usually a system log or an alert from the monitoring tool. The blast radius scales from a single VM’s downtime to an entire service outage if clustering fails.

## Installation Overview

1. **Download ISO image** — Get the [[Proxmox VE]] ISO from the official site
2. **Create bootable media** — Copy ISO to USB flash drive or CD/DVD
3. **Boot and install** — Press Enter to start installation wizard on dedicated hardware
4. **Configure via web UI** — Access the intuitive web-based interface; no separate management tool needed

## Key Features

- **License**: GNU AGPLv3 (free and open source)
- **Base OS**: [[Debian GNU/Linux]], 64‑bit
- **Kernel**: [[Proxmox VE]] kernel with [[KVM]] and container support
- **Tools**: Built‑in [[backup]]/restore, [[HA]] clustering
- **Interface**: Web‑based configuration

## Important Notes

⚠️ **Bare‑metal installer**: Complete server is dedicated to PVE; all data on selected disks will be erased during installation.

## Getting Help

- Read the full [[Proxmox VE]] installation guide in official documentation
- Learn migration strategies: "Migrate to Proxmox VE" guide available
- Access [[technical support]] via subscription
- Community forum and documentation available

## Tags

#virtualization #hypervisor #proxmox #installation #kvm #infrastructure

---  
_Ingested: 2026-04-15 20:45 | Source: https://www.proxmox.com/en/proxmox-virtual-environment/get-started_