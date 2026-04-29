# ESXi

## What it is
Think of ESXi as the traffic cop standing directly on the highway asphalt — not inside a car, but embedded in the road itself — directing dozens of vehicles (virtual machines) simultaneously with minimal overhead. Technically, ESXi is VMware's Type 1 (bare-metal) hypervisor that runs directly on physical hardware without a host OS, managing CPU, memory, storage, and network resources across multiple isolated virtual machines. It is the foundational layer of VMware's vSphere virtualization platform.

## Why it matters
In 2023, ransomware groups like Royal and Black Basta deployed ESXiArgs, targeting unpatched ESXi servers exposed to the internet via OpenSLP vulnerabilities (CVE-2021-21974). Because ESXi hosts entire fleets of VMs, a single compromised hypervisor allowed attackers to encrypt hundreds of guest machines simultaneously — one host, catastrophic blast radius. Defenders must treat ESXi as a Tier-0 asset with strict network segmentation and patch discipline.

## Key facts
- **Type 1 hypervisor**: Runs directly on hardware, making it more performant and attack-surface-reduced compared to Type 2 (hosted) hypervisors like VirtualBox
- **VM escape attacks** target ESXi specifically because breaking out of one VM into the hypervisor grants access to all sibling VMs on that host
- **ESXi Shell and SSH are disabled by default** — enabling them is a common misconfiguration auditors check during CIS VMware Benchmark assessments
- **vCenter Server** is the management plane for ESXi clusters; compromising vCenter often grants control over all connected ESXi hosts
- **VMFS (VMware File System)** stores VM disk images (.vmdk files) — the primary target for ransomware encrypting virtual infrastructure

## Related concepts
[[Hypervisor Security]] [[VM Escape]] [[Virtualization]] [[Ransomware]] [[Bare-Metal Hypervisor]]