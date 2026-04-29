# Key Derivation

## What it is
Like a master key cut into dozens of unique sub-keys for different doors — all traceable to one original blank — key derivation is the cryptographic process of generating one or more secret keys from a single master secret or password using a deterministic algorithm. A Key Derivation Function (KDF) takes input key material (IKM) and produces output keying material (OKM) that is computationally independent from the source.

## Why it matters
In the 2012 LinkedIn breach, 6.5 million passwords were cracked rapidly because they used unsalted SHA-1 hashes — a raw hash, not a proper KDF. A proper password KDF like bcrypt or Argon2 adds a unique salt and deliberate computational cost, meaning an attacker with the same database would need years of GPU time instead of hours. This single design choice separates a catastrophic breach from a manageable one.

## Key facts
- **PBKDF2** (Password-Based Key Derivation Function 2) is the most exam-tested KDF — it applies a pseudorandom function thousands of iterations to slow brute-force attacks
- **Salt** is a random value added before hashing to prevent rainbow table attacks; it does *not* need to be secret, only unique per password
- **Work factor / iteration count** is the adjustable cost parameter — bcrypt and Argon2 allow tuning as hardware improves
- **HKDF** (HMAC-based KDF) is used for deriving session keys from shared secrets (e.g., in TLS 1.3), not for passwords
- Key stretching is the practice of making a weak key (like a password) computationally expensive to attack — PBKDF2, bcrypt, scrypt, and Argon2 all implement this

## Related concepts
[[Password Hashing]] [[Salting]] [[Rainbow Table Attack]] [[PBKDF2]] [[TLS Handshake]]