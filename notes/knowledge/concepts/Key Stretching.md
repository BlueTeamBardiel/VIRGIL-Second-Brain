# Key Stretching

## What it is
Imagine a thief trying every key on a ring to open a lock — key stretching is like replacing that simple lock with one that takes 10 seconds to open per attempt, making the thief's job nearly impossible. Precisely, key stretching is a technique that applies a password or key through many rounds of hashing (or a deliberately slow algorithm) to make brute-force and dictionary attacks computationally expensive. It transforms a weak, human-memorable password into a cryptographically stronger key by consuming significant CPU/memory resources per attempt.

## Why it matters
In the 2012 LinkedIn breach, 6.5 million passwords hashed with unsalted SHA-1 were cracked within days because SHA-1 is blazingly fast — GPUs can compute billions of SHA-1 hashes per second. Had LinkedIn used bcrypt with a cost factor of 12, each password attempt would take ~300ms, reducing an attacker's throughput from billions per second to a few per second, rendering mass cracking practically infeasible.

## Key facts
- **bcrypt**, **scrypt**, and **Argon2** are purpose-built key stretching algorithms; PBKDF2 (Password-Based Key Derivation Function 2) is the NIST/FIPS-approved option
- PBKDF2 applies an HMAC function iteratively — commonly **10,000+ iterations** minimum, with modern recommendations exceeding 600,000 for SHA-256
- **Cost factors** (bcrypt) or **iteration counts** (PBKDF2) are tunable — you increase them as hardware gets faster to maintain security
- Argon2 (winner of the 2015 Password Hashing Competition) adds **memory-hardness**, defeating GPU/ASIC attacks that have abundant parallelism but limited memory
- Key stretching is distinct from salting but is almost always used **together** with salting to prevent rainbow table attacks

## Related concepts
[[Password Hashing]] [[Salting]] [[PBKDF2]] [[Bcrypt]] [[Dictionary Attack]]