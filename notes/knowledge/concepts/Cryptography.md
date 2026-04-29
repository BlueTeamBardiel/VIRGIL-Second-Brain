# cryptography

## What it is
Like a wax seal on a medieval letter — anyone can see the envelope, but breaking the seal reveals tampering, and only the intended recipient has the ring to verify it — cryptography uses mathematical algorithms to protect data confidentiality, integrity, and authenticity. It is the science of transforming readable plaintext into unintelligible ciphertext using keys, and reversing that process only for authorized parties.

## Why it matters
In 2011, RSA Security was breached and SecurID seed values were stolen — attackers later used those seeds to compromise Lockheed Martin's network by defeating two-factor authentication tokens. This attack demonstrated that even well-designed cryptographic systems fail catastrophically when key material is exposed, not because the math was broken, but because the secrets were stolen.

## Key facts
- **Symmetric encryption** (AES, 3DES) uses one shared key — fast, ideal for bulk data, but key distribution is the hard problem
- **Asymmetric encryption** (RSA, ECC) uses a public/private key pair — solves key distribution but is computationally expensive; RSA-2048 is current minimum for security
- **Hashing** (SHA-256, SHA-3) produces a fixed-length digest — it is one-way and used for integrity, not confidentiality; MD5 and SHA-1 are cryptographically broken
- **Key stretching** algorithms (PBKDF2, bcrypt, Argon2) deliberately slow down hashing to resist brute-force attacks against passwords
- **Perfect Forward Secrecy (PFS)** generates ephemeral session keys so that compromising a long-term private key does not decrypt past recorded traffic — critical for TLS 1.3

## Related concepts
[[public key infrastructure]] [[digital signatures]] [[hashing]] [[TLS]] [[key management]]