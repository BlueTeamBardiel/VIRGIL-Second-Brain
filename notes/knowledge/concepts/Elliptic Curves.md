# Elliptic Curves

## What it is
Imagine trying to find two numbers that multiply to give a specific point on a curved road — easy to verify, nearly impossible to reverse-engineer. An elliptic curve is a mathematical structure defined by the equation y² = x³ + ax + b, where cryptographic operations exploit the "discrete logarithm problem" on points along that curve to make private keys computationally infeasible to extract from public keys.

## Why it matters
When a TLS 1.3 handshake establishes your HTTPS session, it almost certainly uses ECDHE (Elliptic Curve Diffie-Hellman Ephemeral) key exchange over curves like P-256 or Curve25519. An attacker who compromises the server's long-term key still cannot decrypt past sessions because ephemeral EC key pairs are discarded after each handshake — this is forward secrecy in action, and it's why stealing a private key from a server doesn't let you decrypt captured traffic.

## Key facts
- ECC achieves equivalent security to RSA with dramatically smaller keys: a **256-bit ECC key ≈ 3072-bit RSA key**, meaning faster operations and less bandwidth
- The **NSA NIST P-curves** (P-256, P-384, P-521) are approved for Suite B cryptography; **Curve25519** is preferred in modern protocols for its resistance to implementation errors
- ECC is used in **ECDSA** (signing) and **ECDH/ECDHE** (key exchange) — two distinct operations, both used in TLS
- The **Sony PlayStation 3 hack (2010)** exploited a broken ECDSA implementation where Sony reused a random nonce *k*, allowing attackers to extract the private signing key entirely from two signatures
- Quantum computers running **Shor's algorithm** can break ECC, driving the shift toward NIST post-quantum standards like CRYSTALS-Kyber

## Related concepts
[[Public Key Infrastructure]] [[Diffie-Hellman Key Exchange]] [[Digital Signatures]] [[TLS Handshake]] [[Post-Quantum Cryptography]]