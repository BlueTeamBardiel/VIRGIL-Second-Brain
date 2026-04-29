# encryption

## What it is
Think of encryption like a combination lock where scrambling your diary into gibberish — only someone with the exact combination can unscramble it back into readable words. Formally, encryption is the process of transforming plaintext into ciphertext using a mathematical algorithm and a key, making data unreadable to anyone who lacks the corresponding decryption key.

## Why it matters
In 2017, the WannaCry ransomware attack exploited unpatched Windows systems to encrypt victims' files using AES, then demanded Bitcoin payment for the decryption key — effectively holding hospitals and corporations hostage. This illustrates that encryption is a double-edged sword: the same mathematics that protects your bank login can be weaponized to extort you.

## Key facts
- **Symmetric encryption** (e.g., AES-256) uses the same key to encrypt and decrypt — fast, but key distribution is a problem
- **Asymmetric encryption** (e.g., RSA-2048) uses a public/private key pair — solves key distribution but is computationally slower
- **AES-256** is the current gold standard for symmetric encryption; considered quantum-resistant for now
- **Encryption at rest** protects stored data; **encryption in transit** (e.g., TLS 1.3) protects data moving across networks — Security+ distinguishes these scenarios explicitly
- Encryption provides **confidentiality** but NOT integrity or authentication on its own — you need hashing or digital signatures for those properties

## Related concepts
[[hashing]] [[public key infrastructure]] [[TLS]]