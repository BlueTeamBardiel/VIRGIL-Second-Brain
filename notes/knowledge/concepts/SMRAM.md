# SMRAM

## What it is
Think of SMRAM like a bank vault inside a bank vault — a hidden memory region that even the operating system cannot see or touch, reserved exclusively for the CPU's most privileged execution mode. System Management RAM (SMRAM) is a protected area of physical memory (typically starting at address 0xA0000 or in a high range like TSEG) used exclusively by System Management Mode (SMM), the highest-privilege execution context on x86 processors. It stores SMM handler code and data that run invisible to the OS, hypervisor, and all other software.

## Why it matters
Attackers who can write to SMRAM achieve a "God Mode" implant — malicious code that persists below the OS, survives reimaging, and can neutralize any security software. The notorious "Rakshasa" and "ThinkPwn" firmware exploits demonstrated that improper SMRAM locking allowed attackers to inject rootkit code into SMM handlers, giving them persistent, undetectable control over the machine. Defenders counter this by verifying that the BIOS_WP bit and SMRAM lock bits (via chipset registers like SMRAMC) are properly set before the OS boots.

## Key facts
- SMRAM is accessible **only** when the CPU is in System Management Mode (SMM), triggered by a System Management Interrupt (SMI)
- The chipset enforces SMRAM protection through a register called **SMRAMC** (System Management RAM Control); the D_OPEN bit must be cleared and D_LCK set before OS handoff
- If SMRAM is left unlocked, any ring-0 (kernel-level) attacker can overwrite SMM handlers to create a **hypervisor-level rootkit**
- SMRAM is physically located in DRAM but is **remapped and hidden** from the normal memory address space
- Platform-level defenses include **Intel SMRR** (System Management Range Registers), which enforce hardware-level read/write restrictions on the SMRAM range

## Related concepts
[[System Management Mode (SMM)]] [[UEFI Firmware Security]] [[Ring -2 Attacks]] [[Rootkits]] [[Trusted Platform Module (TPM)]]