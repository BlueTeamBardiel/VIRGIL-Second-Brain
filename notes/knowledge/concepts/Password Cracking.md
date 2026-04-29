# Password cracking

## What it is
Like a locksmith who doesn't pick locks but instead tests every key ever manufactured until one fits — password cracking is the offline process of recovering plaintext passwords from captured password hashes by systematically guessing inputs and comparing their computed hashes to the target. Unlike brute-force login attempts, cracking happens locally on captured hash data, meaning account lockouts are irrelevant.

## Why it matters
After the 2012 LinkedIn breach, attackers extracted 6.5 million unsalted SHA-1 password hashes and cracked the majority within days using precomputed rainbow tables and GPU acceleration. This exposed how weak hashing algorithms and missing salts turn a database breach into full credential compromise — fueling credential-stuffing attacks across other platforms for years afterward.

## Key facts
- **Dictionary attacks** use wordlists (e.g., RockYou.txt with 14 million real passwords); **brute-force** tries every character combination; **hybrid attacks** combine wordlists with rule-based mutations (e.g., `password` → `P@ssw0rd1`).
- **Rainbow tables** are precomputed hash-to-plaintext lookup tables; **salting** defeats them by appending a unique random value before hashing, forcing per-password computation.
- Tools like **Hashcat** and **John the Ripper** leverage GPU parallelism — modern GPUs can compute billions of MD5 hashes per second, making weak algorithms catastrophically fast to crack.
- **bcrypt, scrypt, and Argon2** are intentionally slow (work-factor algorithms) designed to limit cracking speed — the correct countermeasure for stored passwords.
- On Security+: MD5 and SHA-1 are considered **deprecated** for password storage; PBKDF2 with high iteration counts is still widely accepted as secure.

## Related concepts
[[Hashing]] [[Rainbow Tables]] [[Salting]] [[Credential Stuffing]] [[Brute Force Attack]]