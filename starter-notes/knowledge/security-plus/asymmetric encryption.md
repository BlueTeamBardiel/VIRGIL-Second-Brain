---
domain: "cryptography"
tags: [cryptography, encryption, public-key, pki, asymmetric, security-fundamentals]
---
# asymmetric encryption

**Asymmetric encryption** (also called **public-key cryptography**) is a cryptographic system that uses a mathematically linked **key pair** — a **public key** and a **private key** — where data encrypted with one key can only be decrypted with the other. Unlike [[symmetric encryption]], asymmetric encryption eliminates the need to share a secret key over an insecure channel. It forms the backbone of modern secure communications, including [[TLS]], [[PKI]], [[digital signatures]], and [[SSH]].

---

## Overview

Asymmetric encryption was publicly introduced by Whitfield Diffie and Martin Hellman in their landmark 1976 paper *"New Directions in Cryptography,"* though classified work by GCHQ's James Ellis, Clifford Cocks, and Malcolm Williamson had arrived at the same conclusions years earlier. The fundamental insight was that two parties could establish secure communication over a completely insecure channel without ever having met to exchange a secret — a revolutionary departure from all prior cryptographic thinking, which required a pre-shared secret.

The security of asymmetric cryptography rests on mathematical problems that are computationally easy to perform in one direction but practically infeasible to reverse. RSA relies on the difficulty of **integer factorization** — given the product of two very large prime numbers, finding the original primes is computationally intractable at sufficient key sizes. Elliptic Curve Cryptography (ECC) relies on the **elliptic curve discrete logarithm problem (ECDLP)**, which provides equivalent security to RSA at dramatically smaller key sizes (a 256-bit ECC key is roughly equivalent in strength to a 3072-bit RSA key). Diffie-Hellman key exchange relies on the **discrete logarithm problem** in a finite field.

In practice, asymmetric encryption is rarely used to encrypt bulk data directly because it is orders of magnitude slower than symmetric encryption — RSA encryption of a 1 MB file is thousands of times slower than AES encryption of the same file. Instead, asymmetric cryptography is used in **hybrid encryption schemes**: the asymmetric system securely exchanges or establishes a symmetric session key, and all subsequent bulk data encryption uses that faster symmetric key. TLS exemplifies this precisely — the TLS handshake uses asymmetric operations (RSA key exchange or ECDHE) to negotiate a symmetric session key (AES), which then encrypts the actual HTTP traffic.

The key pair relationship is foundational. The **public key** is freely distributed and can be shared with anyone in the world without compromising security. The **private key** must be kept secret by its owner; compromise of the private key destroys all security guarantees. The mathematical relationship between the two keys ensures that knowing the public key provides no computationally feasible path to deriving the private key, given current algorithms and sufficient key length. This asymmetry is what makes the entire system viable.

Real-world deployment of asymmetric cryptography is managed through [[Public Key Infrastructure (PKI)]], a framework of policies, procedures, hardware, software, and roles that manages the creation, distribution, usage, storage, and revocation of digital certificates. Certificate Authorities (CAs) digitally sign certificates that bind a public key to an identity, allowing relying parties to trust that a given public key genuinely belongs to the entity claiming it — solving the critical problem of public key authentication.

---

## How It Works

### Mathematical Foundation

Asymmetric encryption relies on **trapdoor functions** — operations that are easy to compute forward but computationally infeasible to reverse without secret information (the "trapdoor"). The three dominant families are:

| Algorithm Family | Hard Problem | Common Algorithms |
|---|---|---|
| RSA | Integer factorization | RSA-2048, RSA-4096 |
| Elliptic Curve | ECDLP | ECDSA, ECDH, Ed25519 |
| Diffie-Hellman | Discrete logarithm | DH, DHE, ECDHE |

### RSA Key Generation (Step-by-Step)

1. **Choose two large prime numbers** `p` and `q` (e.g., each 1024 bits for RSA-2048)
2. **Compute modulus** `n = p × q` — this is public
3. **Compute Euler's totient** `φ(n) = (p-1)(q-1)`
4. **Choose public exponent** `e` such that `1 < e < φ(n)` and `gcd(e, φ(n)) = 1` — commonly `65537`
5. **Compute private exponent** `d` such that `d × e ≡ 1 (mod φ(n))` — this is the trapdoor
6. **Public key** = `(n, e)` | **Private key** = `(n, d)`

**Encryption:** `ciphertext = plaintext^e mod n`
**Decryption:** `plaintext = ciphertext^d mod n`

The security rests entirely on the fact that factoring `n` back into `p` and `q` is computationally infeasible for sufficiently large values.

### Encryption vs. Signing: Two Modes of Operation

Asymmetric key pairs serve **two distinct purposes** with opposite key usage:

**For Confidentiality (Encryption):**
- Sender encrypts with recipient's **public key**
- Only the recipient, holding the **private key**, can decrypt
- Anyone can send an encrypted message; only one person can read it

