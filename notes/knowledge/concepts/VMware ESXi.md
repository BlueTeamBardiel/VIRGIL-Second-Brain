# VMware ESXi

## What it is
Think of ESXi as a master puppeteer who runs multiple marionette shows simultaneously on a single stage — each puppet show (virtual machine) believes it owns the entire theater. VMware ESXi is a Type 1 "bare-metal" hypervisor that runs directly on physical server hardware, enabling multiple isolated virtual machines to share CPU, memory, and storage resources. Unlike Type 2 hypervisors, ESXi has no underlying host OS — it *is* the operating system layer.

## Why it matters
In 2022, the ESXiArgs ransomware campaign exploited CVE-2021-21974, a heap overflow vulnerability in ESXi's OpenSLP service, allowing unauthenticated attackers to encrypt thousands of virtual machines across unpatched servers worldwide. Because a single ESXi host might run dozens of VMs, compromising the hypervisor is a catastrophic force-multiplier — attackers own every guest simultaneously. Defenders prioritize ESXi patching and disabling unused services like SLP to reduce this attack surface.

## Key facts
- **Type 1 hypervisor**: runs directly on hardware (no host OS), making it more performant and a smaller attack surface than Type 2 (e.g., VirtualBox)
- **VM Escape**: a critical threat class where malicious code in a guest VM breaks out to the hypervisor layer, potentially compromising all other VMs on the host
- **vSphere**: the broader VMware management platform; ESXi is the hypervisor component, while vCenter Server provides centralized management
- **Default attack surface**: ESXi exposes management interfaces on port 443 (HTTPS) and 902 (VMware Remote Console) — hardening requires restricting access via firewall rules
- **Ransomware target**: ESXi hosts are prime ransomware targets because encrypting VMDK files (virtual disks) instantly bricks all hosted VMs

## Related concepts
[[Hypervisor Security]] [[VM Escape]] [[Virtualization Hardening]] [[Ransomware]] [[CVE Vulnerability Management]]