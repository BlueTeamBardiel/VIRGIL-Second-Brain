# VMware Security and Load Balancing

## What it is
Like a hotel concierge routing guests to different floors while security guards check IDs at every elevator — VMware combines hypervisor-based virtualization with built-in security controls and traffic distribution across virtual machines. Specifically, VMware vSphere environments use components like vSphere Distributed Switch (vDS), NSX micro-segmentation, and vSphere High Availability (HA) to enforce security policies and balance workloads across ESXi hosts.

## Why it matters
In 2021, attackers exploited CVE-2021-21985, a remote code execution vulnerability in VMware vCenter Server, to gain hypervisor-level access — compromising *every* VM on the host simultaneously. Because the hypervisor sits beneath all guest OS instances, a single unpatched VMware component can render traditional OS-level controls irrelevant, making patch management and network segmentation at the hypervisor layer critical defensive priorities.

## Key facts
- **VMware NSX micro-segmentation** creates firewall rules between VMs on the *same* host, preventing lateral movement that traditional perimeter firewalls miss entirely
- **vMotion** (live VM migration between hosts) can inadvertently expose unencrypted VM memory across the network if the vMotion network is not isolated and encrypted
- **ESXi lockdown mode** restricts direct host access, forcing all management traffic through vCenter, reducing the attack surface
- **DRS (Distributed Resource Scheduler)** automatically migrates VMs for load balancing, but misconfigured DRS combined with weak vCenter credentials creates privilege escalation risk
- VMware snapshots store VM state to disk in plaintext `.vmdk` files — improper access controls on the datastore can expose sensitive memory contents including credentials

## Related concepts
[[Hypervisor Security]] [[Micro-Segmentation]] [[Network Access Control]]