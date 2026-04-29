# password

## What it is
Like a secret handshake between two members of a club, a password is a shared secret that proves you know something only an authorized user should know. Technically, it is a string of characters used as an authentication factor in the "something you know" category, verified against a stored credential (ideally a salted hash) to grant access.

## Why it matters
In the 2012 LinkedIn breach, attackers stole 117 million password hashes stored as unsalted SHA-1 — a fast, collision-prone algorithm. Because there was no salt, identical passwords produced identical hashes, allowing attackers to crack millions of credentials using precomputed rainbow tables within hours, enabling credential stuffing attacks against users who reused those passwords elsewhere.

## Key facts
- Passwords should be stored as salted hashes using slow algorithms like **bcrypt**, **scrypt**, or **Argon2** — never MD5, SHA-1, or unsalted SHA-256
- **NIST SP 800-63B** (2017) recommends prioritizing **length over complexity**, checking passwords against known breach lists, and eliminating mandatory periodic rotation
- A **brute-force attack** tries all combinations; a **dictionary attack** uses wordlists; a **credential stuffing attack** replays breached username/password pairs against other sites
- **Password spraying** tries one common password (e.g., "Spring2024!") across many accounts to avoid account lockout thresholds
- **Multi-factor authentication (MFA)** is the single most effective control against password compromise — even a weak password becomes much harder to exploit with a second factor

## Related concepts
[[authentication]] [[hashing]] [[salting]] [[credential stuffing]] [[multi-factor authentication]]