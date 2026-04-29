# IOMMU

## What it is
Think of it as a bouncer at a nightclub, but for hardware — instead of people flashing fake IDs to get past security, PCIe devices try to read arbitrary memory addresses, and the IOMMU checks every single request against a guest list. Precisely: an Input-Output Memory Management Unit is a hardware component that maps device-visible virtual addresses to physical memory addresses, enforcing access controls so that DMA-capable devices can only touch memory regions explicitly permitted by the OS or hypervisor.

## Why it matters
Without an IOMMU enabled, a malicious or compromised PCIe device — say, a Thunderbolt peripheral plugged in at a conference — can perform a **DMA attack**, reading encryption keys, passwords, or session tokens directly from RAM, completely bypassing the CPU and OS protections. This is the exact technique used by tools like PCILeech to extract BitLocker keys from a locked Windows machine in seconds. Enabling and enforcing IOMMU (Intel VT-d / AMD-Vi) blocks this attack by restricting the device to its own memory sandbox.

## Key facts
- **Intel calls it VT-d**, AMD calls it **AMD-Vi**; both are vendor implementations of the same IOMMU concept
- IOMMU is critical for **secure virtualization** — it prevents a VM's assigned device from escaping its memory boundary and corrupting the hypervisor
- **Thunderbolt ports are high-risk** for DMA attacks because they expose direct PCIe lanes; many BIOS settings disable IOMMU by default
- Enabling IOMMU is a **recommended hardening step** for endpoints handling classified data and is referenced in DISA STIGs
- IOMMU underpins **AMD SME/SEV** (Secure Encrypted Virtualization), isolating VM memory from a compromised hypervisor

## Related concepts
[[DMA Attack]] [[Virtualization Security]] [[Secure Boot]] [[PCIe Security]] [[Hypervisor Isolation]]