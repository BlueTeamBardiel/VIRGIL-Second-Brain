# cryptographic

## What it is
Like a master locksmith's toolkit — some tools scramble messages into unreadable ciphertext, others create unforgeable wax seals, and others verify the lock hasn't been tampered with. Cryptographic refers to the mathematical techniques and algorithms used to protect information through confidentiality, integrity, and authenticity. It is the foundational discipline underlying virtually every security control in modern computing.

## Why it matters
In 2011, RSA Security was breached when attackers stole seed values for SecurID tokens — exploiting the cryptographic foundation of two-factor authentication itself. This demonstrated that even well-implemented systems fail catastrophically when the underlying cryptographic material is compromised, not just the algorithm. Protecting keys is as critical as choosing strong algorithms.

## Key facts
- The three core cryptographic goals map to the CIA triad: **confidentiality** (encryption), **integrity** (hashing/MACs), and **authenticity** (digital signatures)
- **Symmetric** cryptography uses one shared key (fast, e.g., AES-256); **asymmetric** uses a public/private key pair (slower, e.g., RSA-2048)
- **Cryptographic agility** — the ability to swap algorithms without redesigning systems — is a Security+ concept critical for post-quantum readiness
- A **cryptographic hash** is one-way and deterministic: the same input always produces the same fixed-length digest (SHA-256 = 256 bits), but you cannot reverse it
- **Weak or deprecated algorithms** (MD5, DES, RC4, SHA-1) are considered cryptographically broken and must not be used in new implementations

## Related concepts
[[encryption]] [[hashing]] [[digital signatures]] [[public key infrastructure]] [[symmetric vs asymmetric encryption]]