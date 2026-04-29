# Rainbow Table

## What it is
Imagine a phone book that works backwards — instead of looking up a name to find a number, you look up a number to find the name. A rainbow table is a precomputed lookup table mapping hash values back to their original plaintext passwords, allowing attackers to reverse hashes without brute-forcing them in real time. The "rainbow" refers to the chain-reduction technique that compresses the table to balance storage size against lookup speed.

## Why it matters
In 2012, the LinkedIn breach exposed 6.5 million unsalted SHA-1 password hashes. Because the hashes lacked salts, attackers could run the stolen hashes against precomputed rainbow tables and crack a significant portion of them within hours — something that would take years with brute force. This attack demonstrated why salting is non-negotiable in any modern authentication system.

## Key facts
- Rainbow tables are a **time-memory trade-off** attack: you spend time precomputing the table once, then trade that stored computation for near-instant lookups during an attack.
- **Salting defeats rainbow tables** — a unique random salt appended to each password before hashing forces attackers to regenerate a unique table per user, making precomputation impractical.
- Modern password hashing algorithms like **bcrypt, scrypt, and Argon2** are specifically designed to be computationally expensive and salt by default, making rainbow tables ineffective.
- Rainbow tables are only effective against **unsalted or weakly salted** hashes using fast algorithms like MD5 or SHA-1.
- Tools like **Ophcrack** (for Windows NTLM hashes) ship with prebuilt rainbow tables, making this attack accessible to low-skilled adversaries.

## Related concepts
[[Password Hashing]] [[Salting]] [[Brute Force Attack]] [[Credential Dumping]] [[Pass-the-Hash]]