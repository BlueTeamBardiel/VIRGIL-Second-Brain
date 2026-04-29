# Secure Enclave

## What it is
Think of it like a bank vault *inside* a bank — even the bank's own employees can't open it without the right combination. A Secure Enclave is an isolated, hardware-protected execution environment (typically a dedicated coprocessor) that performs sensitive cryptographic operations — like key storage, biometric verification, and decryption — in memory that the main operating system and CPU cannot directly access, even with root privileges.

## Why it matters
In 2016, the FBI demanded Apple unlock an iPhone belonging to the San Bernardino shooter. Apple refused — and technically *couldn't* easily comply — because the device's encryption keys were sealed inside the Secure Enclave, protected by a PIN-derived key and hardware-enforced attempt limits. Even with physical possession of the device, extracting those keys without the correct passcode would trigger permanent data destruction after 10 failed attempts.

## Key facts
- Apple's Secure Enclave Processor (SEP) is a separate ARM-based coprocessor that runs its own micro-kernel, isolated from the main A-series chip's execution environment
- The SEP generates and stores private keys using a hardware UID (Unique ID) fused into silicon at manufacture — never exported, never readable by software
- Similar concepts exist across vendors: Intel SGX (Software Guard Extensions), AMD SEV (Secure Encrypted Virtualization), and ARM TrustZone all implement hardware-isolated execution
- Secure Enclaves are classified under the broader category of Trusted Execution Environments (TEEs)
- Attacks on Secure Enclaves often target *side channels* (e.g., power analysis, cache-timing attacks like Spectre/Meltdown variants) rather than direct code execution, because direct access is architecturally prevented

## Related concepts
[[Trusted Platform Module (TPM)]] [[Trusted Execution Environment]] [[Hardware Root of Trust]] [[Side-Channel Attack]] [[Full Disk Encryption]]