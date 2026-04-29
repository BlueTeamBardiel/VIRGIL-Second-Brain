# CWE-331 - Insufficient Entropy

## What it is
Imagine a combination lock where the manufacturer only uses three digits instead of four — the keyspace shrinks from 10,000 to 1,000 possibilities, making brute force trivial. Insufficient Entropy occurs when a system generates cryptographic keys, tokens, or random values from a pool of possibilities too small to resist guessing or brute-force attacks. The randomness isn't random enough, making "unpredictable" outputs mathematically predictable.

## Why it matters
In 2012, researchers discovered that millions of RSA public keys on the internet shared prime factors — meaning the private keys could be computed in seconds. The root cause was embedded devices generating keys during boot when entropy sources (timing, hardware noise, user input) were nearly zero, so multiple devices independently produced the same "random" primes. An attacker who factored shared primes could decrypt intercepted traffic silently.

## Key facts
- Entropy is measured in bits; a 128-bit key requires ~2¹²⁸ guesses to brute-force — cutting entropy to 32 bits drops that to ~4 billion, crackable in seconds
- Common culprits: seeding PRNGs with timestamps, PIDs, or predictable system state instead of hardware-based randomness (HWRNG)
- Linux `/dev/urandom` is acceptable for most crypto use; `/dev/random` blocks until sufficient entropy is pooled — using `Math.random()` in JavaScript for security tokens is a classic CWE-331 violation
- Session tokens with low entropy are vulnerable to **session prediction attacks**, where attackers enumerate valid token values
- NIST SP 800-90A/B/C standards define approved entropy sources and Deterministic Random Bit Generators (DRBGs) for compliant implementations

## Related concepts
[[CWE-330 Use of Insufficiently Random Values]] [[Pseudorandom Number Generator (PRNG)]] [[Session Hijacking]] [[Key Management]] [[CWE-338 Use of Cryptographically Weak PRNG]]