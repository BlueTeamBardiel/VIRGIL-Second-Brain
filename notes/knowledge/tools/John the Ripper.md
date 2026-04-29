# John the Ripper

## What it is
Like a locksmith who tries every key on a massive keyring — starting with the most common ones — John the Ripper is an open-source password cracking tool that systematically tests passwords against captured password hashes until it finds a match. It supports hundreds of hash types and can operate in dictionary, brute-force, or rule-based attack modes.

## Why it matters
During a penetration test, an attacker who compromises a Linux `/etc/shadow` file or a Windows SAM database doesn't see plaintext passwords — they see hashes. John the Ripper cracks those hashes offline, meaning no lockout policies apply, revealing reused or weak passwords that enable lateral movement or privilege escalation across the network.

## Key facts
- Originally written by Solar Designer; the "Jumbo" community-enhanced version supports GPU acceleration and far more hash formats (MD5, SHA-1, bcrypt, NTLM, etc.)
- Three primary attack modes: **Single** (uses login/GECOS info), **Wordlist/Dictionary** (tests known passwords), and **Incremental** (true brute-force)
- Operates entirely **offline** against captured hashes — authentication systems never see the attempts, bypassing account lockout controls
- The `unshadow` command merges `/etc/passwd` and `/etc/shadow` before cracking on Linux systems
- Strong countermeasures include **salted hashes**, **bcrypt/Argon2** (computationally expensive algorithms), and enforcing long, complex password policies

## Related concepts
[[Password Hashing]] [[Rainbow Tables]] [[Dictionary Attack]] [[Credential Dumping]] [[Hashcat]]