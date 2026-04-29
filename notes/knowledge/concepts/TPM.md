# TPM

## What it is
Think of it as a tamper-resistant safe *welded inside your laptop's motherboard* — you can't remove it, clone it, or fake its contents. A Trusted Platform Module (TPM) is a dedicated hardware chip that generates, stores, and manages cryptographic keys in a physically isolated environment, providing a hardware root of trust that the OS itself cannot fully override.

## Why it matters
When an attacker steals a laptop and pulls the hard drive to read it in another machine, BitLocker encryption stops them cold — because the decryption key is sealed inside the TPM and will only release if the boot environment matches a known-good state (measured via PCRs). Without TPM, BitLocker falls back to a PIN or USB key, which are far easier to bypass or steal.

## Key facts
- TPM stores cryptographic keys, certificates, and hashes; it **cannot be transplanted** to another motherboard without invalidating stored secrets
- **Platform Configuration Registers (PCRs)** record SHA hashes of each boot component — BIOS, bootloader, OS kernel — creating a chain of trust measurement
- TPM 2.0 (current standard) supports **multiple hash algorithms** (SHA-256, SHA-384) and **hierarchies**; TPM 1.2 was limited to SHA-1 only
- **Attestation** allows a TPM to cryptographically prove to a remote server that a device is in a trusted, unmodified state — critical for Zero Trust architectures
- Windows 11 **requires TPM 2.0**, making it a baseline hardware security requirement for modern enterprise endpoints

## Related concepts
[[Secure Boot]] [[BitLocker]] [[Chain of Trust]] [[Hardware Security Module (HSM)]] [[Measured Boot]]