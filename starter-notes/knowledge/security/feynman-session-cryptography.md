---
domain: "cryptography"
tags: [cryptography, symmetric, asymmetric, hashing, pki, security-plus, feynman-session]
session-date: 2025-11-08
---

# Feynman Session — Cryptography Fundamentals

*VIRGIL `/cysa` session — 2025-11-08. Goal: close the gaps on PKI before Security+ exam.*

---

## The Gaps VIRGIL Found

Running through cryptography concepts, VIRGIL's pushback revealed three real gaps:

1. **Confusing key exchange with encryption** — I was describing Diffie-Hellman as an encryption algorithm. It isn't. It's a *key agreement* protocol. The output is a shared secret; you then use that secret as the key for a symmetric cipher (like AES). DH itself never encrypts anything.

2. **Certificate chain of trust** — I could define "root CA" and "intermediate CA" but couldn't explain *why* intermediate CAs exist. The answer: you keep the root CA air-gapped and offline. If an intermediate CA is compromised, you revoke it without touching the root. The root's private key never has to be exposed online.

3. **OCSP vs CRL** — I knew both check certificate revocation. I didn't know the operational difference: CRL is a downloaded list (big, cached, can be stale); OCSP is a real-time query (smaller, fresher, but the CA knows who's checking what). OCSP stapling solves the privacy issue by having the server pre-fetch and "staple" the OCSP response to the TLS handshake.

---

## The Concepts (Properly This Time)

### Symmetric vs Asymmetric — The Hotel Safe Analogy

**Symmetric encryption** is a shared key. Everyone who needs access to the data gets a copy of the same key. Fast, efficient. Problem: how do you securely hand out the key in the first place? You can't encrypt the key without already having an agreed key. This is the *key distribution problem*.

**Asymmetric encryption** solves the distribution problem. You get two mathematically linked keys: a public key (give this to everyone) and a private key (never share). Data encrypted with your public key can only be decrypted with your private key. Now you can publish your public key openly and anyone can send you an encrypted message without a prior secret agreement.

Trade-off: asymmetric is ~1000x slower than symmetric. Real-world TLS solves this by using asymmetric crypto to agree on a symmetric key (via DH), then using symmetric crypto (AES) for everything else. The expensive part is short; the fast part does the bulk of the work.

### Hashing — One-Way Street

A hash function takes arbitrary-length input and produces fixed-length output (the "digest"). Properties:
- **Deterministic**: same input always produces same output
- **One-way**: cannot reverse the digest back to input
- **Avalanche effect**: changing one bit in input changes ~50% of the output bits
- **Collision resistant**: infeasible to find two different inputs with the same digest

Common exam hashes:
| Algorithm | Output size | Status |
|-----------|-------------|--------|
| MD5 | 128 bits (32 hex chars) | Broken — don't use for security |
| SHA-1 | 160 bits | Deprecated — broken for collision resistance |
| SHA-256 | 256 bits | Current standard |
| SHA-3 | 256–512 bits | Newer, different internal design (Keccak sponge) |

**Salting** — adds a random value to a password before hashing, stored alongside the hash. Defeats rainbow table attacks. Even two users with the same password get different hashes.

**Password hashing != data hashing.** For passwords, you want *slow* functions (bcrypt, scrypt, Argon2) to make brute force expensive. For file integrity, you want *fast* functions (SHA-256) because you're not defending against a guessing attack.

### PKI — The Web of Trust

PKI (Public Key Infrastructure) is the system that answers: "how do I know this public key actually belongs to who they claim?"

The answer: a **Certificate Authority** (CA) signs a certificate that binds a public key to an identity. The signature lets you verify the binding using the CA's own public key.

**Certificate chain:**
```
Root CA (self-signed, offline, trust anchor)
  └── Intermediate CA (signed by root, online)
        └── End-entity certificate (signed by intermediate, your website)
```

When your browser validates `bank.example.com`:
1. Receives the site's certificate
2. Checks the signature — was it signed by a trusted intermediate CA?
3. Checks the intermediate's certificate — was it signed by a trusted root CA?
4. Is that root CA in the browser's trust store?
5. Is the certificate valid (not expired, not revoked)?

All five steps must pass.

**Revocation** — what happens when a certificate's private key is compromised?

- **CRL (Certificate Revocation List)**: CA publishes a list of revoked serial numbers. Browser downloads and caches it. Can be stale by hours or days.
- **OCSP (Online Certificate Status Protocol)**: Browser queries the CA's OCSP responder in real-time. Fresh but creates privacy issue (CA knows what sites you visit) and adds latency.
- **OCSP Stapling**: Server periodically fetches its own OCSP response and "staples" it to the TLS handshake. Browser gets freshness without querying the CA directly. Solves privacy and latency.

---

## Exam Traps to Remember

- **DH is key agreement, not encryption.** It produces a shared secret. You then encrypt with that secret using a symmetric cipher.
- **RSA can both encrypt and sign** — but these are different operations with different key roles. When signing: hash the data, encrypt the hash with your *private* key. When encrypting: use the recipient's *public* key.
- **"Asymmetric is more secure"** is a trick answer. Asymmetric and symmetric serve different purposes. AES-256 is extremely strong. Asymmetric is used for key exchange and signatures, not bulk encryption, because it's slow.
- **MD5 is broken for security** but still used for non-security checksums (file integrity verification where collision attacks aren't a threat model). The exam will try to make you say MD5 is useless for everything — it isn't, it's just useless for *security*.
- **Salt defeats rainbow tables, not brute force.** A salted hash still has to be brute-forced per-hash. Salt just forces the attacker to crack each hash individually instead of using precomputed tables.

---

## Linked Notes

- [[symmetric encryption]]
- [[asymmetric encryption]]
- [[Diffie-Hellman]]
- [[PKI]]
- [[certificate authority]]
- [[OCSP]]
- [[CRL]]
- [[SHA-256]]
- [[bcrypt]]
- [[brute force]]

## Tags

cryptography, security-plus, feynman-session, pki, hashing, symmetric, asymmetric
