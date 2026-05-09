# Cryptographic Attacks

## What it is

In Sonic, Dr. Robotnik never beats Sonic in a footrace — he sets traps, exploits the level geometry, and waits for Sonic to grab the wrong ring. That's exactly what cryptographic attacks do — they don't outrun the math, they exploit the implementation, the protocol, or the human holding the key.

A **cryptographic attack** is any technique that defeats the confidentiality, integrity, or authenticity guarantees of a cryptosystem by targeting weaknesses in algorithms, keys, protocols, implementations, or the operators using them.

## Why it matters

If your cryptography fails, every control built on top of it fails with it — TLS, signed updates, password hashes, VPN tunnels, code signing, the works. SY0-701 Objective 2.4 explicitly lists **birthday**, **collision**, and **downgrade** attacks; CompTIA loves to bait you into picking "brute force" when the correct answer is the more specific named attack — and loves making you distinguish a downgrade attack from a plain on-path attack. Know the *mechanism*, not just the buzzword.

## Key facts

### Attacks against the math (algorithm/key)

| Attack | Mechanism | Defense |
|---|---|---|
| **[[Brute Force]]** | Try every possible key | Long keys (≥128-bit symmetric, ≥2048-bit RSA, ≥256-bit ECC) |
| **[[Birthday Attack]]** | Exploits the birthday paradox to find hash **collisions** in roughly 2^(n/2) attempts instead of 2^n | Use hashes with sufficient output (SHA-256, SHA-3) |
| **[[Collision Attack]]** | Find two inputs producing the same hash; breaks integrity and digital signatures | Retire MD5, SHA-1; use SHA-2/SHA-3 |
| **[[Known Plaintext]] / [[Chosen Plaintext]]** | Attacker has plaintext-ciphertext pairs and derives key info | Modern ciphers (AES) are designed resistant to these |

### Attacks against the protocol

| Attack | Mechanism | Defense |
|---|---|---|
| **[[Downgrade Attack]]** | Forces negotiation to weaker protocol/cipher (e.g., **POODLE** forced TLS→SSL 3.0) | Disable legacy protocols, enforce TLS 1.2+ minimum, HSTS |
| **[[Replay Attack]]** | Captures valid ciphertext and resends it | [[Nonces]], timestamps, sequence numbers |
| **[[On-Path Attack]]** (formerly MITM) | Intercepts and possibly alters crypto handshake | Certificate pinning, mutual TLS |

### Attacks against the implementation

- **[[Side-Channel Attack]]** — extracts secrets via timing, power consumption, electromagnetic emissions, or cache behavior. The math is fine; the chip is leaky. Defense: constant-time code, [[HSM]]s, blinding.
- **[[Padding Oracle Attack]]** — abuses error responses to decrypt CBC-mode ciphertext one byte at a time. Defense: authenticated encryption (AES-GCM), uniform error handling.

### Attacks against the humans and the keys

- **[[Key Stretching]] failures** — fast hashes (single-round SHA-256) on passwords enable **[[rainbow table]]** lookups. Defense: bcrypt, scrypt, Argon2, **[[salting]]**.
- **[[Pass-the-Hash]]** — steal the hash, authenticate without ever cracking the password. Defense: credential guard, no NTLM, just-in-time admin.
- **Weak [[Pseudorandom Number Generator|PRNG]]** — predictable randomness collapses key strength (see Debian OpenSSL 2008). Defense: CSPRNG seeded from OS entropy.

### Famous failures worth remembering

| Year | Name | Class |
|---|---|---|
| 2014 | **POODLE** | Downgrade + padding oracle on SSL 3.0 |
| 2014 | **Heartbleed** | Implementation bug leaking memory (not strictly crypto, but tested) |
| 2015 | **Logjam / FREAK** | Downgrade to export-grade DH/RSA |
| 2017 | **SHA-1 SHAttered** | Practical collision attack |
| 2018 | **Spectre/Meltdown** | Side-channel via speculative execution |

### CompTIA exam traps

- **Birthday vs. Collision**: birthday is the *statistical principle*; collision is the *goal*. If the question mentions "probability" or "two users with the same hash," think birthday.
- **Downgrade vs. On-Path**: downgrade specifically weakens the negotiated protocol; not every MITM is a downgrade.
- **Brute Force vs. Dictionary vs. Rainbow Table**: brute force tries all keys; dictionary uses a wordlist; rainbow tables are precomputed hash chains defeated by **salt**.

## Related concepts

[[Hashing]] · [[Digital Signatures]] · [[TLS]] · [[Salting]] · [[Key Stretching]] · [[HSM]] · [[Certificate Pinning]] · [[Perfect Forward Secrecy]] · [[Quantum Cryptography]]

---
*Source: VIRGIL knowledge base — 2026-05-08*