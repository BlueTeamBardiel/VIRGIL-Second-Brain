# hash functions

## What it is
Like a meat grinder that turns any steak into ground beef — you can never reconstruct the original cut from the output, and the same cut always produces the same grind. A hash function is a one-way mathematical algorithm that takes arbitrary-length input and produces a fixed-length output (called a digest or hash), where any change to the input produces a completely different output (the avalanche effect).

## Why it matters
In 2012, LinkedIn suffered a breach exposing 6.5 million unsalted SHA-1 password hashes. Because SHA-1 is fast and the hashes were unsalted, attackers cracked the majority using precomputed rainbow tables within days — exposing passwords for millions of accounts. This failure demonstrated that fast, unsalted hashes are catastrophically unsuitable for password storage.

## Key facts
- **Collision resistance**: A secure hash function makes it computationally infeasible to find two different inputs that produce the same digest
- **MD5 (128-bit) and SHA-1 (160-bit) are both considered broken** — collision attacks have been demonstrated; neither should be used for integrity or signatures
- **SHA-256 and SHA-3** are current standards recommended by NIST for cryptographic use
- **Salting** adds a random value to input before hashing, defeating precomputed rainbow table attacks — critical for password storage
- **HMACs (Hash-based Message Authentication Codes)** combine a hash with a secret key to provide both integrity *and* authentication, preventing an attacker from forging a valid hash

## Related concepts
[[rainbow tables]] [[digital signatures]] [[HMAC]] [[password salting]] [[SHA-256]]