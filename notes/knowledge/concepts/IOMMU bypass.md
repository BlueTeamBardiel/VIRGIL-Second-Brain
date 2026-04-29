# IOMMU bypass

## What it is
Imagine a strict building security desk that checks every visitor's badge before they access any floor — the IOMMU is that desk for hardware devices, controlling which memory regions a DMA-capable device can touch. An IOMMU bypass is any technique that tricks, misconfigures, or exploits weaknesses in this Input/Output Memory Management Unit to allow a peripheral device to read or write arbitrary system memory without CPU authorization. This breaks the hardware isolation boundary meant to contain malicious or compromised devices.

## Why it matters
In the Thunderspy attack (2019), researchers demonstrated that Thunderbolt-connected devices could bypass IOMMU protections on many laptops — even locked ones — to directly read RAM and extract BitLocker encryption keys or hijack OS sessions in under five minutes. This showed that physical access plus a malicious peripheral can completely defeat software-level security controls, making firmware and hardware configuration critical defensive layers.

## Key facts
- **DMA (Direct Memory Access)** is the prerequisite threat: PCIe, Thunderbolt, and FireWire devices can read/write RAM without the CPU, which IOMMU is designed to restrict.
- Many systems ship with IOMMU **disabled by default** or misconfigured, even when the hardware supports it (Intel VT-d / AMD-Vi).
- Bypass techniques include exploiting **misconfigured IOMMU domains**, abusing **pass-through in hypervisors** (VM escape vector), and leveraging **pre-boot windows** before IOMMU is initialized.
- **Thunderspy** is the canonical CVE-class example; it exploited Intel's Thunderbolt security levels being bypassable via firmware reprogramming.
- Defense requires: enabling IOMMU in UEFI/BIOS, enforcing **Kernel DMA Protection** (Windows) or `iommu=strict` (Linux), and disabling unused DMA-capable ports.

## Related concepts
[[DMA Attack]] [[Thunderbolt Security]] [[Hypervisor Escape]] [[PCIe Enumeration]] [[Kernel DMA Protection]]