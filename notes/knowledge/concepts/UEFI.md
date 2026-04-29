# UEFI

## What it is
Think of UEFI as the hotel concierge that wakes up before any guests arrive — it checks the building's systems, hands out room keys, and decides who gets through the front door before the actual hotel staff (the OS) ever clocks in. Unified Extensible Firmware Interface is the modern firmware standard that initializes hardware and launches the bootloader during system startup, replacing the legacy BIOS with a richer, programmable environment that runs before the operating system loads.

## Why it matters
Because UEFI executes before the OS, malware embedded here survives OS reinstalls, disk wipes, and even drive replacements — making it the holy grail for persistent, stealthy implants. The **LoJax** rootkit (2018, APT28) was the first publicly documented UEFI rootkit used in the wild, writing malicious code directly into SPI flash memory. Defenders counter this with **Secure Boot**, which cryptographically verifies each component in the boot chain before execution is allowed.

## Key facts
- UEFI replaces BIOS and supports drives larger than 2TB via GPT partitioning, 64-bit execution, and a graphical pre-boot environment
- **Secure Boot** uses code-signing certificates stored in UEFI firmware to reject unsigned or tampered bootloaders — a key defense against bootkits
- UEFI firmware is stored in SPI flash memory on the motherboard, making infections extremely persistent and difficult to detect
- The **UEFI Secure Boot Database** (db, dbx, KEK, PK) stores allowed and revoked certificates; attackers targeting this database can bypass Secure Boot entirely
- Vulnerabilities like **BootHole (CVE-2020-10713)** demonstrated that even signed bootloaders can contain exploitable flaws that undermine the entire chain of trust

## Related concepts
[[Secure Boot]] [[Bootkits]] [[Chain of Trust]] [[Measured Boot]] [[TPM]]