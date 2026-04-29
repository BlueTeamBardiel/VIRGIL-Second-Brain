# ECDHE

## What it is
Imagine two strangers mixing secret paint colors in public — each adds their private color to a shared base, exchanges the result, then adds their private color again, ending up with an identical final color that no eavesdropper can reconstruct. ECDHE (Elliptic Curve Diffie-Hellman Ephemeral) is a key exchange protocol that uses the mathematics of elliptic curves to let two parties derive a shared secret over an untrusted channel. The "ephemeral" part means a brand-new key pair is generated for every session, ensuring no long-term secret is ever exposed.

## Why it matters
In 2015, the FREAK attack forced servers to downgrade to weak RSA key exchange, allowing session decryption. ECDHE defeats this class of attack because even if an attacker records encrypted traffic today and later compromises the server's long-term private key, they still cannot decrypt past sessions — each session's ephemeral keys were discarded immediately after use. This property is called **Perfect Forward Secrecy (PFS)**, and ECDHE is the dominant mechanism delivering it in TLS 1.3.

## Key facts
- ECDHE is mandatory in **TLS 1.3**; TLS 1.2 supports it but also allows weaker alternatives like static RSA
- Uses elliptic curve discrete logarithm problem (ECDLP) — a 256-bit ECDHE key offers roughly equivalent security to a 3072-bit RSA key
- Common curves used: **P-256 (secp256r1)**, **P-384**, and **X25519** (favored for its speed and resistance to side-channel attacks)
- "Ephemeral" means key pairs are never reused — this is what enables Perfect Forward Secrecy
- ECDHE replaces both plain ECDH (static, no PFS) and the older DHE (slower, larger key sizes needed for equivalent security)

## Related concepts
[[Perfect Forward Secrecy]] [[TLS Handshake]] [[Elliptic Curve Cryptography]] [[Diffie-Hellman Key Exchange]] [[Public Key Infrastructure]]