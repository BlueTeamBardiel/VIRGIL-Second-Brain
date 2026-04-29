# CSPRNG

## What it is
Like a magician pulling endless unique scarves from a hat — where no audience member can predict the next color even after watching a thousand pulls — a Cryptographically Secure Pseudo-Random Number Generator produces unpredictable output that resists reverse-engineering. Precisely: a CSPRNG is an algorithm that generates statistically random numbers satisfying two critical properties: it passes all polynomial-time statistical tests, and it is computationally infeasible to predict future outputs even if an attacker knows previous outputs.

## Why it matters
In 2012, researchers discovered that millions of RSA public keys shared prime factors — meaning the keys could be trivially broken. The root cause: embedded devices (routers, smart cards) were generating keys using weak PRNGs seeded with insufficient entropy at boot time, producing nearly identical "random" numbers across devices. An attacker who factored one key effectively compromised thousands.

## Key facts
- **Two core security properties:** Next-bit unpredictability (no algorithm can predict the next bit with >50% accuracy) and state compromise resistance (learning current state doesn't reveal past outputs — backward secrecy)
- **Common implementations:** `/dev/urandom` on Linux (acceptable for most crypto use), `CryptGenRandom` on Windows, and library functions like `secrets` in Python — **never** use `rand()` or `Math.random()` for cryptographic purposes
- **Entropy sources:** CSPRNGs are seeded from physical entropy — keyboard timings, mouse movements, hardware interrupts, or dedicated hardware RNG chips (HRNG/TRNG)
- **Dual EC DRBG backdoor:** A NIST-standardized CSPRNG later revealed to contain an NSA-planted backdoor via a kleptographic trapdoor in its elliptic curve constants — a landmark supply-chain trust failure
- **Relevant standards:** NIST SP 800-90A defines approved DRBG (Deterministic Random Bit Generator) constructions used in FIPS-validated systems

## Related concepts
[[Entropy]] [[Key Generation]] [[Symmetric Encryption]] [[Public Key Infrastructure]] [[TRNG]]