# Grover's Algorithm

## What it is
Imagine searching for one specific grain of sand on a beach — classically you'd check each grain one by one, but Grover's algorithm is like having a magic divining rod that narrows the whole beach to a handful of candidates in roughly √N steps. Formally, it is a quantum algorithm that searches an unsorted database of N entries in O(√N) time, providing a quadratic speedup over classical brute-force search.

## Why it matters
Grover's algorithm directly threatens symmetric encryption and hashing by effectively halving the bit-strength of any key or digest. A 128-bit AES key, which classically requires 2¹²⁸ operations to brute-force, would fall to roughly 2⁶⁴ operations on a sufficiently powerful quantum computer — dropping it from "computationally infeasible" to "concerning." This is why NIST recommends migrating to 256-bit symmetric keys as a post-quantum countermeasure.

## Key facts
- Grover's algorithm provides a **quadratic speedup**, not exponential — it halves effective key length in bits, so 128-bit → 64-bit equivalent security
- **Symmetric encryption and hashing are threatened**, but not broken outright; doubling key size (AES-256) restores security margins
- Unlike Shor's algorithm, which **destroys** RSA/ECC, Grover's algorithm merely *weakens* symmetric schemes
- SHA-256 hash security drops to roughly 128-bit security under Grover; SHA-3-256 is similarly affected
- **NIST PQC guidance** recommends AES-256 and SHA-384/SHA-512 as quantum-resistant choices for symmetric primitives
- Grover's algorithm requires a **fault-tolerant quantum computer** with millions of logical qubits — not yet practical, but the threat is on the planning horizon

## Related concepts
[[Shor's Algorithm]] [[Post-Quantum Cryptography]] [[AES Encryption]] [[Symmetric Key Length]] [[Hash Functions]]