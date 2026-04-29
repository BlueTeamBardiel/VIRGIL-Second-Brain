# PBKDF2

## What it is
Like a combination lock that requires 100,000 spins before it opens — even if you know the mechanism — PBKDF2 (Password-Based Key Derivation Function 2) deliberately slows down password hashing by applying a pseudorandom function (like HMAC-SHA256) thousands of times with a salt. The result is a derived key that is computationally expensive to brute-force at scale.

## Why it matters
In 2012, LinkedIn suffered a breach exposing 6.5 million unsalted SHA-1 password hashes, which were cracked within hours using precomputed rainbow tables. Had LinkedIn used PBKDF2 with a unique salt and high iteration count, attackers would have needed to compute each guess individually — turning hours of cracking into years. This is exactly the scenario PBKDF2 was designed to defeat.

## Key facts
- **Defined in RFC 2898**; part of the PKCS #5 standard and widely used in WPA2/WPA3 Wi-Fi authentication and LUKS disk encryption
- Accepts five inputs: **password, salt, iteration count (c), desired key length, and PRF** (pseudorandom function, typically HMAC-SHA1 or HMAC-SHA256)
- The **iteration count is tunable** — NIST SP 800-132 recommends a minimum of 10,000 iterations; modern guidance pushes 600,000+ for HMAC-SHA256
- **Salt (minimum 128 bits per NIST)** prevents rainbow table attacks and ensures two identical passwords produce different hashes
- Compared to bcrypt/scrypt/Argon2, PBKDF2 is **CPU-bound but not memory-hard**, making it more vulnerable to GPU-accelerated cracking at high scale

## Related concepts
[[Salting]] [[bcrypt]] [[Key Stretching]] [[HMAC]] [[Rainbow Tables]]