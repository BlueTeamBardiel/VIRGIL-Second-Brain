# SMI

## What it is
Like a secret trapdoor in a theater that lets stagehands move props while the show continues — invisible to the audience and impossible to interrupt — System Management Interrupt (SMI) is a special CPU interrupt that pauses all normal execution and drops the processor into System Management Mode (SMM), a highly privileged, isolated execution environment. SMM runs completely below the OS, hypervisor, and any security software, making it effectively invisible to everything running above it.

## Why it matters
Attackers who achieve SMM code execution have found the holy grail of persistence: malware running in SMM survives OS reinstalls, disk wipes, and even hypervisor resets because it lives in SMRAM — a protected memory region the OS cannot directly read or write. The "ThinkPwn" vulnerability (2016) exploited a SMM privilege escalation bug in Lenovo firmware to achieve exactly this, enabling rootkits that no conventional endpoint tool could detect or remove.

## Key facts
- SMI is triggered by asserting the SMI# pin or via ACPI/chipset mechanisms; the CPU saves its state and jumps to SMM handler code stored in SMRAM
- SMRAM sits at physical address range starting at 0xA0000 by default and is locked by the TSEG bit — if misconfigured, attackers can overwrite SMM handlers
- SMM runs at privilege level higher than Ring 0 (sometimes called Ring -2), meaning it can bypass all OS and hypervisor protections
- Secure Boot does **not** protect against SMM-level rootkits — UEFI Secure Boot validates the boot chain, not runtime SMM integrity
- Intel TXT and AMD SEV provide mechanisms to measure/protect against SMM tampering, and modern UEFI implementations use SMM lockboxes to harden SMRAM access

## Related concepts
[[UEFI Firmware Security]] [[Ring Protection Model]] [[Rootkits]] [[Secure Boot]] [[Hardware Vulnerabilities]]