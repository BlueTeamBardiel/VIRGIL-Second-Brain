# Elliptic Curve Cryptography

## What it is
Imagine trying to find where you started on a curved racetrack after taking thousands of random laps — the math of elliptic curves makes that backward journey computationally catastrophic. ECC is a form of asymmetric cryptography where key pairs are generated using the algebraic structure of elliptic curves over finite fields, deriving security from the hardness of the Elliptic Curve Discrete Logarithm Problem (ECDLP). The critical advantage: smaller keys provide equivalent security to much larger RSA keys.

## Why it matters
Mobile banking apps and TLS 1.3 handshakes overwhelmingly prefer ECC because a 256-bit ECC key matches the security of a 3072-bit RSA key — critical when securing IoT devices with limited CPU and battery. In 2013, the NSA's DUAL_EC_DRBG scandal revealed a suspected backdoor in an elliptic curve-based random number generator, demonstrating that curve selection itself can be weaponized. Choosing a compromised or weak curve (like those with a small subgroup) renders ECC catastrophically breakable.

## Key facts
- **Key size equivalency**: 256-bit ECC ≈ 3072-bit RSA ≈ 128-bit symmetric AES security
- **ECDH** (Elliptic Curve Diffie-Hellman) enables secure key exchange; **ECDSA** (Elliptic Curve Digital Signature Algorithm) handles digital signatures
- TLS 1.3 mandates forward secrecy using **ECDHE** (ephemeral variant), eliminating static key reuse
- Common secure curves include **P-256 (secp256r1)** and **Curve25519**; both are NIST/RFC-approved for modern implementations
- Quantum computers running **Shor's algorithm** can break ECC, driving migration toward **post-quantum cryptography** standards like CRYSTALS-Kyber

## Related concepts
[[Asymmetric Cryptography]] [[Diffie-Hellman Key Exchange]] [[Public Key Infrastructure]] [[Post-Quantum Cryptography]] [[Digital Signatures]]