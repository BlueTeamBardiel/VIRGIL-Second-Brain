# salting

## What it is
Like adding a unique fingerprint to every loaf of bread before baking so two identical recipes produce completely different results, a salt is a random value appended (or prepended) to a password before hashing. This ensures that two users with the same password produce entirely different hash outputs, defeating precomputed lookup tables.

## Why it matters
In the 2012 LinkedIn breach, over 6.5 million unsalted SHA-1 password hashes were dumped publicly. Attackers cracked millions within hours using prebuilt rainbow tables — a catastrophic failure that salting would have neutralized entirely, since each unique salt renders precomputed tables useless.

## Key facts
- A salt does **not** need to be secret — it is typically stored alongside the hash in the database; its value comes from uniqueness, not secrecy
- Salts defeat **rainbow table attacks** and **precomputation attacks** but do not prevent brute-force attacks against a single hash — that's where work factors (bcrypt, scrypt, Argon2) come in
- A salt should be **cryptographically random** and **at least 16 bytes** long to ensure statistical uniqueness across users
- **bcrypt** automatically generates and stores a per-password salt, making it a preferred password hashing algorithm for Security+/CySA+ scenarios
- Salting is distinct from **peppering** — a pepper is a secret value added to all passwords and stored separately from the database (in application config), adding a second layer of protection

## Related concepts
[[hashing]] [[rainbow tables]] [[password spraying]] [[key stretching]] [[bcrypt]]