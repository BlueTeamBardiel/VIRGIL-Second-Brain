# Password Storage

## What it is
Think of a password like a secret recipe: you don't keep the recipe in the safe — you keep a *photograph of the finished dish* that only someone with the right recipe could reproduce. Password storage is the practice of transforming plaintext passwords into irreversible cryptographic representations (hashes) so that even if a database is stolen, the original passwords cannot be directly read.

## Why it matters
In the 2012 LinkedIn breach, 6.5 million password hashes were dumped publicly — and because LinkedIn used unsalted SHA-1, attackers cracked the majority within hours using precomputed rainbow tables. Had LinkedIn used bcrypt with unique salts, cracking would have been computationally infeasible at scale, protecting millions of users even after the breach occurred.

## Key facts
- **Never encrypt passwords — hash them.** Encryption is reversible; hashing is one-way. If you can decrypt it, so can an attacker with the key.
- **Salting** adds a unique random value to each password before hashing, defeating rainbow tables and ensuring identical passwords produce different hashes.
- **Adaptive hashing algorithms** (bcrypt, scrypt, Argon2, PBKDF2) are designed to be deliberately slow and resource-intensive, resisting brute-force attacks as hardware improves.
- **Work factors** in bcrypt/Argon2 allow organizations to increase computational cost over time — NIST SP 800-63B recommends PBKDF2 with at least 600,000 iterations using SHA-256 (2023 guidance).
- **MD5 and SHA-1 are broken for password storage** — they are too fast, enabling billions of hash attempts per second on modern GPUs.

## Related concepts
[[Hashing]] [[Rainbow Tables]] [[Salting]] [[Brute Force Attacks]] [[PBKDF2]]