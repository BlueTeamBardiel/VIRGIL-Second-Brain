# Encryption Technologies

## What it is

In Breath of the Wild, every shrine you complete grants a Spirit Orb, but you can't just hand orbs to a Goddess Statue and unlock heart containers — the statue has to recognize the offering, and only Link, carrying the right tokens, can complete the exchange. That's exactly what **encryption** does — it turns readable data into scrambled output that only someone holding the correct key can turn back into something meaningful.

**Encryption** is the process of transforming plaintext into ciphertext using a cryptographic algorithm and a key, such that the original data is recoverable only by parties possessing the corresponding decryption key.

## Why it matters

Without encryption, every password, credit card, health record, and corporate secret travels and rests in plaintext — one packet capture or stolen laptop away from disaster. Compliance regimes (**PCI DSS**, **HIPAA**, **GDPR**) mandate it explicitly, and breach notification laws often exempt encrypted data from disclosure requirements. The SY0-701 objective 1.4 expects you to distinguish symmetric vs. asymmetric, key length implications, and where each algorithm lives (transport, storage, email, etc.); CompTIA's favorite trap is conflating **hashing** with encryption — hashing is one-way, encryption is reversible by design.

## Key facts

### Symmetric vs. Asymmetric

| Property | [[Symmetric Encryption]] | [[Asymmetric Encryption]] |
|---|---|---|
| Keys | One shared secret | Public/private key pair |
| Speed | Fast | Slow (100–1000× slower) |
| Key distribution | Hard problem | Solved by design |
| Typical use | Bulk data encryption | Key exchange, signatures |
| Examples | [[AES]], [[ChaCha20]], [[3DES]] | [[RSA]], [[ECC]], [[Diffie-Hellman]] |

In practice, the two are paired: asymmetric crypto negotiates a session key, symmetric crypto encrypts the actual traffic. This is the **hybrid model** behind [[TLS]].

### Symmetric Algorithms

- **[[AES]]** — Advanced Encryption Standard, the modern default. Block sizes 128-bit, key sizes **128/192/256-bit**. Modes matter: **AES-GCM** (authenticated), **AES-CBC** (needs separate MAC), **AES-ECB** (never use — leaks patterns).
- **[[3DES]]** — deprecated; 168-bit key but only ~112-bit effective strength.
- **[[DES]]** — broken; 56-bit key. Historical only.
- **[[Blowfish]]** / **[[Twofish]]** — legacy alternatives.
- **[[ChaCha20]]** — stream cipher, used in TLS 1.3 and mobile contexts.

### Asymmetric Algorithms

- **[[RSA]]** — based on integer factorization. Common key sizes **2048-bit** (minimum acceptable), **3072-bit**, **4096-bit**.
- **[[ECC]]** ([[Elliptic Curve Cryptography]]) — equivalent strength at smaller keys (256-bit ECC ≈ 3072-bit RSA). Lower CPU/battery cost — preferred on mobile and IoT.
- **[[Diffie-Hellman]]** (**DH**, **ECDH**, **DHE**, **ECDHE**) — key exchange, not encryption per se. **Ephemeral** variants (DHE/ECDHE) provide [[Perfect Forward Secrecy]].

### Key Length and Strength

Bigger isn't always better — it's about **algorithm + length**. Equivalent security levels:

| Symmetric | RSA/DH | ECC |
|---|---|---|
| 128-bit | 3072-bit | 256-bit |
| 192-bit | 7680-bit | 384-bit |
| 256-bit | 15360-bit | 512-bit |

### Where encryption lives

- **[[Data at Rest]]** — [[Full Disk Encryption]] ([[BitLocker]], [[FileVault]], [[LUKS]]), [[Database Encryption]] (TDE), file-level encryption.
- **[[Data in Transit]]** — [[TLS]] (ports 443, 465, 993, 995), [[IPsec]], [[SSH]] (port 22), [[WPA3]].
- **[[Data in Use]]** — [[Homomorphic Encryption]], [[Secure Enclaves]] (Intel SGX, ARM TrustZone), [[Confidential Computing]].

### Modes and Adjacent Concepts

- **[[Block Cipher]]** vs. **[[Stream Cipher]]** — block processes fixed-size chunks (AES), stream processes bit-by-bit (ChaCha20, RC4-deprecated).
- **[[Initialization Vector]]** (IV) / **nonce** — ensures identical plaintexts produce different ciphertexts. Reuse breaks the cipher.
- **[[Salting]]** — applies to password hashing, not encryption proper, but CompTIA likes to test the distinction.
- **[[Key Stretching]]** — [[PBKDF2]], [[bcrypt]], [[scrypt]], [[Argon2]] — slow down brute force on password-derived keys.
- **[[Key Escrow]]** — third party holds a copy of the key. Useful for recovery, dangerous for trust.
- **[[HSM]]** ([[Hardware Security Module]]) — tamper-resistant key storage. **[[TPM]]** is its consumer cousin baked into motherboards.
- **[[Post-Quantum Cryptography]]** — NIST-selected algorithms (CRYSTALS-Kyber, CRYSTALS-Dilithium) preparing for the day [[Shor's Algorithm]] eats RSA and ECC alive.

### The Exam Traps

1. **Hashing ≠ encryption.** Hashing has no key and no decryption.
2. **Encoding ≠ encryption.** Base64 is not security.
3. **Obfuscation ≠ encryption.** ROT13 is a party trick.
4. **AES-256 is not "256× stronger" than AES-128.** Both are unbroken; 256-bit is mandated for some classified contexts and post-quantum hedging.
5. **PFS requires ephemeral key exchange** — static RSA key exchange does not provide it.

## Related concepts

[[Public Key Infrastructure]] · [[Digital Signatures]] · [[Hashing]] · [[Certificate Authority]] · [[TLS]] · [[IPsec]] · [[Key Management]] · [[Cryptographic Attacks]] · [[Steganography]] · [[Perfect Forward Secrecy]]

---
*Source: VIRGIL knowledge base — 2026-05-08*