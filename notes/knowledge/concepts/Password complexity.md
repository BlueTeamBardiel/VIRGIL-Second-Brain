# Password complexity

## What it is
Think of a password as a combination lock: a 3-digit lock has 1,000 possible combos, but a 10-digit lock with letters and symbols has trillions — the attacker must work exponentially harder. Password complexity is the set of rules governing a password's character diversity (uppercase, lowercase, digits, symbols) and length to maximize the size of the search space an attacker must exhaust.

## Why it matters
In a brute-force or dictionary attack, tools like Hashcat can crack an 8-character lowercase-only password hash in minutes using GPU acceleration. Adding just one symbol and enforcing mixed case pushes that same crack time from minutes to years on the same hardware — complexity directly translates to attacker cost.

## Key facts
- NIST SP 800-63B (2017) *reversed* traditional complexity advice: it now recommends **length over character-set rules**, favoring passphrases of 15+ characters rather than forcing `P@$$w0rd`-style substitutions.
- The keyspace formula is **C^L**, where C = number of possible characters and L = length — doubling length is far more powerful than adding one character class.
- Complexity rules alone don't prevent credential stuffing; a complex password reused across sites is still a single point of failure.
- Common complexity requirements for compliance frameworks (PCI-DSS, HIPAA): minimum 8 characters, at least 3 of 4 character classes (upper, lower, digit, special).
- Password complexity requirements should be paired with **lockout policies** and **MFA** — complexity without these still leaves accounts vulnerable to online attacks.

## Related concepts
[[Brute-force attack]] [[Dictionary attack]] [[Multi-factor authentication]] [[Password hashing]] [[NIST password guidelines]]