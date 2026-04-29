# DMA

## What it is
Like a VIP courier that bypasses the security checkpoint entirely and delivers packages straight to the warehouse floor — Direct Memory Access (DMA) allows hardware devices to read and write system RAM directly, without routing every transaction through the CPU. It's a performance optimization built into modern hardware that lets peripherals (network cards, GPUs, storage controllers) transfer data at full speed without CPU intervention.

## Why it matters
An attacker with physical access can plug a malicious Thunderbolt or PCIe device into a running, locked laptop and use DMA to read encryption keys, passwords, or entire memory contents in seconds — bypassing OS-level authentication entirely. This is the core mechanism behind tools like PCILeech and the older "cold boot" class of attacks. Defenses include enabling IOMMU (Intel VT-d / AMD-Vi), which acts as a bouncer that restricts which memory regions each device is allowed to touch.

## Key facts
- **IOMMU is the primary defense**: It enforces memory access boundaries per device, preventing rogue peripherals from reading arbitrary RAM addresses
- **Thunderbolt and PCIe** are the most common DMA attack vectors because they expose the PCIe bus directly to external ports
- **BitLocker with pre-boot PIN** is partially vulnerable — keys can reside in RAM after unlock and be extracted via DMA
- **Windows Kernel DMA Protection** (enabled via Secure Boot + UEFI) can block DMA attacks from external Thunderbolt devices before a user logs in
- **Cold boot attacks** combine DMA with RAM freezing (literally, with compressed air) to preserve memory contents after power loss for offline extraction

## Related concepts
[[IOMMU]] [[Physical Security Controls]] [[Cold Boot Attack]] [[Thunderbolt Security]] [[Memory Forensics]]