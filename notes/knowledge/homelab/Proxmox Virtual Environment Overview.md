# Proxmox Virtual Environment Overview

[[Proxmox Virtual Environment]] (Proxmox VE) is an open‑source virtualization platform that combines [[KVM]] hypervisor and [[LXC]] container technology. It provides a unified management interface for enterprise‑grade infrastructure automation and resource orchestration.

## What Is It? (Feynman Version)

Imagine a master chef who can whip up a full meal and also prepare a quick side dish, all while keeping an eye on every ingredient. Proxmox VE is that chef: it lets you run complete virtual machines and lightweight containers side by side, managing them from a single dashboard.

## Why Does It Exist?

Before Proxmox, a small business had two separate stacks: a VMware appliance for legacy apps and a Docker host for new services. Managing them meant juggling different consoles, licensing fees, and inconsistent backups. Proxmox solves this by unifying VMs, containers, storage, and networking under one umbrella, cutting operational overhead and streamlining disaster recovery.

## Core Capabilities

- **Virtualization**: Full [[KVM]]-based virtual machine support with live migration and HA clustering
- **Containerization**: [[LXC]] container management alongside traditional VMs
- **Storage**: Integrated [[Ceph]] storage backend with flexible storage configurations
- **Networking**: Software‑defined networking (SDN) with advanced network management
- **Backup & Recovery**: Enterprise backup solutions with incremental snapshots and fleecing support
- **Security**: [[Secure Boot]] support, resource mappings, and authentication realm sync
- **Monitoring**: Real‑time metrics, node summaries, and system reporting

## How It Works (Under The Hood)

1. **Node boot** – Each Proxmox node runs the Debian OS, installs the Proxmox VE packages, and exposes a web UI and REST API.  
2. **Resource pool** – The nodes register with the cluster’s **PVE‑Cluster** service (based on Corosync and Quorum). This keeps a shared state: which VMs exist, where they live, and their configuration.  
3. **Storage** – For each node, the Ceph cluster is mounted via RBD or iSCSI. VM disks and container templates are just files on that pool; the hypervisor treats them like any other block device.  
4. **Execution** – When you spin up a VM, Proxmox creates a virtual disk image, assigns a virtual CPU and memory slice, and hands the image to the host’s [[KVM]] driver. For a container, it spawns an LXC sandbox, mounts the filesystem, and assigns namespaces.  
5. **Networking** – The SDN fabric is built with Linux bridges, veth pairs, and Open vSwitch. Proxmox’s GUI maps virtual NICs to physical NICs or bond sets, and applies firewall rules via iptables/ebtables.  
6. **Live migration** – For a VM, the live‑migration API copies the RAM pages over the network while the guest continues running, then hands over the last page snapshot to the destination node. The source node stops the VM’s kernel context and the destination takes over.  
7. **High‑availability** – If a node fails, the cluster’s HA manager queries each resource’s **availability** flag. If a VM is marked *HA*, it is automatically started on another node, using the shared storage to get its disk.

## Notable Features (Recent Versions)

- **VMware Migration**: Direct import of [[VMware]] ESXi guests (v8.1+)
- **GPU Support**: [[NVIDIA]] live migration and mapped device support (v8.4+)
- **Trusted Platform Module**: TPM support for VMs (v7.3+)
- **Bulk Operations**: Datacenter‑wide bulk actions (v9.1+)
- **OVA Import**: Support for OVA appliance imports (v8.3+)
- **Backup Templates**: Customizable backup notes and templates
- **HA Clustering**: Resource scheduling with static load balancing

## What Breaks When It Goes Wrong?

When the cluster loses quorum, every node silently refuses to start new VMs or containers. This is like a team of carpenters who all stop building because they cannot agree on a design. Users notice a sudden halt in provisioning, and if backups are not scheduled, data loss can ripple into downtime for critical services. Misconfigured Ceph pools can lead to storage contention; a sudden spike in VM memory usage can cause the host to swap, turning fast I/O into a bottleneck. In the worst case, a buggy kernel update in the host can crash KVM, pulling all guest OSes down—like a power surge that tripped the building’s circuit breaker.

## Management & Support

- Enterprise and online support services available
- Community forum and open‑source development
- Training courses and certification options
- Partner ecosystem with reseller and integration partners

## Tags
#virtualization #infrastructure #KVM #containers #LXC #clustering #backup

---  
_Ingested: 2026-04-15 20:23 | Source: https://www.proxmox.com/en/proxmox-virtual-environment/overview_