# CWE-330 Use of Insufficiently Random Values

## What it is
Imagine a lock manufacturer who, instead of cutting truly unique keys, only shuffles through 50 templates — eventually, someone's key opens your door. CWE-330 occurs when software generates values meant to be unpredictable (session tokens, nonces, cryptographic keys) using sources that lack true entropy, making them guessable or reproducible. The core failure is treating "looks random" as equivalent to "is random."

## Why it matters
In 2008, Debian's OpenSSL package was patched in a way that accidentally seeded the random number generator with only the process ID — leaving roughly 32,768 possible SSH and TLS keys in existence. Attackers could precompute the entire keyspace and authenticate to any affected system without credentials. This single entropy failure compromised every SSH key and TLS certificate generated on Debian-based systems for two years.

## Key facts
- **PRNG vs. CSPRNG distinction is critical**: Standard PRNGs (like `rand()` in C or `Math.random()` in JavaScript) are not cryptographically safe; use OS-level CSPRNGs (`/dev/urandom`, `CryptGenRandom`, `java.security.SecureRandom`)
- **Seed predictability is the root cause**: If an attacker knows or can guess the seed (e.g., current timestamp in milliseconds), they can reproduce the entire output sequence
- **Session token attacks**: Predictable session IDs enable session hijacking without credential theft — a direct path to account takeover
- **Test for this**: Low-entropy tokens often fail statistical randomness tests (NIST SP 800-22) or show sequential/time-correlated patterns
- **Common in embedded/IoT systems**: Resource-constrained devices frequently default to weak entropy sources, making default credential and key attacks trivial

## Related concepts
[[Cryptographically Secure Pseudo-Random Number Generator (CSPRNG)]] [[CWE-338 Use of Cryptographically Weak PRNG]] [[Session Hijacking]] [[Entropy]] [[CWE-335 Incorrect Usage of Seeds in PRNG]]