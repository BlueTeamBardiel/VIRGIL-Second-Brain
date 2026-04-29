# Cryptographic Hash

## What it is
Like a fingerprint machine that can scan any document — a novel or a napkin — and always produce the same fixed-length smudge unique to that exact input, with no way to reconstruct the original from the smudge alone. Precisely: a cryptographic hash function takes arbitrary-length input and produces a fixed-size digest (e.g., 256 bits) that is deterministic, one-way, and collision-resistant. Even flipping a single bit in the input produces a completely different output — this is called the avalanche effect.

## Why it matters
In the 2012 LinkedIn breach, attackers stole 6.5 million password hashes computed with unsalted SHA-1. Because identical passwords produced identical hashes, attackers used precomputed rainbow tables to crack millions of passwords in hours — a direct consequence of missing salts and a weak algorithm. This attack illustrates why modern systems use bcrypt or Argon2 with per-user salts instead of fast, unsalted hashes.

## Key facts
- **Common algorithms**: MD5 (broken, 128-bit), SHA-1 (deprecated, 160-bit), SHA-256/SHA-3 (current standards)
- **Three core properties**: Pre-image resistance (can't reverse the hash), second pre-image resistance (can't find a different input with the same hash), collision resistance (can't find any two inputs producing the same hash)
- **MD5 and SHA-1 are collision-broken** — both are disqualified for certificate signing and integrity verification; still appear in legacy systems
- **Hashing ≠ Encryption** — hashes are one-way with no key; encryption is two-way with a key; confusing them is a classic exam trap
- **HMAC** adds a secret key to a hash function to provide both integrity and authenticity, used in TLS and API authentication

## Related concepts
[[Rainbow Table Attack]] [[Digital Signature]] [[HMAC]] [[Password Salting]] [[Collision Attack]]