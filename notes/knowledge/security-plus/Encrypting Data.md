# Encrypting Data

## What it is

In Silent Hill, the town is shrouded in fog so dense you can only see a few feet ahead — Harry Mason knows the streets exist, the monsters exist, the missing daughter exists, but the fog renders all of it unreadable to anyone without the right vantage point. That's exactly what **encryption** does — it wraps data in a fog only the keyholder can see through.

**Encryption** is the reversible transformation of plaintext into ciphertext using a cryptographic algorithm and a key, such that the original data can only be recovered by a party possessing the correct decryption key.

## Why it matters

Without encryption, every laptop stolen from a coffee shop becomes a breach notification, every intercepted database query leaks PII, and every compliance auditor (HIPAA, PCI-DSS, GDPR) writes a finding that ends careers. SY0-701 Objective 1.4 explicitly tests **full-disk**, **partition**, **file**, **volume**, **database**, and **record-level** encryption, plus **transport/communication** encryption — and CompTIA's favorite trap is conflating *where* data is encrypted (at rest vs. in transit vs. in use) with *what granularity* it's encrypted at. Know both axes or lose the question.

## Key facts

### Encryption by data state

| State | Meaning | Typical mechanism |
|---|---|---|
| **At rest** | Data sitting on storage | [[Full-Disk Encryption]], [[BitLocker]], [[FileVault]], [[LUKS]] |
| **In transit** | Data moving across a network | [[TLS]], [[IPsec]], [[SSH]], [[HTTPS]] |
| **In use** | Data being processed in memory | [[Homomorphic Encryption]], [[Secure Enclave]], [[Confidential Computing]] |

### Encryption by scope (the granularity axis)

- **[[Full-Disk Encryption]] (FDE)** — Entire drive encrypted; unlocked at boot. Protects against physical theft. Useless once the OS is running and a user is logged in.
- **[[Partition Encryption]]** — Encrypts a single partition rather than the whole disk. Useful when only some volumes hold sensitive data.
- **[[Volume Encryption]]** — Logical volume (could span disks) encrypted as a unit. Think [[VeraCrypt]] containers or LVM-on-LUKS.
- **[[File-Level Encryption]] / [[File Encryption]]** — Individual files encrypted independently. Survives the file moving off the disk. Example: [[EFS]] (Encrypting File System) on Windows.
- **[[Database Encryption]]** — Encrypts the entire database file/tablespace. [[TDE]] (Transparent Data Encryption) is the canonical example — encrypts data files and backups without app changes.
- **[[Record-Level Encryption]]** — Encrypts individual rows/columns/fields. Allows different keys per record, supports multi-tenant isolation, but breaks indexing and joins unless you use [[Deterministic Encryption]] or [[Format-Preserving Encryption]].

### Algorithms the exam expects

| Type | Algorithms | Notes |
|---|---|---|
| **[[Symmetric Encryption]]** | [[AES]]-128/192/256, [[ChaCha20]], 3DES (legacy), DES (dead) | Fast, one shared key, key distribution problem |
| **[[Asymmetric Encryption]]** | [[RSA]] (2048+), [[ECC]], [[Diffie-Hellman]], [[ElGamal]] | Slow, key pair, solves distribution |
| **[[Hashing]]** (not encryption — one-way) | SHA-256, SHA-3, BLAKE2 | No key, no decryption |

### Critical supporting concepts

- **[[Key Management]]** — Encryption is only as strong as the key it relies on. See [[KMS]], [[HSM]], [[TPM]].
- **[[Trusted Platform Module]] (TPM)** — Hardware chip that stores FDE keys; binds disk to motherboard.
- **[[Hardware Security Module]] (HSM)** — Tamper-resistant device for enterprise key storage and crypto operations.
- **[[Key Escrow]]** — Third party holds a copy of the key. Recovery option, regulatory minefield.
- **[[Salting]]** and **[[Key Stretching]]** ([[PBKDF2]], [[bcrypt]], [[Argon2]], [[scrypt]]) — Defeat rainbow tables and brute force on password-derived keys.

### CompTIA traps to watch for

- **FDE does not protect a running, logged-in system.** A user with malware installed bypasses it entirely.
- **TDE protects the database file, not the SQL traffic.** You still need TLS for in-transit.
- **Hashing is not encryption.** If the question says "irreversible," it's hashing.
- **Asymmetric for key exchange, symmetric for bulk data.** TLS does both — RSA/ECDHE establishes the AES session key.

## Related concepts

[[Cryptography]] · [[Public Key Infrastructure]] · [[Digital Signatures]] · [[TLS]] · [[Key Management]] · [[Hashing]] · [[TPM]] · [[HSM]] · [[Data Loss Prevention]] · [[Tokenization]] · [[Obfuscation]]

---
*Source: VIRGIL knowledge base — 2026-05-08*