# Non-repudiation

## What it is

In Half-Life, when Gordon Freeman swings the crowbar and breaks a crate, the physics engine logs that hit to *him* — the G-Man can't claim Barney did it, and Gordon can't pretend the crate broke itself. That's exactly what **non-repudiation** does — it makes sure the person who performed an action cannot later deny they performed it.

**Non-repudiation** is the cryptographic and procedural assurance that a sender of a message or performer of an action cannot credibly deny authorship, typically achieved through [[digital signatures]] and verifiable logging.

## Why it matters

Without non-repudiation, contracts collapse, audit trails become fiction, and any user caught misbehaving can simply say "wasn't me." It underpins legal admissibility of electronic transactions, regulatory compliance ([[SOX]], [[HIPAA]], [[PCI-DSS]]), and forensic investigations. On the SY0-701 exam, Objective **1.2** lists non-repudiation alongside the [[CIA triad]] as a core security pillar — the trap CompTIA sets is conflating it with [[authentication]] (proving who you are) or [[integrity]] (proving data wasn't changed). Non-repudiation requires *both* plus a verifiable third-party-checkable record. If a question mentions "the user denies sending the email" or "prove the transaction occurred," the answer is non-repudiation, and the mechanism is almost always a [[digital signature]].

## Key facts

### How non-repudiation is achieved

| Mechanism | What it provides | How it works |
|---|---|---|
| [[Digital signatures]] | Sender non-repudiation | Sender hashes message, encrypts hash with their **private key**; anyone with the **public key** verifies it |
| [[Hashing]] | Integrity (component of NR) | One-way function (e.g., **SHA-256**) produces fixed-length fingerprint |
| [[Public Key Infrastructure]] (PKI) | Trust anchor | Binds public keys to verified identities via [[Certificate Authority]] |
| [[Audit logs]] | Action non-repudiation | Tamper-evident records tied to authenticated user sessions |
| [[Blockchain]] | Distributed non-repudiation | Immutable ledger; no single party can rewrite history |

### The three ingredients

A claim of non-repudiation requires **all three**:

1. **Authentication** — the actor's identity was verified ([[MFA]], certificates, biometrics)
2. **Integrity** — the action/message has not been altered ([[hashing]])
3. **Verifiable proof** — a third party can independently confirm 1 and 2 ([[digital signature]] using asymmetric crypto)

### Why symmetric crypto cannot provide non-repudiation

If Alice and Bob share a single secret key (e.g., **AES**), either could have produced the [[MAC]] (Message Authentication Code). Bob can't prove to a judge it was Alice — he had the same key. **Asymmetric cryptography** ([[RSA]], [[ECDSA]], [[Ed25519]]) solves this: only Alice holds her **private key**, so only she could have signed.

### Common exam scenarios

- **Email signing** — [[S/MIME]] or [[PGP]] signatures prove the sender wrote it
- **Code signing** — vendor cannot deny releasing a malicious update
- **Financial transactions** — signed transaction logs prevent "I never authorized that wire"
- **Legal documents** — [[DocuSign]]-style signatures with PKI backing
- **Smart cards / [[CAC]] / [[PIV]] cards** — government access logs tied to certificate-based auth

### What breaks non-repudiation

- **Private key compromise** — if Alice's key is stolen, she has plausible deniability ("not me, the attacker")
- **Shared accounts** — generic admin logins destroy individual accountability
- **Weak/broken hashes** — [[MD5]] and [[SHA-1]] collisions allow forged signatures
- **Missing or mutable logs** — append-only ([[WORM]]) storage matters
- **No timestamp authority** — without trusted time, "when" becomes deniable

## Related concepts

[[Digital signatures]] · [[Public Key Infrastructure]] · [[Hashing]] · [[Asymmetric encryption]] · [[CIA triad]] · [[Authentication]] · [[Integrity]] · [[Audit logging]] · [[Certificate Authority]] · [[Code signing]]

---
*Source: VIRGIL knowledge base — 2026-05-08*