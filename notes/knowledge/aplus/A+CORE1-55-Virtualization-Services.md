# Virtualization Services

## What it is

You've got a gaming rig with 64GB of RAM, a Ryzen 9, and an RTX 4080 sitting at 8% utilization while you read Discord. That hardware is a body with way more organs than the workload needs. Virtualization is how you carve that body into multiple smaller bodies — each one believing it's the whole machine, none of them aware of the others, all of them sharing the same CPU, RAM, and storage underneath.

In plain English: virtualization lets one physical computer pretend to be many computers. Each pretend computer (a **virtual machine**, or VM) gets its own OS, its own disk, its own network identity. The thing that does the pretending is called a **hypervisor** — software that sits between the hardware and the guest OSes and lies convincingly to all of them.

Technical definition: virtualization abstracts physical compute, memory, storage, and network resources into logical units that can be partitioned, allocated, and isolated across multiple guest operating systems running concurrently on shared hardware.

## Why it matters

Every enterprise runs on this. Every cloud provider is virtualization at planetary scale. Your first sysadmin job will involve VMs before it involves anything else. CompTIA tests this hard because the line between "a server" and "a workload" disappeared a decade ago — you're not racking hardware for each app, you're spinning up a VM in vSphere or Hyper-V and moving on.

Exam relevance: **Objective 220-1201 4.1** — purpose of VMs, desktop virtualization (sandbox, VDI, test/dev, app virtualization), containers, hypervisor types (1 and 2, cross-platform), and the security/network/storage requirements that make virtualization actually work.

## In your build, in the enterprise

**Beat 1 — Technical depth.** A hypervisor allocates virtual CPUs (vCPUs) that map to physical cores via a scheduler, presents virtual disks as files (`.vmdk`, `.vhdx`, `.qcow2`) on the host filesystem, and exposes virtual NICs that bridge, NAT, or isolate from the host network. **Type 1 hypervisors** run directly on bare metal — they *are* the OS. VMware ESXi, Microsoft Hyper-V Server, Proxmox (KVM), Citrix XenServer. **Type 2 hypervisors** run as an application on top of a host OS. VMware Workstation, Oracle VirtualBox, Parallels Desktop. Type 1 wins on performance and density; Type 2 wins on convenience for a single tech testing things on a laptop. Hardware requirements: CPU virtualization extensions (Intel VT-x, AMD-V) for basic operation, IOMMU (Intel VT-d, AMD-Vi) for PCIe passthrough, and enough RAM that you're not constantly swapping. **Containers** share the host kernel and isolate only userspace — lighter, faster to start, but locked to the host kernel's OS family.

**Beat 2 — Feynman via your homelab.** You install **Proxmox** on an old Ryzen box with 64GB of RAM.

**The VDI experiment:** Spin up a Windows 11 VM, install it, snapshot it, clone it three times. Four desktops you can RDP into from your couch. *That's the seed of every VDI deployment in the world — one golden image, many clones.*

**The sandbox:** A friend sends you a "totally legit" cracked installer. Boot a throwaway Windows VM with networking disabled, run the file, watch it try to encrypt the C: drive. Revert to snapshot. *The malware never touched your real machine. The VM was the airlock.*

**The test/dev lane:** Learning Linux. Ubuntu, Debian, Fedora, Arch — four VMs, four shells, zero risk to your daily driver. *The cost of "I wonder what happens if I `rm -rf /`" drops to zero.*

**The container detour:** You don't want a full VM for Pi-hole. Install Docker, pull the container, running in 8 seconds. *Containers share the host kernel — no boot, no OS install, just the app and its dependencies in a box.*

**Beat 3 — Bridge to the enterprise.** Same hypervisor concept, different scale and stakes. Your homelab Proxmox box has one node, one disk, one network. The enterprise version is a **VMware vSphere cluster**: six ESXi hosts, shared SAN storage, redundant 10GbE networking, vMotion to migrate live VMs between hosts with zero downtime, DRS to auto-balance load, HA to restart VMs on a surviving host if one dies. Your homelab "snapshot before doing something dumb" becomes "Veeam takes application-consistent snapshots of 400 production VMs every four hours and replicates them to the DR site." Your VDI experiment becomes **Citrix or VMware Horizon** serving 5,000 employee desktops from a datacenter. Your sandbox VM becomes a **detonation chamber** in the SOC where every suspicious email attachment gets exploded before reaching a user. Your Docker tinkering becomes a **Kubernetes cluster** running microservices across 40 nodes.

**Beat 4 — The point.** Same fundamental question every time: *what workload am I running, what does it actually need, and what's the cheapest, safest, most reliable way to give it those resources?* The right answer for your homelab is a Type 2 hypervisor on a desktop. For a small business, a single Hyper-V host. For an enterprise, a vSphere cluster. For a web app at scale, containers on Kubernetes. Get this question into your bones — you'll ask it for the rest of your career.

## Key facts

### Hypervisor types

| Type | Runs on | Examples | Use case |
|---|---|---|---|
| **Type 1 (bare metal)** | Directly on hardware | VMware ESXi, Hyper-V Server, Proxmox (KVM), XenServer | Production servers, datacenters, enterprise |
| **Type 2 (hosted)** | On top of a host OS | VMware Workstation, VirtualBox, Parallels, Hyper-V on Windows 11 | Developer laptops, training, test/dev on a daily driver |

