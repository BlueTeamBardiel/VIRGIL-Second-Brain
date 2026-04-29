# Rainbow tables

## What it is
Imagine a phone book that works backwards — instead of looking up a name to find a number, you look up a hash to find the password that produced it. A rainbow table is a precomputed lookup database mapping known plaintext passwords to their hash values, built using a time-memory tradeoff technique that chains hash and reduction functions to stay compact. An attacker who steals a hash file can search the table in seconds rather than brute-forcing billions of combinations on the spot.

## Why it matters
In 2012, the LinkedIn breach exposed ~6.5 million unsalted SHA-1 password hashes. Because SHA-1 was applied without salting, attackers could immediately cross-reference those hashes against precomputed rainbow tables, cracking a significant portion of the database within hours. Had LinkedIn salted each password with a unique random value, the same rainbow tables would have been useless.

## Key facts
- Rainbow tables exploit **unsalted hashing** — a unique salt per password forces attackers to rebuild a separate table for every user, making precomputation impractical
- The "rainbow" name refers to the chain structure: alternating **hash** and **reduction** functions create distinct columns (colors) to avoid chain collisions
- **bcrypt, scrypt, and Argon2** are specifically designed to defeat rainbow tables by incorporating salting and computational cost factors
- MD5 and SHA-1 rainbow tables are widely available online and can crack common passwords in **milliseconds**
- Rainbow tables represent a **time-memory tradeoff**: you pay storage cost upfront to eliminate cracking time later

## Related concepts
[[Password Hashing]] [[Salting]] [[Brute Force Attack]] [[Credential Dumping]] [[Pass the Hash]]