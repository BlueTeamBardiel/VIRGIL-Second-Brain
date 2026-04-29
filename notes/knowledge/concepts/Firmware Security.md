# Firmware Security

## What it is
Think of firmware like the BIOS instructions baked into a microwave's control board — it runs before any software loads and has no "app store" to push patches. Firmware is persistent low-level code stored in non-volatile memory (flash chips, EEPROMs) that initializes hardware and provides runtime services to the operating system. Because it executes below the OS layer, compromised firmware survives reimaging, disk wipes, and even hardware replacements.

## Why it matters
In 2015, the Equation Group (linked to NSA) was discovered deploying firmware implants inside hard drive controller chips from manufacturers including Seagate and Western Digital. The malware survived full disk reformats and OS reinstalls because it lived in the drive's onboard flash — completely invisible to antivirus tools operating at the OS layer. This demonstrated that firmware is effectively the lowest trust anchor an attacker can corrupt.

## Key facts
- **Secure Boot** (UEFI feature) validates firmware and bootloader signatures using cryptographic keys stored in the TPM, blocking unsigned code from executing during startup
- **UEFI replaces legacy BIOS** and supports Secure Boot, measured boot, and signed driver enforcement — legacy BIOS has none of these protections
- **Firmware attacks are persistent and stealthy** — they survive OS reinstalls and are invisible to OS-level security tools
- **Supply chain risk**: malicious firmware can be injected during manufacturing or logistics (interdiction attacks), making vendor attestation critical
- **NIST SP 800-193** provides the Platform Firmware Resiliency (PFR) guidelines: Protect, Detect, Recover — the three pillars of firmware security posture

## Related concepts
[[Secure Boot]] [[Trusted Platform Module (TPM)]] [[Supply Chain Security]] [[UEFI vs BIOS]] [[Rootkits]]