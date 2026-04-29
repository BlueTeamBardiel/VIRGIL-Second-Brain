# Authenticated Encryption

## What it is
Think of it like a tamper-evident envelope with a combination lock: it keeps the letter secret *and* proves nobody swapped the contents in transit. Authenticated Encryption (AE) is a cryptographic mode that simultaneously provides **confidentiality** (encryption) and **integrity/authenticity** (a MAC or tag) in a single operation, ensuring ciphertext cannot be decrypted if it has been modified.

## Why it matters
In 2011, attackers exploited CBC-mode encryption without authentication in SSL/TLS using the **BEAST attack** and later **padding oracle attacks** — ciphertext was malleable because integrity wasn't verified before decryption. Authenticated Encryption with Associated Data (AEAD), as used in TLS 1.3 via AES-GCM, eliminates this class of attack by rejecting any tampered ciphertext *before* decryption even begins.

## Key facts
- **AES-GCM** (Galois/Counter Mode) is the most common AEAD cipher suite, used in TLS 1.3, IPSec, and SSH; it appends a 128-bit authentication tag.
- AEAD allows "associated data" — headers or metadata that are authenticated but **not encrypted** (e.g., IP headers you need in plaintext but can't allow tampering with).
- The golden rule: **verify the tag before decrypting**. Decrypting-then-verifying exposes systems to padding oracle and chosen-ciphertext attacks.
- **Nonce reuse is catastrophic** in AES-GCM — reusing a nonce with the same key leaks the authentication key and can expose plaintext (see "Nonce-Disrespecting Adversaries" attack on TLS).
- ChaCha20-Poly1305 is the AEAD alternative preferred for resource-constrained devices and is also mandatory in TLS 1.3.

## Related concepts
[[AES-GCM]] [[TLS 1.3]] [[Message Authentication Code (MAC)]] [[Padding Oracle Attack]] [[Symmetric Encryption]]