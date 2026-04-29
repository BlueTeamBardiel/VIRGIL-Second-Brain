# Hash

## What it is
Like a meat grinder that turns a steak into ground beef — you can't reverse the process, and the same cut always produces the same output. A hash is a fixed-length string produced by a one-way mathematical function (hash algorithm) that maps arbitrary-length input data to a deterministic digest, making the original data computationally infeasible to recover.

## Why it matters
During the 2012 LinkedIn breach, attackers stole 6.5 million password hashes stored using unsalted SHA-1. Because identical passwords produced identical hashes, attackers used precomputed rainbow tables to crack millions of credentials in hours. Had LinkedIn used bcrypt with unique salts, the attack would have been computationally prohibitive — demonstrating that *how* you hash matters as much as *whether* you hash.

## Key facts
- **Common algorithms**: MD5 (128-bit, broken for security use), SHA-1 (160-bit, deprecated), SHA-256/SHA-3 (current standards), bcrypt/Argon2 (password-specific, intentionally slow)
- **Collision resistance**: A secure hash must make it infeasible for two different inputs to produce the same digest; MD5 has known practical collisions
- **Salting** adds a unique random value to each input before hashing, defeating rainbow table and precomputed lookup attacks
- **Integrity verification**: File hashes (checksums) confirm that a downloaded file hasn't been tampered with — if one bit changes, the hash changes completely (avalanche effect)
- **HMAC** (Hash-based Message Authentication Code) combines a hash with a secret key to provide both integrity *and* authentication, unlike a bare hash

## Related concepts
[[Salting]] [[Rainbow Table]] [[Digital Signature]] [[Integrity]] [[HMAC]]