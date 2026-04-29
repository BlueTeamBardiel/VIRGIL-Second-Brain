# HSM

## What it is
Think of an HSM like a bank vault with a built-in calculator — you pass money *in* for counting, but the cash never leaves the vault. A Hardware Security Module (HSM) is a dedicated physical device that generates, stores, and performs cryptographic operations with private keys, ensuring those keys never exist in plaintext outside the hardened hardware boundary. It is tamper-evident and tamper-resistant, designed to zeroize its contents if physically attacked.

## Why it matters
In 2011, RSA Security was breached and attackers stole seed values related to SecurID tokens — a compromise that could have been mitigated had those values been protected inside an HSM rather than software-accessible storage. Organizations using HSMs for Certificate Authority private keys prevent scenarios where a stolen key allows attackers to forge trusted certificates for any domain, enabling silent man-in-the-middle attacks at scale.

## Key facts
- HSMs are evaluated against **FIPS 140-2/140-3** standards; Level 3 requires physical tamper-resistance and identity-based authentication, Level 4 adds environmental attack protection
- They perform crypto operations **on-device** — the private key material never leaves the HSM boundary in usable form
- Used by Certificate Authorities, payment processors (PCI-DSS requires HSMs for PIN block encryption), and PKI infrastructure
- HSMs provide **secure key lifecycle management**: generation, storage, rotation, and destruction — all auditable
- Cloud equivalents (AWS CloudHSM, Azure Dedicated HSM) provide single-tenant HSM hardware, unlike shared KMS services

## Related concepts
[[PKI]] [[Key Management]] [[FIPS 140-2]] [[TPM]] [[Certificate Authority]]