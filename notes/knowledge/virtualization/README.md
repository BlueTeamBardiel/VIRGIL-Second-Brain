# Virtualization — Running Multiple Machines on One
> Your homelab starts here. One machine can be an entire network.

Virtualization lets you run multiple isolated operating systems on a single physical machine. Each VM is independent — its own CPU allocation, RAM, disk, and network — but they all share the underlying hardware. This is how cloud providers work at scale, and it's how you run a 10-machine lab on one desktop.

---

## Core Concepts

### Hypervisor: The Virtualization Layer
A hypervisor sits between the hardware and the virtual machines. It manages resource allocation and isolation.

**Type 1 (Bare metal):** Runs directly on hardware. No host OS underneath. Better performance, used in production data centers and serious homelabs.

**Type 2 (Hosted):** Runs as an application on top of an existing OS (Windows, macOS, Linux). Slightly worse performance due to the extra OS layer. Easier to set up for desktop use.

### Virtual Machine vs Container

| | Virtual Machine | Container (Docker) |
|---|---|---|
| Isolation | Full OS per VM | Shared OS kernel |
| Overhead | High (each VM needs RAM for full OS) | Low (no OS overhead per container) |
| Boot time | Minutes | Seconds |
| Use case | Full OS testing, Windows/Linux mix, isolated network labs | Application deployment, microservices |
| Security isolation | Strong (separate kernel) | Weaker (shared kernel — container escape is possible) |

Use VMs when you need true OS isolation, different OS families, or a lab network. Use containers for running services. See [[Docker]] for container specifics.

### Snapshots
A snapshot captures the complete state of a VM at a point in time — disk, memory, CPU state. Restore the snapshot to return to that exact state.

**Lab rule:** Snapshot before every major change. Before installing software, before running exploit code, before joining a domain. Restoring a snapshot is faster than rebuilding.

```bash
# Proxmox snapshot via CLI
qm snapshot 101 pre-pentest --description "Before running Metasploit lab"
qm rollback 101 pre-pentest

# VMware: Snapshot Manager in GUI, or via vmrun
vmrun snapshot "path/to/vm.vmx" "pre-change"
vmrun revertToSnapshot "path/to/vm.vmx" "pre-change"
```

### Cloning
Copy a configured VM to create a new one. Two types:
- **Full clone:** Independent copy of the disk. Takes more space but the clone is self-contained.
- **Linked clone:** New VM shares the parent's disk (copy-on-write). Fast and space-efficient, but depends on the parent.

**Sysprep before cloning Windows VMs** — see [[Imaging]] for why. Each clone must have a unique SID.

---

## Type 1 Hypervisors

### Proxmox VE (Recommended for Homelabs)
Free, open source, enterprise-grade. Runs KVM for VMs and LXC for containers. Web UI manages everything.

**Why Proxmox for a homelab:**
- Free (community edition, no license fees)
- ZFS storage support — snapshots, compression, data integrity
- Clustering — link multiple nodes, live migrate VMs
- REST API — scriptable, automatable
- Active community, excellent documentation

**Install:** Download ISO from proxmox.com, write to USB, install to bare metal. Boots in ~10 min. Web UI at `https://YOURIP:8006`.

```bash
# Basic Proxmox CLI
qm list                    # list all VMs
qm status 101              # VM 101 status
qm start 101               # start VM
qm stop 101                # stop VM
qm snapshot 101 snap1      # snapshot

# Create VM from command line
qm create 200 --name kali --memory 4096 --cores 2 --net0 virtio,bridge=vmbr0
qm importdisk 200 kali-linux.qcow2 local-lvm
```

**Proxmox networking:**
- `vmbr0` — default bridge, connected to your physical NIC
- Create additional bridges for isolated lab networks (no uplink = internal only)
- VLAN-aware bridges for segmented networks

### VMware ESXi
Enterprise standard. Used in most corporate environments. Free tier (ESXi Hypervisor) is available but limited.

**Know ESXi because:** Most enterprise jobs assume familiarity. vSphere, vCenter, and ESXi are common in large environments.

**For a homelab:** Proxmox is better value (no license restrictions, better community support). Use ESXi if you specifically need VMware experience for a job target.

### Hyper-V
Built into Windows Server and Windows 10/11 Pro. No separate install needed.

```powershell
# Enable Hyper-V on Windows Pro
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

# Create a VM via PowerShell
New-VM -Name "DC01" -MemoryStartupBytes 4GB -Generation 2 -SwitchName "Default Switch"
Set-VMProcessor "DC01" -Count 2
Add-VMDvdDrive "DC01" -Path "C:\ISOs\WinServer2022.iso"
Start-VM "DC01"
```

