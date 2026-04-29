# Encryption Algorithms

## What it is
Think of encryption like a combination lock where the *design* of the lock is public knowledge, but only someone with the right combination (key) can open it — this is Kerckhoffs's Principle in action. Encryption algorithms are mathematical procedures that transform plaintext into ciphertext using a key, making data unreadable to anyone without the corresponding decryption key. They fall into two families: symmetric (same key encrypts and decrypts) and asymmetric (mathematically linked public/private key pairs).

## Why it matters
In 2011, Sony PlayStation Network suffered a breach exposing 77 million accounts — passwords were stored as unsalted MD5 hashes, which are technically a one-way function but so computationally weak that attackers cracked them en masse using rainbow tables within hours. Had Sony used a proper key-derivation function like bcrypt or PBKDF2, the cracking timeline would have jumped from hours to centuries, making the stolen data practically worthless.

## Key facts
- **AES-256** (Advanced Encryption Standard) is the current gold standard for symmetric encryption; NIST-approved and used in VPNs, disk encryption, and TLS
- **RSA** relies on the difficulty of factoring large prime numbers; key sizes below 2048-bit are considered insecure for modern use
- **Asymmetric encryption is ~1000x slower** than symmetric, which is why TLS uses RSA/ECC only to exchange a symmetric session key, then switches to AES
- **ECB mode** (Electronic Codebook) is a dangerous block cipher mode — identical plaintext blocks produce identical ciphertext blocks, leaking data patterns (the famous "ECB penguin" demonstrates this)
- **Key length ≠ algorithm strength** — a 128-bit AES key is stronger than a 1024-bit RSA key because they rely on completely different hard mathematical problems

## Related concepts
[[Symmetric vs Asymmetric Cryptography]] [[TLS Handshake]] [[Hashing Algorithms]]