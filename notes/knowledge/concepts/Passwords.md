# passwords

## What it is
Like a secret handshake between old friends — only someone who knows the exact sequence gets through the door. A password is a shared secret string of characters used to authenticate a user's identity to a system, verified by comparing input against a stored credential (ideally hashed, never plaintext).

## Why it matters
In the 2012 LinkedIn breach, 6.5 million unsalted SHA-1 password hashes were dumped publicly. Because SHA-1 is fast and the hashes lacked salts, attackers cracked millions of passwords within days using rainbow tables — exposing users across multiple sites due to password reuse. This single event illustrates why storage method matters as much as password strength.

## Key facts
- Passwords should be stored as salted hashes using slow algorithms like **bcrypt**, **scrypt**, or **Argon2** — never MD5 or unsalted SHA-1
- NIST SP 800-63B recommends **length over complexity** (minimum 8 chars, up to 64), and advises against mandatory periodic rotation without breach evidence
- **Credential stuffing** attacks automate the testing of breached username/password pairs against new targets, exploiting password reuse at scale
- A **rainbow table attack** precomputes hash-to-plaintext mappings; **salting** defeats this by making each hash unique even for identical passwords
- **Password spraying** tries one common password (e.g., "Summer2024!") across many accounts to avoid lockout thresholds — a key distinction from brute force on one account

## Related concepts
[[hashing]] [[multi-factor authentication]] [[credential stuffing]] [[salting]] [[brute force attacks]]