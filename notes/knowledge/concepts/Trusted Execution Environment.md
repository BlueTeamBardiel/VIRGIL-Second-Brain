# Trusted Execution Environment

## What it is
Think of a TEE like a locked glass room inside a bank vault — even the bank employees outside can't see or tamper with what's happening inside. A Trusted Execution Environment (TEE) is an isolated, hardware-enforced secure enclave within a processor that runs code and processes data separately from the main operating system, protecting sensitive operations even if the OS is fully compromised.

## Why it matters
In 2019, researchers demonstrated that malware with root-level OS access on Android devices still could not extract cryptographic keys stored inside ARM TrustZone (a common TEE implementation) — the keys never left the enclave. This is why mobile banking apps use TEEs to perform biometric authentication and payment authorization: compromising the OS buys an attacker nothing if the crown jewels live in hardware-enforced isolation.

## Key facts
- **ARM TrustZone** and **Intel SGX (Software Guard Extensions)** are the two dominant TEE implementations on mobile and desktop/server platforms respectively
- TEEs enforce a **"secure world" vs "normal world"** separation at the hardware level — the CPU itself enforces the boundary
- Code and data inside a TEE are **encrypted in memory**, protecting against cold-boot attacks and physical memory inspection
- TEEs support **remote attestation** — a cryptographic proof that the enclave is running genuine, unmodified code on real trusted hardware
- TEEs are a core component of **Device Health Attestation** in zero-trust architectures, allowing servers to verify client device integrity before granting access

## Related concepts
[[Hardware Security Module]] [[Secure Boot]] [[Remote Attestation]] [[ARM TrustZone]] [[Zero Trust Architecture]]