# virtualization

## What it is
Like a hotel where one building hosts hundreds of guests in isolated rooms — each guest believes they have the whole floor — virtualization tricks software into thinking it has dedicated hardware when it's actually sharing resources with many others. Precisely, virtualization is the abstraction layer (hypervisor) that enables multiple operating systems to run concurrently on a single physical host, each isolated in its own virtual machine (VM).

## Why it matters
A compromised VM in a cloud environment may attempt a **VM escape** attack — exploiting a hypervisor vulnerability to break out of the guest OS and gain control of the host or adjacent VMs. In 2015, the VENOM vulnerability (CVE-2015-3456) allowed attackers to escape QEMU-based VMs via a flaw in the virtual floppy disk controller, threatening entire cloud infrastructures from a single compromised guest.

## Key facts
- **Type 1 hypervisors** (bare-metal: VMware ESXi, Hyper-V) run directly on hardware; **Type 2** (hosted: VirtualBox, VMware Workstation) run on top of a host OS — Type 1 has a smaller attack surface.
- **VM escape** is the highest-severity virtualization attack, allowing a guest to compromise the hypervisor or other VMs on the same host.
- **Snapshot abuse** is a real threat: attackers who compromise a hypervisor can roll back VMs to pre-patched states or extract credentials from memory snapshots.
- Virtual machines provide **sandbox environments** for malware analysis — security teams run suspicious files in isolated VMs to observe behavior without risking production systems.
- **VM sprawl** (unmanaged, forgotten VMs) creates unpatched attack surface — a governance and vulnerability management concern tested on CySA+.

## Related concepts
[[hypervisor]] [[containerization]] [[sandbox]] [[cloud security]] [[VM escape]]