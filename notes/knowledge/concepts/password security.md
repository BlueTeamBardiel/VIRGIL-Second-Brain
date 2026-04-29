# password security

## What it is
Think of a password like a physical key: a simple, short key is easy to duplicate, while a long, uniquely cut key resists copying. A password is a secret string of characters used to authenticate a user's identity to a system, and its security depends on length, complexity, unpredictability, and proper storage practices on both ends.

## Why it matters
In the 2012 LinkedIn breach, over 6 million passwords stored as unsalted SHA-1 hashes were cracked within days using precomputed rainbow tables. Had LinkedIn used bcrypt with per-user salts, the same attack would have taken years per password — demonstrating that password security is a shared responsibility between user choice and server-side implementation.

## Key facts
- **Length beats complexity**: A 16-character passphrase like `correct-horse-battery-staple` is stronger than `P@55w0rd` — entropy scales exponentially with length
- **Salting** adds a unique random value per password before hashing, defeating rainbow table and precomputed dictionary attacks entirely
- **Credential stuffing** exploits password reuse across sites — attackers automate logins using dumps from prior breaches (e.g., HaveIBeenPwned tracks billions of compromised credentials)
- **NIST SP 800-63B** (2017) recommends against mandatory complexity rules and periodic rotation unless compromise is suspected — policies should check passwords against known breach lists instead
- **Multi-factor authentication (MFA)** compensates for weak or compromised passwords; even a known password becomes useless without the second factor

## Related concepts
[[hashing algorithms]] [[multi-factor authentication]] [[credential stuffing]] [[brute force attacks]] [[rainbow tables]]