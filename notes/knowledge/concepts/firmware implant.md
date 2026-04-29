# firmware implant

## What it is
Like a parasite that burrows into the walls of a house rather than living in the rooms — so evicting the tenants does nothing — a firmware implant is malicious code injected directly into a device's firmware (BIOS/UEFI, NIC firmware, HDD controller, router firmware). It persists below the operating system layer, surviving OS reinstalls, disk wipes, and even hardware reseating in some cases.

## Why it matters
The NSA's ANT catalog (leaked 2013) revealed **IRATEMONK**, an implant targeting hard drive firmware from manufacturers including Seagate and Western Digital. Once installed, it survived complete disk reformatting by hiding in the Host Protected Area and reinfecting the OS on every boot — making traditional incident response completely ineffective against it.

## Key facts
- Firmware implants operate in **Ring -1 or lower** (below the OS kernel at Ring 0), making them invisible to OS-level security tools and antivirus
- **Secure Boot** is designed as a primary defense — it uses cryptographic signature verification to reject unsigned firmware during the boot sequence
- Supply chain attacks (e.g., Supermicro controversy, 2018) represent the most scalable delivery vector — compromising firmware before hardware reaches the customer
- Detection methods include **firmware integrity monitoring**, out-of-band attestation, and comparing firmware hashes against known-good vendor values
- UEFI rootkits like **LoJax** (APT28, 2018) were the first publicly confirmed in-the-wild UEFI implants, proving the threat moved from theory to active exploitation

## Related concepts
[[UEFI rootkit]] [[supply chain attack]] [[Secure Boot]] [[Trusted Platform Module (TPM)]] [[persistence mechanisms]]