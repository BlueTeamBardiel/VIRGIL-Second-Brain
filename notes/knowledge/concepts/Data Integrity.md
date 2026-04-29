# Data Integrity

## What it is
Like a wax seal on a medieval letter — if the seal is broken or forged, you know the message was tampered with. Data integrity is the assurance that information has not been altered, corrupted, or destroyed in an unauthorized or accidental way from its original state. It is one of the three pillars of the CIA Triad, sitting alongside Confidentiality and Availability.

## Why it matters
In 2020, the SolarWinds supply chain attack succeeded partly because malicious code was injected into software build pipelines, and no integrity verification caught the tampered binaries before distribution. Had cryptographic hashing been applied to build artifacts and compared against known-good values, defenders could have detected the modification before the backdoored software reached 18,000+ organizations.

## Key facts
- **Hashing algorithms** (SHA-256, SHA-3) produce a fixed-length digest; any change to the input, even one bit, produces a completely different hash — this is called the avalanche effect
- **HMAC (Hash-based Message Authentication Code)** adds a secret key to hashing, providing both integrity *and* authentication, not just integrity alone
- **Digital signatures** use asymmetric cryptography to verify both the source and integrity of data; they do NOT provide confidentiality
- **MD5 and SHA-1 are considered broken** for integrity purposes due to demonstrated collision attacks — avoid them in new implementations
- File integrity monitoring tools (Tripwire, AIDE) baseline file hashes and alert when unexpected changes occur — a core component of host-based intrusion detection

## Related concepts
[[Hashing]] [[Digital Signatures]] [[CIA Triad]] [[HMAC]] [[File Integrity Monitoring]]