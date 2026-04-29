# Zero-Knowledge Architecture

## What it is
Like a bank vault where even the bank employees can't open your safe-deposit box — the service provider holds your encrypted data but literally cannot read it. Zero-Knowledge Architecture (ZKA) is a design philosophy where a service provider stores and transmits only encrypted data, with encryption/decryption occurring exclusively on the client side, making the provider mathematically incapable of accessing plaintext content.

## Why it matters
In 2022, LastPass suffered a breach where attackers exfiltrated encrypted password vaults. Because LastPass implements zero-knowledge design, the stolen vaults were cryptographically useless to attackers without each user's master password — the company itself never possessed the keys. This demonstrates ZKA's core defensive value: a breach of the provider's infrastructure does not equal a breach of user data.

## Key facts
- The provider never receives, stores, or transmits decryption keys — all key derivation happens locally on the user's device before data leaves it
- Zero-Knowledge Architecture is distinct from Zero-Knowledge Proofs (a cryptographic protocol); ZKA is a systems design pattern, not a single algorithm
- Key derivation typically uses PBKDF2, bcrypt, or Argon2 to stretch the user's passphrase into an encryption key client-side before any server communication
- A critical attack surface remains the **client itself** — if malware compromises the endpoint, ZKA provides no protection because decryption happens there
- ZKA services cannot perform server-side search, content moderation, or account recovery without compromising their zero-knowledge guarantees — this is an inherent architectural tradeoff

## Related concepts
[[End-to-End Encryption]] [[Key Management]] [[Client-Side Encryption]] [[Zero-Knowledge Proofs]] [[Password Manager Security]]