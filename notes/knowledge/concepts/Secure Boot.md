# Secure Boot

## What it is
Like a bouncer checking a guest list before anyone enters the club, Secure Boot verifies the cryptographic signature of every piece of software in the boot chain before allowing it to execute. It is a UEFI firmware security standard that ensures only trusted, digitally-signed bootloaders and OS kernels load during system startup, preventing unauthorized code from hijacking the process before the OS even initializes.

## Why it matters
Bootkits like BlackLotus (discovered 2023) are specifically designed to execute before the OS loads, making them invisible to traditional antivirus tools running in userspace. Secure Boot, when properly configured with updated revocation certificates, can block BlackLotus by refusing to execute its unsigned or revoked bootloader — demonstrating why the pre-OS environment is a critical attack surface defenders cannot ignore.

## Key facts
- Secure Boot is part of the **UEFI specification**, replacing the legacy BIOS environment; it does not function on older BIOS-only systems
- Uses a **Platform Key (PK), Key Exchange Keys (KEK), and a signature database (db)** to establish a chain of trust from firmware to OS
- An attacker with physical access can disable Secure Boot via UEFI settings unless a **BIOS/UEFI password** is set — physical security remains a prerequisite
- The **Secure Boot Bypass vulnerability (CVE-2023-24932)** allowed BlackLotus to circumvent Secure Boot on fully patched Windows 11 systems, requiring Microsoft to issue updated revocation policies
- Secure Boot is listed as a key control in **NIST SP 800-147** (BIOS Protection Guidelines) and aligns with CIS Benchmark hardening recommendations

## Related concepts
[[UEFI Firmware Security]] [[Chain of Trust]] [[Measured Boot]] [[Rootkits and Bootkits]] [[TPM (Trusted Platform Module)]]