# Type 1 vs Type 2 Hypervisors

## What it is
Think of a Type 1 hypervisor as a landlord who *owns* the building and rents directly to tenants — no middleman. A Type 2 hypervisor is a subletter who rents an apartment and then illegally sub-divides it. Precisely: a **Type 1 (bare-metal) hypervisor** runs directly on physical hardware (e.g., VMware ESXi, Hyper-V), while a **Type 2 (hosted) hypervisor** runs as an application on top of an existing OS (e.g., VirtualBox, VMware Workstation).

## Why it matters
VM escape attacks — where malicious code breaks out of a guest VM to reach the host — are more catastrophic on Type 2 systems because a successful escape lands the attacker inside a full general-purpose OS with a massive attack surface. In cloud environments, Type 1 hypervisors like Xen or KVM underpin AWS and Azure; a vulnerability in these (e.g., the 2018 Xen hypervisor flaw CVE-2018-12891) could allow a compromised tenant VM to affect other customers' workloads, making patch management critical.

## Key facts
- **Type 1** hypervisors have a smaller attack surface because they eliminate the host OS layer; preferred for enterprise and cloud production environments
- **Type 2** hypervisors inherit all vulnerabilities of the underlying host OS, increasing risk
- **VM escape** is the critical threat for both types — attacker breaks guest isolation to reach the hypervisor or host
- **Hyperjacking** is a specific attack where an attacker installs a rogue hypervisor beneath the legitimate OS, essentially becoming a Type 1 without authorization
- For Security+: Type 1 = more secure, better performance; Type 2 = easier to deploy, used for dev/testing/labs

## Related concepts
[[VM Escape]] [[Hyperjacking]] [[Containerization vs Virtualization]] [[Cloud Security Models]]