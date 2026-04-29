# key derivation function

## What it is
Like a master locksmith who takes one skeleton key and stamps out dozens of uniquely-cut keys for different doors, a KDF takes a single secret (like a password or master secret) and deterministically derives multiple cryptographically strong keys from it. Precisely: a Key Derivation Function is a cryptographic algorithm that stretches, strengthens, or diversifies key material into one or more keys suitable for specific cryptographic operations. Common examples include PBKDF2, bcrypt, scrypt, and HKDF.

## Why it matters
When the LinkedIn database was breached in 2012, over 6 million passwords were stored as raw SHA-1 hashes — cracked within days using GPU-accelerated rainbow tables. Had LinkedIn used a proper KDF like bcrypt with per-user salts and a high work factor, the computational cost per guess would have made bulk cracking economically infeasible, protecting users even after exfiltration.

## Key facts
- **Salting** prevents rainbow table attacks by ensuring two identical passwords produce different digests; KDFs like bcrypt bake salting into the algorithm itself
- **Work factor (iteration count)** is intentionally tunable — PBKDF2 with 600,000 iterations (NIST's 2023 recommendation) forces attackers to repeat that cost per guess
- **HKDF** (Extract-then-Expand) is used in TLS 1.3 to derive separate encryption and MAC keys from the shared session secret — preventing key reuse across operations
- **scrypt and Argon2** add **memory-hardness**, meaning attacks require large amounts of RAM, defeating GPU/ASIC cracking rigs that excel at compute-only workloads
- KDFs differ from plain hashes: MD5/SHA are designed to be *fast*; KDFs are deliberately *slow* and resource-intensive by design

## Related concepts
[[password hashing]] [[salting]] [[rainbow table attack]] [[bcrypt]] [[TLS handshake]]