# AGESA

## What it is
Think of AGESA as the firmware bouncer at the club — it runs before the main security system (UEFI) even loads, deciding what gets to execute on AMD processors. Specifically, AGESA (AMD Generic Encapsulated System Architecture) is proprietary firmware that initializes AMD CPU and chipset hardware, handling memory configuration, power management, and security features before the operating system boots.

## Why it matters
In 2021, researchers discovered critical vulnerabilities in AGESA that allowed attackers to bypass Secure Boot and inject malicious code during the earliest boot stages — before any OS-level protections engage. Because AGESA runs at the highest privilege level with minimal oversight, compromised firmware is nearly impossible to detect or remove without physical access, making it an attractive target for nation-state actors seeking persistent, undetectable persistence.

## Key facts
- AGESA runs on AMD Ryzen and EPYC processors before UEFI/BIOS executes
- Vulnerabilities in AGESA can completely bypass Secure Boot mechanisms
- AMD releases AGESA updates through motherboard manufacturers (OEM BIOS updates), not directly — creating slow patch deployment
- AGESA handles memory training and initialization, meaning bugs here cause system-wide instability or security gaps
- Security researchers have limited ability to audit AGESA due to its proprietary, closed-source nature

## Related concepts
[[Secure Boot]] [[UEFI]] [[Bootkit]] [[Firmware Security]] [[Supply Chain Attacks]]