**For Authentication (Digital Signatures):**
- Signer encrypts a hash of the message with their own **private key**
- Verifier decrypts with the signer's **public key** and compares hashes
- Anyone can verify; only one person could have produced the signature

### Practical Example: RSA Operations with OpenSSL

Generate a 4096-bit RSA key pair:
```bash
# Generate private key
openssl genrsa -out private.pem 4096

# Extract the public key from the private key
openssl rsa -in private.pem -pubout -out public.pem

# Inspect the key structure
openssl rsa -in private.pem -text -noout
```

Encrypt and decrypt a file using RSA:
```bash
# Encrypt a small file using the recipient's public key
openssl rsautl -encrypt -inkey public.pem -pubin -in secret.txt -out secret.enc

# Decrypt using the private key
openssl rsautl -decrypt -inkey private.pem -in secret.enc -out decrypted.txt
```

Create and verify a digital signature:
```bash
# Sign a file (hash + encrypt with private key)
openssl dgst -sha256 -sign private.pem -out signature.bin document.pdf

# Verify signature using the public key
openssl dgst -sha256 -verify public.pem -signature signature.bin document.pdf
```

### ECC Key Generation with OpenSSL

```bash
# Generate an EC private key using the NIST P-256 curve
openssl ecparam -name prime256v1 -genkey -noout -out ec_private.pem

# Extract the public key
openssl ec -in ec_private.pem -pubout -out ec_public.pem

# View key parameters
openssl ec -in ec_private.pem -text -noout
```

### The Diffie-Hellman Key Exchange Protocol

ECDHE (Elliptic Curve Diffie-Hellman Ephemeral) is widely used in TLS 1.3 for **forward secrecy**:

1. Both parties agree on a public elliptic curve and base point `G`
2. Alice chooses secret `a`, computes and sends `A = a × G`
3. Bob chooses secret `b`, computes and sends `B = b × G`
4. Alice computes shared secret: `S = a × B = a × b × G`
5. Bob computes shared secret: `S = b × A = b × a × G`
6. Both arrive at identical `S` — which becomes the symmetric session key material
7. An eavesdropper sees `A` and `B` but cannot compute `S` without solving ECDLP

### Key Sizes and Equivalent Security

```
RSA-1024  ≈ 80-bit symmetric  (BROKEN - do not use)
RSA-2048  ≈ 112-bit symmetric (minimum acceptable today)
RSA-3072  ≈ 128-bit symmetric (recommended)
RSA-4096  ≈ 140-bit symmetric (high security)
ECC-256   ≈ 128-bit symmetric (NIST P-256, widely deployed)
ECC-384   ≈ 192-bit symmetric (NSA Suite B high security)
```

---

## Key Concepts

- **Public Key**: The openly distributed half of an asymmetric key pair. It can be freely shared with anyone. Used to encrypt messages to the key owner, or to verify signatures the key owner has made. Knowing the public key reveals nothing about the private key.

- **Private Key**: The secret half of the key pair that must never be disclosed. It is used to decrypt messages encrypted with the corresponding public key, or to create digital signatures. Compromise of the private key invalidates all past (unless forward secrecy was used) and future communications secured with that key pair.

- **Digital Signature**: A cryptographic construct created by hashing a message and encrypting the hash with the signer's private key. Recipients verify by decrypting with the public key and comparing hashes. Provides **authentication**, **integrity**, and **non-repudiation** simultaneously.

- **Key Encapsulation / Hybrid Encryption**: The real-world pattern where asymmetric cryptography is used only to securely exchange a symmetric session key (e.g., an AES-256 key), after which all bulk data is encrypted with the faster symmetric algorithm. This is how TLS, PGP, and S/MIME all operate in practice.

- **Forward Secrecy (Perfect Forward Secrecy / PFS)**: A property achieved by using **ephemeral** key pairs (DHE or ECDHE) for key exchange, meaning that even if a server's long-term private key is later compromised, past session keys cannot be derived, and past recorded traffic cannot be decrypted. TLS 1.3 mandates forward secrecy.

- **Non-Repudiation**: A security property provided by digital signatures using asymmetric cryptography. Because only the holder of the private key could have produced a valid signature, the signer cannot credibly deny having signed the document. This is legally significant in PKI deployments.

- **Trapdoor Function**: A mathematical function that is easy to compute in the forward direction but computationally infeasible to reverse without knowledge of special secret information (the "trapdoor"). RSA's trapdoor is the private exponent `d`; ECC's trapdoor is the private scalar `k`.

- **Certificate Authority (CA)**: A trusted third party that uses its own private key to digitally sign certificates, binding a subject's identity to their public key. Browsers and operating systems ship with a set of trusted root CA certificates. The entire TLS trust model rests on this hierarchy.

---

