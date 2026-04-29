# Hash-identifier

## What it is
Like a sommelier who can identify a wine's grape variety just by looking at its color and glass-coating behavior, hash-identifier examines the *structure* of a hash string to determine which algorithm produced it. It is a tool (and technique) that analyzes hash length, character set, and formatting patterns to identify probable hashing algorithms — such as MD5, SHA-1, SHA-256, or bcrypt — without needing the original plaintext.

## Why it matters
During a penetration test or incident response, you may extract a credential dump containing raw hash strings with no labels. Running hash-identifier against those strings tells you whether you're dealing with unsalted MD5 (fast to crack) or bcrypt (computationally expensive), directly determining your next move — whether to fire up hashcat with wordlists or pivot to a different attack strategy entirely.

## Key facts
- **MD5** produces a 32-character hexadecimal hash; **SHA-1** produces 40 characters; **SHA-256** produces 64 characters — length alone narrows candidates significantly.
- **bcrypt** hashes are identifiable by their `$2a$`, `$2b$`, or `$2y$` prefixes, making them immediately recognizable without a tool.
- The Python tool `hash-identifier` (also available in Kali Linux) returns a ranked list of *probable* matches, not guaranteed ones — collisions in pattern space mean ambiguity is normal.
- Hash identification is a prerequisite step before password cracking; feeding a hash to the wrong mode in **hashcat** or **John the Ripper** wastes time and yields no results.
- Context clues matter: web application databases often store MD5 or SHA-1 without salting; Linux `/etc/shadow` typically stores SHA-512crypt (`$6$`) or bcrypt.

## Related concepts
[[Password Cracking]] [[Hashcat]] [[Rainbow Tables]] [[Password Hashing Algorithms]] [[Credential Dumping]]