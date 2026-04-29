# Dell Client Platform BIOS

## What it is
Think of it as the night-shift security guard who checks IDs *before* the building's front door even opens — it runs before the OS loads and controls what hardware is trusted. Dell Client Platform BIOS is the vendor-specific firmware (built on UEFI standards) embedded in Dell business and consumer endpoints that initializes hardware, enforces pre-boot security policies, and establishes the root of trust for the entire boot chain.

## Why it matters
In 2022, researchers disclosed vulnerabilities in Dell's BIOSConnect feature (CVE-2021-21571 through 21574) that allowed a privileged network attacker to execute arbitrary code in BIOS-level privilege — effectively below the OS, invisible to antivirus. Because BIOS-level malware (like LoJax) persists through OS reinstalls and hard drive replacements, defenders must use Dell's BIOS verification tools and Secure Boot enforcement rather than relying solely on endpoint agents.

## Key facts
- Dell Client Platform BIOS supports **UEFI Secure Boot**, which cryptographically validates bootloaders and drivers against a whitelist stored in firmware — blocking unsigned code from executing at boot.
- **Dell BIOS Admin Password** and **System Password** are separate controls; without the admin password, attackers cannot disable Secure Boot or TPM settings from the BIOS interface.
- Dell integrates **TPM 2.0** with its BIOS to enable measured boot, feeding PCR (Platform Configuration Register) values into BitLocker and remote attestation workflows.
- **BIOSConnect** (Dell's remote BIOS update feature) communicates over HTTPS but has historically had TLS validation weaknesses — patch management of BIOS firmware is a distinct, often overlooked attack surface.
- Dell BIOS can be configured to enforce **boot order lockdown**, preventing USB/PXE booting — a critical physical security control for unattended devices.

## Related concepts
[[UEFI Secure Boot]] [[Trusted Platform Module (TPM)]] [[Supply Chain Attacks]] [[Pre-boot Authentication]] [[Measured Boot]]