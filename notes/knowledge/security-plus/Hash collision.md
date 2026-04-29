# Hash collision

## What it is
Imagine two different people arriving at a party with the same unique "costume ID" assigned by the host — the system was supposed to guarantee uniqueness, but it failed. A hash collision occurs when two distinct inputs produce the identical hash output from the same hash function, violating the core assumption that a hash uniquely fingerprints its input.

## Why it matters
In 2008, researchers exploited MD5 collisions to forge a rogue Certificate Authority certificate, allowing them to impersonate any HTTPS website with a trusted certificate. This demonstrated that collision vulnerabilities aren't theoretical — they collapse the trust model underpinning PKI and digital signatures entirely.

## Key facts
- **MD5 and SHA-1 are collision-broken**: MD5 since 2004 (Wang et al.), SHA-1 practically demonstrated in 2017 (SHAttered attack by Google/CWI). Neither should be used for integrity verification.
- **Two types matter**: A *collision attack* finds any two inputs with the same hash; a *preimage attack* finds an input matching a *specific* hash — collisions are easier to achieve.
- **Birthday paradox** explains the math: a collision in an n-bit hash requires roughly 2^(n/2) attempts, not 2^n — making 128-bit MD5 breakable with ~2^64 operations.
- **SHA-256 and SHA-3** are currently collision-resistant and acceptable for Security+ and production use.
- **Digital signatures and certificates** depend on collision resistance — a collision allows an attacker to have a CA sign a benign document whose hash also matches a malicious one.

## Related concepts
[[Cryptographic hash functions]] [[Digital signatures]] [[MD5]] [[PKI]] [[Birthday attack]]