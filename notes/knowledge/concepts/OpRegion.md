# OpRegion

## What it is
Think of it like a post office box system for hardware: each box has a fixed address and holds specific mail (data) that software can pick up or drop off. An **OpRegion** (Operation Region) is an ACPI (Advanced Configuration and Power Interface) construct defined in firmware that maps a specific range of a hardware resource — such as system memory, I/O ports, PCI config space, or embedded controller registers — so that AML (ACPI Machine Language) bytecode can read or write to it.

## Why it matters
Attackers who exploit ACPI firmware can abuse OpRegions to achieve ring-0 or even ring-2 (SMM) privilege escalation. In the wild, rootkits like Computrace/LoJax have leveraged ACPI OpRegion handlers to persist malicious code by writing directly to SPI flash memory regions, surviving OS reinstalls and disk wipes entirely.

## Key facts
- OpRegions are declared in DSDT/SSDT firmware tables using the `OperationRegion` keyword, specifying the space type, base offset, and length
- Five common region space types: `SystemMemory`, `SystemIO`, `PCI_Config`, `EmbeddedControl`, and `SMBus`
- **FieldUnits** inside an OpRegion define named bit/byte-level access points — these are what ACPI methods actually read/write
- Malicious or vulnerable ACPI tables can be injected via GRUB, bootloaders, or physical DMA attacks to define rogue OpRegions pointing to sensitive memory
- Secure Boot does **not** inherently validate ACPI table contents, making OpRegion-based attacks viable even on "secured" systems

## Related concepts
[[ACPI Firmware Attack]] [[UEFI Rootkit]] [[Direct Memory Access (DMA) Attack]] [[System Management Mode (SMM)]] [[Secure Boot]]