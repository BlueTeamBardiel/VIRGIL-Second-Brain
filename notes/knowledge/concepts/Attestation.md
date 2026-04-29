# Attestation

## What it is
Like a notary stamping a document to prove it hasn't been tampered with since signing, attestation is the process by which a device cryptographically proves to a remote verifier that its software and hardware state are trustworthy and unmodified. A Trusted Platform Module (TPM) measures the boot process, stores cryptographic hashes of each layer, and signs them — allowing a remote server to verify the device booted into a known-good state before granting access.

## Why it matters
In a zero-trust enterprise, a compromised endpoint with a rootkit might present valid credentials but fail attestation because the TPM-measured boot chain no longer matches the expected hash values. Microsoft's Windows Hello for Business uses TPM-backed attestation so that even if an attacker steals a user's certificate, they cannot authenticate from a machine whose boot state is unverified — the rootkit silently breaks the cryptographic proof.

## Key facts
- **Remote Attestation** uses a TPM's Attestation Identity Key (AIK) to sign platform measurements (PCR values) sent to a remote verifier
- **PCRs (Platform Configuration Registers)** store cumulative SHA hashes of each boot stage; any tampering changes the final PCR value
- **Measured Boot** (Windows) vs **Secure Boot**: Secure Boot *blocks* untrusted code; Measured Boot *records* what ran for later attestation — they are complementary, not synonymous
- **FIDO2/WebAuthn** uses device attestation to prove a legitimate hardware authenticator (not software emulation) generated a credential
- Attestation is a core component of **Trusted Execution Environments (TEEs)** like Intel SGX and AMD SEV, enabling cloud workloads to verify enclave integrity

## Related concepts
[[Trusted Platform Module (TPM)]] [[Secure Boot]] [[Zero Trust Architecture]] [[Hardware Root of Trust]] [[FIDO2]]