# DMA Attack

## What it is
Imagine handing a locksmith a master key that bypasses every door in a building simultaneously — that's what DMA does for hardware. Direct Memory Access (DMA) attacks occur when a malicious device plugs into a high-speed port (Thunderbolt, FireWire, PCIe) and reads or writes directly to RAM, completely circumventing the CPU and operating system's security controls.

## Why it matters
In 2012, researchers demonstrated that a FireWire-connected device could extract a Windows BitLocker encryption key directly from RAM in seconds — while the machine was locked. This attack required only physical access to the port, making unattended laptops at conferences or airports a viable target for credential and key harvesting without leaving forensic traces.

## Key facts
- DMA attacks exploit the fact that devices granted DMA access bypass the OS entirely — no user permissions, no antivirus, no kernel checks
- **Thunderbolt 3 and earlier** are particularly vulnerable; Thunderbolt 4 introduced mandatory Intel VT-d (IOMMU) enforcement to sandbox device memory access
- **IOMMU (Input-Output Memory Management Unit)** is the primary hardware defense — it restricts which memory regions a DMA-capable device can access
- Cold boot attacks are a related vector: RAM retains data briefly after power loss, enabling memory dumps from removed DIMMs
- Windows Kernel DMA Protection (enabled via UEFI) and disabling Thunderbolt ports in BIOS are standard mitigations on enterprise endpoints

## Related concepts
[[Cold Boot Attack]] [[BitLocker]] [[IOMMU]] [[Physical Security Controls]] [[Side-Channel Attack]]