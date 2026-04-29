# ECC

## What it is
Imagine two people agreeing on a secret meeting point by bouncing a ball along a curved racetrack — the math of where it lands is trivial to follow forward, but nearly impossible to reverse-engineer from the endpoint alone. Elliptic Curve Cryptography (ECC) is an asymmetric encryption approach that bases its security on the computational difficulty of the **elliptic curve discrete logarithm problem** — finding the scalar multiplier *k* given points P and Q where Q = kP. It achieves equivalent security to RSA with dramatically smaller key sizes.

## Why it matters
Modern TLS handshakes increasingly rely on **ECDHE** (Elliptic Curve Diffie-Hellman Ephemeral) to establish session keys, providing forward secrecy. If an attacker records encrypted traffic today hoping to decrypt it later with a stolen private key, ECDHE defeats this because each session generates a fresh key pair — the server's long-term key never directly encrypts session data.

## Key facts
- A **256-bit ECC key** provides roughly equivalent security to a **3072-bit RSA key** — smaller keys mean faster operations and lower power consumption, critical for IoT and mobile
- ECC is foundational to **ECDSA** (Elliptic Curve Digital Signature Algorithm), used in Bitcoin, TLS certificates, and code signing
- The **NIST P-256** curve is the most commonly deployed ECC curve in TLS; Curve25519 is preferred in modern protocols like Signal for its resistance to implementation errors
- ECC does **not** encrypt data directly — it's used for key exchange and digital signatures, not bulk encryption
- **Quantum computers** running Shor's algorithm could break ECC, which is why NIST's post-quantum cryptography standards (e.g., CRYSTALS-Kyber) are being developed as replacements

## Related concepts
[[Asymmetric Encryption]] [[Diffie-Hellman]] [[Digital Signatures]] [[PKI]] [[Post-Quantum Cryptography]]