## Exam Relevance

**SY0-701 Domain Mapping:** Domain 1.4 (Cryptographic Solutions) — Asymmetric encryption is heavily tested.

### Critical Facts to Memorize

- **RSA** — most common asymmetric algorithm; used for encryption and signatures; security based on integer factorization
- **ECC** — smaller keys, same strength; based on ECDLP; used in mobile and IoT due to efficiency
- **DSA (Digital Signature Algorithm)** — signature-only algorithm (cannot encrypt), used with SHA (DSS standard)
- **Diffie-Hellman** — key exchange protocol, not encryption per se; DHE/ECDHE provides forward secrecy
- **El Gamal** — asymmetric system used in PGP; based on discrete logarithm

### Common Question Patterns

**"Which algorithm provides non-repudiation?"**
→ Any asymmetric algorithm used for **digital signatures** (RSA, DSA, ECDSA). Non-repudiation requires asymmetric crypto because symmetric shared keys mean either party could have produced the message.

**"A user needs to send an encrypted email to a colleague. Which key does the sender use to encrypt?"**
→ The **recipient's public key**. This is one of the most commonly missed questions. The sender uses the recipient's public key; the recipient decrypts with their own private key.

**"Which provides perfect forward secrecy?"**
→ **DHE or ECDHE** (ephemeral Diffie-Hellman variants). Static DH and RSA key exchange do NOT provide PFS.

**"Which asymmetric algorithm uses the smallest key size for equivalent security?"**
→ **ECC** (Elliptic Curve Cryptography)

### Common Gotchas

- **RSA-1024 is considered broken** — minimum is RSA-2048 for new deployments
- **Asymmetric is slow** — never used for bulk data encryption alone; always hybrid
- **Public key ≠ certificate** — a certificate is a public key plus identity information plus a CA signature
- **DSA is signature-only** — it cannot be used to encrypt data, only to sign
- **Diffie-Hellman is a key exchange, not an encryption algorithm** — this distinction appears on exams

---

## Security Implications

### Algorithm Weaknesses and Vulnerabilities

**PKCS#1 v1.5 RSA Padding Oracle (Bleichenbacher's Attack, CVE-1998-0159 class):** Daniel Bleichenbacher's 1998 attack demonstrated that RSA encryption with PKCS#1 v1.5 padding is vulnerable to adaptive chosen-ciphertext attacks if an oracle reveals whether decryption produced valid padding. The attacker iteratively submits modified ciphertexts and uses the oracle's responses to eventually decrypt the original message. Thousands of TLS implementations were found vulnerable to variants of this attack, most notably **ROBOT (Return Of Bleichenbacher's Oracle Threat)** in 2017, which affected major vendors including F5, Citrix, Cisco, and Bouncy Castle. NIST recommends OAEP (Optimal Asymmetric Encryption Padding) for RSA encryption to mitigate this class of attacks.

**ROCA Vulnerability (CVE-2017-15361):** A critical flaw discovered in 2017 in the RSA key generation library used by Infineon Technologies in millions of smartcards, TPMs, and hardware security modules (HSMs). The generated primes followed a predictable structure that reduced the effective security of RSA-2048 keys to approximately 80 bits, making them factorable in hours to days using cloud computing. Affected devices included Estonian national ID cards, YubiKey 4 series, and numerous enterprise TPM implementations.

**Quantum Computing Threat:** Shor's Algorithm, if implemented on a sufficiently powerful quantum computer, can factor large integers and solve discrete logarithm problems in polynomial time, theoretically breaking RSA, DSA, and ECDSA. This has driven NIST's Post-Quantum Cryptography (PQC) standardization effort, which in 2024 released its first finalized PQC standards including **CRYSTALS-Kyber** (now ML-KEM) for key encapsulation and **CRYSTALS-Dilithium** (now ML-DSA) for digital signatures.

**Private Key Compromise:** If a private key is stolen, all communications protected with that key pair are vulnerable (past sessions too, unless forward secrecy was used). Notable incidents include the 2011 DigiNotar breach, where attackers compromised a CA's private keys and issued fraudulent certificates for Google, used in man-in-the-middle attacks against Iranian users.

**Weak Random Number Generation:** RSA and ECC key generation depends entirely on cryptographically strong randomness. The **Debian OpenSSL PRNG bug (2008, CVE-2008-0166)** crippled random number generation in Debian-based systems for two years, reducing the effective keyspace of generated keys to roughly 32,768 possibilities. Security researchers subsequently enumerated and cracked a significant fraction of all SSH and SSL keys generated on affected systems.

---

## Defensive Measures

### Key Size and Algorithm Selection

```
# Recommended minimum key sizes (2024 and beyond):
RSA:     4096 bits (2048 is minimum acceptable; plan migration to PQC)
ECC:     256 bits minimum (P-256 or Curve25519)
DH:      3072 bits minimum for