# Key Management

## What it is
Think of cryptographic keys like master keys to a building: it doesn't matter how strong the locks are if someone leaves the master key under the doormat. Key management is the complete lifecycle of handling cryptographic keys — generation, distribution, storage, rotation, and destruction — ensuring they remain secret, available, and trustworthy throughout their operational life.

## Why it matters
In 2012, Dropbox suffered a breach where an employee's password (reused from the LinkedIn mega-breach) exposed millions of accounts — but the deeper lesson is that when key material or credentials aren't rotated after suspected exposure, one compromise cascades into many. Proper key management practices like automatic rotation, secure escrow, and revocation infrastructure (CRL/OCSP) are what contain the blast radius when a key is compromised.

## Key facts
- **Key escrow** stores a copy of the key with a trusted third party so encrypted data can be recovered if the original key is lost — but creates a high-value target for attackers.
- **Key stretching** algorithms (PBKDF2, bcrypt, Argon2) deliberately slow down key derivation from passwords, making brute-force attacks computationally expensive.
- **HSMs (Hardware Security Modules)** are tamper-resistant physical devices that generate, store, and use keys without ever exposing raw key material to the host OS.
- **Certificate revocation** via CRL or OCSP lets PKI infrastructure invalidate compromised keys before their natural expiration date.
- NIST SP 800-57 defines key management best practices and recommends minimum key lengths (e.g., 2048-bit RSA, 256-bit AES) based on security lifetime requirements.

## Related concepts
[[Public Key Infrastructure (PKI)]] [[Certificate Authority]] [[Hardware Security Module (HSM)]] [[Symmetric Encryption]] [[Key Escrow]]