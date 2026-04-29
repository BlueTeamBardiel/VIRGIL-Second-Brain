# Salted hash

## What it is
Imagine two users both choose the password "sunshine123" — without a salt, their stored hashes are identical, handing an attacker a two-for-one deal. A **salted hash** fixes this by appending (or prepending) a unique random value — the *salt* — to each password *before* hashing, so even identical passwords produce completely different hash outputs. The salt is stored in plaintext alongside the hash; its purpose is unpredictability, not secrecy.

## Why it matters
In the 2012 LinkedIn breach, ~6.5 million password hashes were dumped — they were unsalted SHA-1, which meant attackers could run a single precomputed rainbow table against the entire database and crack millions of passwords in hours. Had each hash been salted, those precomputed tables would have been worthless, forcing per-password brute-force attacks that scale very poorly against a large dataset.

## Key facts
- A salt must be **cryptographically random** and **unique per user** — reusing salts defeats the purpose
- Salts defeat **rainbow table attacks** and **precomputation attacks**, but do *not* make a weak password strong
- Common salted hashing algorithms include **bcrypt**, **scrypt**, and **Argon2** — these incorporate salting and intentional computational cost by design
- The salt does **not need to be secret** — its value comes from uniqueness, not confidentiality
- **NIST SP 800-63B** recommends using a memorized secret with at least a 32-bit random salt before hashing with an approved slow/adaptive function

## Related concepts
[[Password hashing]] [[Rainbow table attack]] [[bcrypt]] [[Key stretching]] [[Credential stuffing]]