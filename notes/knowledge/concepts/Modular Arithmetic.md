# Modular Arithmetic

## What it is
Think of a clock: after 12 comes 1, not 13 — the numbers "wrap around." Modular arithmetic works identically: `a mod n` gives the remainder after dividing `a` by `n`, so numbers cycle within a fixed range `[0, n-1]`. This "wrap-around" mathematics is the engine beneath virtually every cryptographic primitive in use today.

## Why it matters
RSA encryption relies entirely on modular exponentiation: encrypting a message `m` means computing `m^e mod n`, where `n` is the product of two large primes. An attacker who could efficiently reverse this — computing discrete logarithms or factoring `n` — would break RSA entirely. The security of the system rests on modular arithmetic being easy to compute forward but computationally hard to invert.

## Key facts
- **RSA key generation** uses modular inverse: the private key `d` satisfies `e × d ≡ 1 (mod φ(n))`, computed via the Extended Euclidean Algorithm.
- **Diffie-Hellman** key exchange security depends on the hardness of the **Discrete Logarithm Problem** — finding `x` in `g^x mod p`.
- **Fermat's Little Theorem** (`a^(p-1) ≡ 1 mod p` for prime `p`) is used to simplify modular exponentiation in cryptographic implementations.
- A **timing side-channel attack** can leak information about modular exponentiation operations if implementations aren't constant-time — relevant to hardware security modules.
- Weak moduli (small `n`, shared prime factors across RSA keys) are exploitable via GCD attacks — NIST mandates minimum 2048-bit RSA keys to resist factoring.

## Related concepts
[[RSA Encryption]] [[Diffie-Hellman Key Exchange]] [[Public Key Infrastructure]] [[Elliptic Curve Cryptography]] [[Side-Channel Attacks]]