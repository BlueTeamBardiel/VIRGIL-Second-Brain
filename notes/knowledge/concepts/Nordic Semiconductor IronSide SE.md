# Nordic Semiconductor IronSide SE

## What it is
Think of it as a locked vault inside a vault — a security enclave that operates independently even if the main processor is fully compromised. IronSide SE is Nordic's dedicated Secure Element integrated into select nRF SoCs (like the nRF9161), providing hardware-isolated execution for cryptographic operations, secure boot, and key storage using ARM TrustZone-M architecture.

## Why it matters
In an IoT supply chain attack, an adversary who compromises the main application firmware cannot extract private keys or forge attestation certificates if those assets are locked inside the IronSide SE — the secure element refuses operations that violate its policy regardless of what the untrusted world requests. This directly addresses the threat model where millions of deployed edge devices become targets for credential harvesting at scale.

## Key facts
- IronSide SE is a physically and logically isolated security subsystem — it has its own CPU, ROM, RAM, and crypto accelerators, separate from the application core
- Provides **PSA Certified Level 2** hardware security, meaning it has been independently evaluated against the Platform Security Architecture threat model
- Supports secure key provisioning, device attestation, and trusted firmware update verification — critical for IoT PKI trust chains
- Uses **ARM TrustZone-M** to enforce separation between Secure World and Non-Secure World; the NS application core cannot directly read SE memory
- Enables **DICE (Device Identifier Composition Engine)** for hardware-rooted identity, allowing each device to prove its provenance cryptographically

## Related concepts
[[Trusted Execution Environment]] [[ARM TrustZone]] [[Hardware Security Module]] [[Secure Boot]] [[PSA Certified]]