# Generator

## What it is
Like a bicycle dynamo that spins mechanical motion into electrical current, a cryptographic generator takes a seed value and spins it into a stream of pseudo-random bits. Precisely: a Pseudo-Random Number Generator (PRNG) is a deterministic algorithm that produces sequences statistically indistinguishable from true randomness, used to generate keys, nonces, IVs, and session tokens. A Cryptographically Secure PRNG (CSPRNG) adds the requirement that output is computationally infeasible to predict even with partial knowledge of the state.

## Why it matters
In 2013, researchers discovered that Dual_EC_DRBG — a NIST-approved random number generator — contained a suspected NSA backdoor: a hardcoded elliptic curve point that allowed anyone with the corresponding secret to predict all "random" output. Any TLS session using that generator to produce keys was silently compromised, demonstrating that a weak or backdoored generator undermines every cryptographic system built on top of it.

## Key facts
- **Seed quality is everything**: a PRNG seeded with low-entropy input (e.g., timestamp only) produces predictable output — attackers who know the seed can reproduce the entire keystream
- **True RNG (TRNG)** harvests physical entropy (thermal noise, hardware interrupts); **PRNG** is algorithmic and deterministic given the same seed
- **CSPRNG requirements**: must pass the "next-bit test" (no polynomial-time algorithm predicts the next bit better than 50%) and remain secure even if partial state is compromised
- **Common CSPRNGs**: `/dev/urandom` (Linux), `CryptGenRandom` (Windows), ChaCha20-based generators (modern standard)
- **Nonce reuse kills security**: if a generator repeats a nonce in AES-GCM, an attacker can XOR two ciphertexts to recover plaintext — catastrophic failure from a single generator fault

## Related concepts
[[Entropy]] [[Key Generation]] [[Initialization Vector]] [[Symmetric Encryption]] [[Cryptographic Hash Function]]