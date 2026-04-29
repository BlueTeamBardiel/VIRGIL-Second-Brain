# hashing

## What it is
Like a meat grinder that turns a steak into ground beef — you can verify the result is consistent, but you can never reconstruct the original cut. Hashing is a one-way mathematical function that takes input of any size and produces a fixed-length output (called a digest or hash value) that is deterministic and unique to that input. Unlike encryption, there is no key and no reversal — the same input always produces the same output, but the output reveals nothing about the input.

## Why it matters
When the RockYou database breach exposed 32 million passwords in 2009, many were stored as unsalted MD5 hashes. Attackers used precomputed rainbow tables to crack the majority within hours, because MD5 produces the same hash for the same password every time — and attackers had already done the work in advance. This is why modern systems use slow, salted algorithms like bcrypt: the salt forces unique hashes even for identical passwords, destroying rainbow table effectiveness.

## Key facts
- **MD5 produces a 128-bit hash; SHA-1 produces 160-bit; SHA-256 produces 256-bit** — longer digests mean more collision resistance
- **Collision resistance** means it should be computationally infeasible to find two different inputs with the same hash; MD5 and SHA-1 are both broken in this regard
- **A salt** is random data appended to a password before hashing, ensuring two identical passwords produce different digests and neutralizing precomputed attacks
- **Hashing verifies integrity** — a single changed bit in a file produces a completely different hash (avalanche effect), making tampering detectable
- **HMAC (Hash-based Message Authentication Code)** combines a hash with a secret key to provide both integrity AND authentication, used in TLS and API signing

## Related concepts
[[encryption]] [[digital signatures]] [[rainbow tables]]