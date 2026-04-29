# Brute Force Attacks

## What it is
Imagine trying every key on a massive keyring until one unlocks the door — no skill, just exhaustive persistence. A brute force attack is a cryptanalytic method where an attacker systematically tries every possible combination of characters (passwords, keys, PINs) until the correct one is found. It trades cleverness for computation, guaranteeing eventual success given enough time and resources.

## Why it matters
In 2012, after LinkedIn's password database was breached, attackers ran brute force and dictionary attacks against the stolen SHA-1 hashes — cracking over 6 million passwords within days because the hashes were unsalted. This incident illustrates why both hashing strength *and* account lockout policies matter: stolen credentials are only as safe as the algorithm protecting them.

## Key facts
- **Online brute force** targets live systems (login forms) and is slowed by lockout policies; **offline brute force** targets stolen hash files and is limited only by hardware speed
- Modern GPUs can attempt **billions of MD5 hashes per second**, making weak or unsalted hashes trivially crackable offline
- **Dictionary attacks** are a subcategory — they use wordlists of probable passwords rather than exhaustive character combinations, dramatically reducing search space
- **Account lockout** (e.g., 5 failed attempts → 30-minute lock) is the primary control against *online* brute force; it does nothing against *offline* attacks
- NIST SP 800-63B recommends passwords of at least **8 characters** partly because length exponentially increases brute force time (each added character multiplies the search space by the character set size)

## Related concepts
[[Password Spraying]] [[Rainbow Table Attacks]] [[Multi-Factor Authentication]] [[Dictionary Attacks]] [[Account Lockout Policies]]