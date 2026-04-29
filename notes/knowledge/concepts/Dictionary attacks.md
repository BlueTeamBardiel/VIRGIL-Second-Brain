# Dictionary attacks

## What it is
Imagine a locksmith who, instead of trying every possible key combination, carries a bag of the 10,000 most common house keys — statistically, one will fit most doors. A dictionary attack works the same way: an attacker tries a pre-compiled list of likely passwords (common words, phrases, and known leaked credentials) against an authentication system or captured password hash, rather than exhausting every possible character combination. It trades completeness for speed, exploiting the fact that humans choose predictable passwords.

## Why it matters
In the 2012 LinkedIn breach, 6.5 million SHA-1 unsalted password hashes were dumped publicly. Attackers ran dictionary attacks using tools like Hashcat against those hashes offline — cracking millions of passwords in hours because users chose words like "linkedin," "password123," and "sunshine." This demonstrates why **offline dictionary attacks against unsalted hashes** are catastrophic: there's no lockout mechanism and the attacker controls the pace entirely.

## Key facts
- Dictionary attacks use wordlists (e.g., RockYou.txt contains 14 million real leaked passwords) rather than brute-force character enumeration
- They are especially effective **offline** against captured hashes, where rate-limiting and account lockout policies don't apply
- **Salting** defeats precomputed dictionary attacks (rainbow tables) by forcing unique hash computation per password, even if two users share the same password
- **Hybrid dictionary attacks** append numbers or symbols to wordlist entries (e.g., "dragon" → "dragon1!"), bridging the gap between dictionary and brute-force approaches
- Countermeasures include: salted hashing (bcrypt, Argon2), account lockout policies, MFA, and monitoring for credential stuffing patterns

## Related concepts
[[Brute Force Attacks]] [[Rainbow Table Attacks]] [[Password Spraying]] [[Credential Stuffing]] [[Salting]]