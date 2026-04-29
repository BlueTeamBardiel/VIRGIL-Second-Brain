# Data Hashing

## What it is
Like a fingerprint taken from a document — no matter how long the document is, the fingerprint is always the same fixed size, and you can't reconstruct the original document from the fingerprint alone. Hashing is a one-way mathematical function that takes input of any length and produces a fixed-length output (called a digest), where any change to the input — even a single bit — produces a completely different digest. Unlike encryption, hashing is not reversible by design.

## Why it matters
When attackers breach a password database, they typically steal hashed passwords rather than plaintext. If the hashing algorithm is weak (like MD5) or unsalted, attackers use precomputed rainbow tables to reverse-lookup the original password from its hash in seconds — this is exactly how the 2012 LinkedIn breach exposed 117 million passwords. Defenders counter this by using slow, salted algorithms like bcrypt or Argon2 to make bulk cracking computationally prohibitive.

## Key facts
- **MD5** produces a 128-bit digest; considered cryptographically broken due to collision vulnerabilities — do not use for security purposes
- **SHA-256** (part of SHA-2 family) produces a 256-bit digest and remains the current standard for integrity verification
- A **collision** occurs when two different inputs produce the same hash — this breaks integrity guarantees and is why MD5/SHA-1 are deprecated
- **Salting** adds a unique random value to each password before hashing, defeating precomputed rainbow table attacks
- Hashing verifies **integrity**, not confidentiality — it proves data hasn't changed, not that it's secret

## Related concepts
[[Rainbow Table Attacks]] [[Password Salting]] [[Digital Signatures]] [[Integrity Verification]] [[Bcrypt]]