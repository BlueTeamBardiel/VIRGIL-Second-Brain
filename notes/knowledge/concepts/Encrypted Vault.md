# Encrypted Vault

## What it is
Like a bank's safe-deposit room where even the bank manager can't read your documents without your personal key, an encrypted vault is a protected storage container that uses strong cryptography to render data unreadable to anyone lacking the decryption credentials. Precisely, it is a secured data store — software or hardware-based — that encrypts contents at rest using algorithms such as AES-256, requiring authentication before any data can be accessed or decrypted.

## Why it matters
In the 2019 LastPass-style credential manager attacks, adversaries who breached the server infrastructure still could not immediately exploit stored passwords because each user's vault was encrypted with a key derived from their master password — the attacker walked away with ciphertext, not plaintext secrets. This demonstrates why encrypting data at rest inside a vault is a critical defense-in-depth layer: a successful breach of the perimeter doesn't automatically mean a breach of the data.

## Key facts
- Vaults commonly use **AES-256** for symmetric encryption of stored data combined with **PBKDF2, bcrypt, or Argon2** to derive encryption keys from user passwords, making brute-force costly
- **Key management** is the hardest problem — if the encryption key is stored alongside the vault, the protection is effectively nullified
- Hardware Security Modules (HSMs) and Trusted Platform Modules (TPMs) provide tamper-resistant physical vaults for cryptographic keys
- Zero-knowledge architecture means the vault provider never possesses your decryption key — relevant for password managers and cloud secret stores
- **Secrets management vaults** (e.g., HashiCorp Vault) extend the concept to dynamically generate and rotate credentials, reducing long-lived secret exposure

## Related concepts
[[Encryption at Rest]] [[Key Management]] [[Hardware Security Module]] [[Secrets Management]] [[Zero-Knowledge Architecture]]