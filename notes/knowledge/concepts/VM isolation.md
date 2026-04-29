# VM isolation

## What it is
Think of a hotel with rooms sharing the same plumbing and electrical grid — guests are separate, but a burst pipe in room 302 could flood room 303. VM isolation is the security boundary enforced by a hypervisor that prevents one virtual machine from accessing the memory, storage, or execution space of another VM running on the same physical host. It relies on the hypervisor acting as an enforcing landlord, strictly partitioning hardware resources among tenants.

## Why it matters
In 2018, the Spectre and Meltdown vulnerabilities demonstrated that CPU-level speculative execution could allow a malicious VM to read memory belonging to a neighboring VM or even the hypervisor itself — a direct VM isolation failure. Cloud providers had to emergency-patch hypervisors and disable certain CPU features, costing measurable performance. This is the canonical example of why hardware-level isolation must back up software-level controls.

## Key facts
- **Hypervisor types matter:** Type 1 (bare-metal) hypervisors like VMware ESXi and Hyper-V have a smaller attack surface than Type 2 (hosted) hypervisors, which run on top of a full OS
- **VM escape** is the critical attack class — malicious code inside a VM exploits a hypervisor vulnerability to gain access to the host OS or adjacent VMs
- **Snapshot files** (.vmdk, .vhd) contain full memory state and must be protected at rest; unencrypted snapshots are a data exfiltration risk
- **Virtual network isolation** requires separate vSwitches or VLANs; VMs on the same vSwitch can sniff each other's traffic if misconfigured
- **VENOM (CVE-2015-3456)** is a textbook VM escape — a flaw in the virtual floppy disk controller allowed guest-to-host breakout across QEMU/KVM, Xen, and VirtualBox

## Related concepts
[[Hypervisor Security]] [[VM Escape]] [[Container Isolation]] [[Spectre and Meltdown]] [[Cloud Shared Responsibility Model]]