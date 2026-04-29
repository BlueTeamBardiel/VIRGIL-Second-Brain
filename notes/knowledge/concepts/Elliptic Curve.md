# Elliptic Curve

## What it is
Imagine trying to find two secret numbers that multiply to reach a specific point on a twisted rubber sheet — easy to verify, nearly impossible to reverse. An elliptic curve is a mathematical structure defined by the equation y² = x³ + ax + b, where points on the curve form a group under a special addition operation, and the "discrete logarithm" problem on this curve is computationally brutal to solve.

## Why it matters
When your browser negotiates HTTPS using ECDHE (Elliptic Curve Diffie-Hellman Ephemeral), it's using elliptic curve math to establish a session key. An attacker capturing that traffic cannot derive the private key even with significant compute — and because the keys are short, this handshake happens faster than RSA equivalents, making ECC the backbone of modern TLS 1.3 key exchange.

## Key facts
- A 256-bit ECC key provides roughly equivalent security to a 3072-bit RSA key — same strength, fraction of the size
- ECDSA (Elliptic Curve Digital Signature Algorithm) is used to sign TLS certificates and is the signature scheme behind Bitcoin transactions
- ECDHE provides **forward secrecy** — each session uses a fresh ephemeral key pair, so compromising the server's long-term key doesn't decrypt past sessions
- NIST-approved curves include P-256, P-384, and P-521; Curve25519 (used in Signal and WireGuard) is widely trusted as a non-NIST alternative
- NSA's Suite B cryptography mandated ECC, but the shift to quantum-resistant algorithms (NIST PQC) is underway because quantum computers could break ECC via Shor's algorithm

## Related concepts
[[Diffie-Hellman Key Exchange]] [[Public Key Infrastructure]] [[Forward Secrecy]]