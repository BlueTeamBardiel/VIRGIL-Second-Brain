# Salt

## What it is
Like adding a unique fingerprint to each snowflake before freezing it, a salt is a random value appended (or prepended) to a password before hashing, ensuring identical passwords produce completely different hash outputs. Specifically, a salt is a cryptographically random string—typically 16+ bytes—stored alongside the hash in the database and used to defeat precomputed lookup attacks.

## Why it matters
In 2012, LinkedIn suffered a breach exposing 117 million password hashes stored as unsalted SHA-1. Attackers cracked over 90% of them within days using prebuilt rainbow tables—massive precomputed hash-to-password dictionaries. Had LinkedIn salted each hash, those rainbow tables would have been completely useless, forcing attackers to crack each hash individually from scratch.

## Key facts
- Salts are **not secret**—they are stored in plaintext alongside the hash; their power comes from uniqueness, not secrecy
- A salt defeats **rainbow table attacks** and **precomputation attacks** by making every hash output unique, even for identical passwords
- Salts do **not** protect weak passwords from targeted brute-force attacks on a single account—that's the job of slow hashing algorithms like bcrypt or Argon2
- NIST SP 800-132 recommends salts be at least **32 bits** (128 bits preferred) and generated using a cryptographically secure random number generator
- A **pepper** is a related concept—a secret value added to the hash stored separately from the database (unlike a salt), providing an additional layer if the DB is compromised

## Related concepts
[[Password Hashing]] [[Rainbow Table Attack]] [[Bcrypt]] [[Key Stretching]] [[Pepper]]