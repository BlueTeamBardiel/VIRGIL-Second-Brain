# AMD Secure Processor

## What it is
Think of it as a bank vault built *inside* the bank's walls — completely separate from the main floor where tellers work, yet always present. The AMD Secure Processor (formerly Platform Security Processor, or PSP) is an ARM Cortex-A5 core embedded within AMD CPUs that runs its own isolated firmware and operating environment, independent of the main x86 cores and the host OS. It manages cryptographic operations, secure boot, and hardware-level key management before the rest of the system even initializes.

## Why it matters
In 2018, researchers at CTS-Labs disclosed vulnerabilities (MASTERKEY, RYZENFALL, FALLOUT) targeting the AMD Secure Processor firmware, demonstrating that malicious code could be injected into the PSP's isolated environment — effectively placing a persistent rootkit *below* the operating system where traditional antivirus cannot reach. Because the PSP has privileged access to system memory and cryptographic keys, compromise of it bypasses virtually every software-level security control on the machine.

## Key facts
- Runs ARM TrustZone-based firmware independently from the host x86 processor and OS
- Handles fTPM (firmware Trusted Platform Module) functionality, replacing the need for a discrete TPM chip
- Responsible for validating the UEFI firmware chain during Secure Boot before handing control to the bootloader
- Stores and manages keys used for AMD Memory Guard (full memory encryption on EPYC processors)
- Operates at a privilege level *above* hypervisors and OS kernels — compromise is effectively undetectable by host software

## Related concepts
[[Trusted Platform Module (TPM)]] [[Secure Boot]] [[Intel Management Engine]] [[Hardware Root of Trust]] [[Firmware Rootkits]]