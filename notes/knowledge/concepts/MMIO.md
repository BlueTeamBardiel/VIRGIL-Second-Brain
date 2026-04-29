# MMIO

## What it is
Like a hotel where certain room numbers are actually the front desk, gift shop, and fire alarm panel rather than guest rooms — Memory-Mapped I/O (MMIO) is a technique where hardware devices (GPU, NIC, USB controllers) are assigned specific address ranges in the CPU's memory address space so software can interact with them using ordinary read/write instructions instead of special I/O port instructions. Instead of talking to hardware through dedicated channels, the CPU writes to an address like `0xFEA00000` and the bus routes that transaction directly to the device's registers.

## Why it matters
MMIO regions are a critical attack surface in virtualization security. In a VM escape attack, a malicious guest can craft carefully timed reads/writes to emulated MMIO regions — this was the root cause of **VENOM (CVE-2015-3456)**, where a vulnerable virtual floppy disk controller's MMIO handler had a buffer overflow that allowed code execution on the hypervisor host. Proper bounds checking in MMIO emulation handlers is now a mandatory security review item for hypervisor development.

## Key facts
- MMIO regions are defined in firmware (UEFI/BIOS) and reported to the OS via ACPI tables; malicious firmware can remap them to snoop or corrupt data
- DMA attacks exploit MMIO: a malicious PCIe device can read/write host memory because devices access memory through the same address space
- IOMMU (Intel VT-d / AMD-Vi) restricts which physical memory addresses a device can access via DMA, directly defending against MMIO-based DMA attacks
- MMIO regions must be marked non-cacheable in page tables (PAT/MTRR flags); incorrect caching can cause non-deterministic hardware behavior and security logic failures
- VM escape bugs frequently live in MMIO emulation handlers inside QEMU, VMware, and Hyper-V codebases

## Related concepts
[[DMA Attack]] [[IOMMU]] [[VM Escape]] [[Hypervisor Security]] [[PCIe Security]]