**Cross-platform:** Most hypervisors run guest OSes different from the host. ESXi runs Windows and Linux guests. Parallels on Apple Silicon runs ARM Windows and ARM Linux. The guest doesn't know it's a guest.

### Purposes of VMs

- **Server consolidation** — one physical box, many logical servers
- **Isolation** — one VM crashing doesn't take down the others
- **Snapshots and rollback** — revert to a known-good state in seconds
- **Portability** — a VM is a file; it moves between hosts trivially
- **Disaster recovery** — failover is restoring from replication, not rebuilding from bare metal

### Desktop virtualization flavors

| Flavor | What it is | Example |
|---|---|---|
| **VDI** | Full desktop OS in a datacenter VM, accessed remotely | Citrix, VMware Horizon, Azure Virtual Desktop |
| **Sandbox** | Isolated VM for untrusted code or risky testing | Windows Sandbox, malware analysis VMs |
| **Test/dev** | Disposable environments to break things safely | Vagrant-managed VMs |
| **Application virtualization** | Just the app is virtualized, streamed to the user | Microsoft App-V, Citrix published apps |

App virtualization is the lightweight cousin of VDI: instead of streaming a full desktop, you stream one app. The user sees Excel; it's actually running on a server somewhere.

### Containers vs VMs

| | VM | Container |
|---|---|---|
| **OS** | Full guest OS per VM | Shares host kernel |
| **Boot time** | Seconds to minutes | Milliseconds |
| **Size on disk** | GBs | MBs |
| **Isolation** | Strong (separate kernel) | Weaker (kernel shared) |
| **Use case** | Different OS, strong isolation, legacy apps | Microservices, stateless apps, dense deployment |

**Legacy software/OS** is where VMs beat containers cold. Ancient Windows XP app running a CNC machine on the factory floor. Can't put XP on the modern network. Run XP in an isolated VM on a modern Hyper-V host, no network access except to the machine. The VM is the time capsule that keeps the business running.

### Requirements

**Security:**
- VM escape (guest breaking out to host) is the nightmare scenario — patch your hypervisor like your job depends on it
- Network segmentation between VMs is not automatic — configure vSwitches and VLANs deliberately
- Snapshots are not backups — a corrupted VM's snapshot chain is still corrupted
- Encrypt VM disk files at rest; the `.vmdk` is just a file someone could copy
- Harden hypervisor management interfaces (vCenter, Hyper-V Manager) — host access = god mode over every guest

**Network:**
- Virtual switches connect VMs to each other and to the physical network
- Bridge, NAT, host-only, and isolated modes — each has security implications
- Production hosts need redundant teamed physical NICs
- 10GbE minimum for serious clusters; 25/40/100GbE for high-density and storage traffic

**Storage:**
- Local storage works for homelab; enterprise wants shared storage (SAN via FC/iSCSI, NAS via NFS) so VMs can migrate
- IOPS matter more than capacity — NVMe/SSD for hot data, spinning rust for cold archive
- Thin provisioning over-allocates disk; thick reserves it upfront. Thin saves space, thick avoids "I ran out of disk and 200 VMs froze"

### CompTIA exam traps

> **CompTIA exam trap:** Type 1 vs Type 2. Type 1 = bare metal = ESXi, Hyper-V Server, Proxmox. Type 2 = hosted = VirtualBox, VMware Workstation. Hyper-V is the confusing one: **Hyper-V Server is Type 1; Hyper-V as a feature on Windows 11 is Type 2-ish but technically Type 1 architecture under the hood.** Treat the standalone product as Type 1, the desktop app as Type 2.

> **CompTIA exam trap:** Containers ≠ VMs. "Shares the host kernel" / "lightweight" / "microservices" → containers. "Full guest OS" / "different OS than host" / "strong isolation" → VMs.

> **CompTIA exam trap:** VDI is not "remote desktop." RDP to a physical PC is not VDI. VDI means a *virtual* desktop running in a datacenter hypervisor, served to thin clients or remote users.

> **CompTIA exam trap:** Hardware requirement = CPU virtualization extensions (Intel VT-x or AMD-V) enabled in BIOS/UEFI. The "I can't install a 64-bit guest" error in VirtualBox is almost always this setting turned off.

## Helpdesk reality

- *"My VM is slow."* → Check vCPU oversubscription, RAM ballooning, and disk IOPS contention on the host. One noisy VM can starve the others.
- *"I can't install VirtualBox / Hyper-V won't start."* → Virtualization disabled in BIOS/UEFI. Enable VT-x or AMD-V. Also: Hyper-V and VirtualBox fight each other on the same Windows host — pick one.
- *"My snapshot grew to 400GB and the datastore is full."* → Snapshots aren't free. They're delta files that grow with every write. Consolidate or delete the chain. Production VMs should not live on snapshots for weeks.
- *"The VDI desktop logs me out every time the Wi-Fi blips."* → Session persistence is a network/profile design issue. Escalate to the VDI team with timestamps.
- *"Can I run macOS in a VM on my Windows machine?"* → Against Apple's EULA on non-Apple hardware. Don't promise it, don't help with it, don't put it in writing.

## Related concepts

[[Cloud Computing Models]] · [[Hypervisor Security]] · [[CPU Virtualization Extensions]] · [[RAID]] · [[SAN and NAS Storage]] · [[Containers and Kubernetes]] · [[Backup Strategies]] · [[VDI and Thin Clients]]

*Source: VIRGIL knowledge base — 2026-05-10*