**Best for:** [[Active Directory]] labs — Hyper-V on Windows Pro is the native environment for Windows Server VMs. Performance is excellent. No need for a separate hypervisor install.

---

## Type 2 Hypervisors

### VMware Workstation Pro (Now Free)
As of 2024, VMware Workstation Pro is free for personal use (requires Broadcom account). The best Type 2 hypervisor for Windows hosts.

**Advantages over VirtualBox:**
- Better hardware emulation (USB 3.0, USB controller, audio)
- Faster disk I/O
- Better nested virtualization support (VMs inside VMs)
- More reliable snapshots under heavy workloads

**Use for:** Windows lab with a mix of VMs, [[Kali Linux]], Windows Server. The right choice if your primary machine is Windows.

### VirtualBox
Free, open source, cross-platform (Windows/macOS/Linux). Slightly worse performance than VMware but zero cost and universally available.

**Use for:** Quick experiments, Linux VMs on any host, situations where you can't install VMware.

**Extension pack:** Download separately from virtualbox.org. Adds USB 2.0/3.0, RDP, disk encryption. Required for proper USB support.

### Windows Sandbox
Disposable, isolated Windows 10/11 environment built into Windows 10/11 Pro. Spins up in seconds, deleted on close.

```
Enable: Windows Features → Windows Sandbox
Launch: Start menu → Windows Sandbox
```

**Use for:** Opening suspicious files safely, testing installers, quick one-off tasks. Not a full VM — no persistence, no snapshots, no network isolation configuration. But incredibly fast for disposable testing.

---

## Lab Network Architecture

### Networking Modes

| Mode | VM-to-internet | VM-to-host | VM-to-VM |
|---|---|---|---|
| **NAT** | Yes (shared host IP) | Yes | Same NAT segment only |
| **Bridged** | Yes (own IP on LAN) | Yes | Yes (same physical network) |
| **Host-Only** | No | Yes | Yes (isolated segment) |
| **Internal** | No | No | Yes (fully isolated) |

**For a security lab:** Use host-only or internal networking for VMs that should be isolated from your main network. Your Kali Linux attack machine and your vulnerable target should never share a network with your production machines.

### Recommended Lab Network Setup

```
Physical machine (192.168.1.x)
│
├── vmbr0 (bridged) — management
│   ├── Proxmox management interface
│   └── Jump VM (clean Kali with internet access)
│
└── vmbr1 (host-only, no uplink) — lab network (10.10.10.0/24)
    ├── DC01 (Windows Server 2022)
    ├── Win10 Client (domain-joined)
    ├── Kali Linux (attack machine)
    └── Metasploitable (vulnerable target)
```

The lab network is completely isolated from your home network. The attack VM has no path to your actual machines.

---

## Vulnerable VMs for Practice

| Resource | What's There | Cost |
|---|---|---|
| **VulnHub.com** | 500+ downloadable vulnerable VMs | Free |
| **HackTheBox free** | Retired machines (writeups available) | Free |
| **Metasploitable 2/3** | Intentionally vulnerable Ubuntu/Windows | Free |
| **DVWA** | Damn Vulnerable Web Application — Docker | Free |
| **TryHackMe** | Browser-based vulnerable machines | Free/paid |

**Starting VulnHub path:**
1. Kioptrix Level 1 — very basic, good intro
2. Mr. Robot — medium difficulty, fun theme
3. HackLAB: Vulnix — Linux privilege escalation
4. DC series (DC-1 through DC-9) — structured progression

---

## Resource Planning

| Lab | Minimum RAM | Comfortable RAM |
|---|---|---|
| Single Kali + 1 target | 8 GB | 16 GB |
| AD lab (DC + 2 clients) | 12 GB | 24 GB |
| Full YOUR-LAB-style (10 VMs) | 32 GB | 64 GB |
| Proxmox with 6+ concurrent VMs | 16 GB | 32 GB |

RAM is the primary constraint. CPUs with VT-x/AMD-V support are required (virtually all modern CPUs have this). Storage: SSDs dramatically improve VM performance — NVMe preferred.

---

## Tags
`[[Virtualization]]` `[[Homelab]]` `[[Proxmox]]` `[[Active Directory]]` `[[Docker]]` `[[Kali Linux]]` `[[Hyper-V]]` `[[VMware]]` `[[Snapshots]]`