# ECDH

## What it is
Imagine two strangers mixing paint in public: each adds their secret color to a shared base, exchanges the result, then adds their secret again — producing an identical private shade no eavesdropper can replicate. Elliptic Curve Diffie-Hellman (ECDH) works exactly this way: two parties each generate an ephemeral key pair, exchange public keys, and independently compute the same shared secret using elliptic curve mathematics. Neither the shared secret nor either private key is ever transmitted.

## Why it matters
TLS 1.3 mandates ephemeral ECDH (ECDHE) for every session, eliminating static key exchange. This directly defeats retrospective decryption attacks: an adversary who records encrypted traffic today and later steals the server's private key cannot decrypt old sessions, because each session used a throwaway key pair that no longer exists. This property is called **Perfect Forward Secrecy (PFS)**.

## Key facts
- **ECDHE** (ephemeral variant) generates fresh key pairs per session, providing PFS; static ECDH does not.
- Uses smaller keys for equivalent security: a **256-bit** ECC key ≈ a **3072-bit** RSA key, reducing computational overhead significantly.
- Common named curves: **P-256 (secp256r1)**, **P-384**, and **X25519** — TLS 1.3 favors X25519 for speed and resistance to side-channel attacks.
- ECDH provides **key agreement**, not authentication — it must be paired with a digital signature (e.g., ECDSA) to prevent man-in-the-middle attacks.
- Vulnerable to quantum attacks; **NIST post-quantum standards** (e.g., CRYSTALS-Kyber) are being adopted to replace it.

## Related concepts
[[Elliptic Curve Cryptography]] [[Diffie-Hellman Key Exchange]] [[Perfect Forward Secrecy]] [[TLS Handshake]] [[ECDSA]]