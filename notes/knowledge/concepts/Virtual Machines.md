# virtual machines

## What it is
Like a snow globe sitting on your desk — a complete self-contained world inside a larger world, with its own rules and boundaries. A virtual machine (VM) is a software-emulated computer running on a physical host, isolated from the underlying hardware through a hypervisor that mediates resource access and enforces separation between guest and host environments.

## Why it matters
Malware analysts routinely execute ransomware samples inside VMs to observe behavior safely — the ransomware encrypts the VM's virtual disk, but the host machine and real files remain untouched. Sophisticated malware counters this by detecting VM artifacts (like VMware registry keys or suspicious hardware strings) and going dormant to evade analysis, a technique called VM-aware evasion.

## Key facts
- **Type 1 hypervisors** (bare-metal: VMware ESXi, Hyper-V) run directly on hardware; **Type 2 hypervisors** (hosted: VirtualBox, VMware Workstation) run on top of a host OS — Type 1 has a smaller attack surface
- **VM escape** is a critical attack where malicious code breaks out of the guest VM to compromise the host hypervisor or other VMs on the same physical machine
- Snapshots allow instant rollback to a clean state, making VMs ideal for sandboxing and malware detonation in incident response
- **VM sprawl** — unmanaged, forgotten VMs accumulating on infrastructure — creates unpatched attack surface and is an explicit CySA+ exam topic
- VMs share physical hardware, so **side-channel attacks** (like cache-timing attacks) can potentially leak data between co-hosted VMs on the same physical server

## Related concepts
[[hypervisor]] [[sandboxing]] [[containerization]] [[VM escape]] [[snapshot]]