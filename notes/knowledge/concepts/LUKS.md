# LUKS

## What it is
Think of LUKS like a bank vault door built into your hard drive — the vault exists before any contents are stored, and the key you use to open it never changes even if you change your PIN. LUKS (Linux Unified Key Setup) is a disk encryption specification for Linux that provides full-volume encryption by storing all cryptographic metadata in a standardized header at the beginning of the encrypted partition. Unlike simpler encryption schemes, LUKS supports multiple decryption keys (key slots), allowing several passphrases or keyfiles to unlock the same volume.

## Why it matters
A stolen laptop containing sensitive customer data is a classic compliance nightmare — but if the drive is LUKS-encrypted, an attacker pulling the drive and mounting it on another machine gets nothing but ciphertext. This directly satisfies data-at-rest requirements under frameworks like HIPAA and PCI-DSS, and is why forensic investigators must obtain the passphrase or keyfile *before* the system powers down, since cold-boot attacks become the primary residual risk.

## Key facts
- LUKS uses **AES-256 in XTS mode** by default on modern systems (via `cryptsetup`), with PBKDF2 or Argon2 for key derivation
- The LUKS **header stores the master key encrypted under each slot's derived key** — compromise one passphrase and the master key is exposed
- Supports **up to 8 key slots**, enabling multiple authorized users or recovery keys on the same volume
- **Header backup is critical** — a corrupted LUKS header without a backup means permanent, unrecoverable data loss
- LUKS protects against **offline attacks only**; a mounted volume is fully accessible to any process with root privileges

## Related concepts
[[Full Disk Encryption]] [[AES]] [[Key Derivation Functions]] [[Data at Rest]] [[BitLocker]]