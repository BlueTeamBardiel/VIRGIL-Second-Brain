# Data Encryption

## What it is
Imagine locking a letter inside a combination safe — only someone who knows the combination can read it. Data encryption is the mathematical transformation of plaintext into unreadable ciphertext using an algorithm and a key, ensuring that intercepted data remains unintelligible without the corresponding decryption key.

## Why it matters
In 2017, the Equifax breach exposed 147 million Social Security numbers stored in plaintext — had the data been encrypted at rest, attackers would have walked away with useless ciphertext instead of a decade's worth of identity-theft ammunition. Encryption is the last line of defense when access controls fail.

## Key facts
- **Symmetric encryption** (AES-256) uses the same key to encrypt and decrypt — fast, ideal for bulk data at rest; the key distribution problem is its Achilles' heel
- **Asymmetric encryption** (RSA-2048) uses a public/private key pair — solves key distribution but is computationally expensive; used to encrypt small payloads or symmetric keys
- **AES-256** is the current NIST-approved standard for protecting data at rest; considered quantum-resistant for near-term threats
- **Encryption in transit** (TLS 1.3) vs. **encryption at rest** (BitLocker, VeraCrypt) are distinct controls — both are required for full data protection
- A Security+ exam favorite: encryption provides **confidentiality**, NOT integrity or availability — pair it with hashing (SHA-256) for integrity guarantees

## Related concepts
[[Symmetric vs Asymmetric Cryptography]] [[TLS/SSL]] [[Hashing]] [[PKI]] [[Key Management]]