# One-Way Function

## What it is
Like grinding coffee beans — trivially easy to go from beans to grounds, but reconstructing the original beans from powder is computationally infeasible. A one-way function is a mathematical function that is easy to compute in one direction but practically impossible to reverse without special information (a "trapdoor"). Formally, given input *x*, computing *f(x)* is efficient, but given *f(x)*, finding any valid *x* is computationally intractable.

## Why it matters
Password storage depends entirely on one-way functions. When you set a password, the system stores only its hash (e.g., SHA-256 output). If an attacker dumps the database, they get hashes — not plaintext. Without the ability to reverse the hash, they must resort to brute force or rainbow table attacks, which is why weak passwords (short, common) still fall even against one-way functions — the search space is just too small.

## Key facts
- One-way functions are the theoretical backbone of nearly all public-key cryptography, including RSA (factoring problem) and ECDH (discrete logarithm problem)
- They are *conjectured* to exist but not formally proven — P ≠ NP remains unresolved, meaning their hardness is an assumption, not a theorem
- A **trapdoor one-way function** adds secret information that makes the reverse direction easy — the foundation of asymmetric encryption
- Cryptographic hash functions (SHA-256, bcrypt) are practical one-way functions used for password hashing, digital signatures, and integrity verification
- Adding **salt** before hashing defeats precomputed rainbow table attacks by making each hash input unique, even for identical passwords

## Related concepts
[[Cryptographic Hash Function]] [[Public Key Cryptography]] [[Rainbow Table Attack]] [[Trapdoor Function]] [[Discrete Logarithm Problem]]