# AEAD

## What it is
Think of AEAD (Authenticated Encryption with Associated Data) as a security envelope that both seals your message *and* signs it in one operation—unlike sending a sealed letter separately from a signed certificate. Formally, AEAD is a symmetric encryption mode that simultaneously provides confidentiality (keeps data secret), authenticity (proves it wasn't tampered with), and can optionally authenticate additional unencrypted metadata without encrypting it.

## Why it matters
Modern protocols like TLS 1.3 and WireGuard exclusively use AEAD ciphers because they prevent subtle attacks. Without authentication, an attacker could flip bits in ciphertext and corrupt the plaintext without detection. AEAD catches this in one cryptographic operation, eliminating dangerous gaps between encryption and MAC verification that existed in older "encrypt-then-MAC" constructions.

## Key facts
- Common AEAD algorithms: AES-GCM, ChaCha20-Poly1305, AES-CCM
- The "associated data" (AD) is authenticated but not encrypted—useful for headers/metadata
- GCM uses Galois field multiplication for fast authentication; Poly1305 uses modular arithmetic
- Nonce reuse with the same key completely breaks AEAD security (all ciphertext recoverable)
- AEAD requires longer keys than stream ciphers alone (~256 bits for AES-GCM)

## Related concepts
[[Authenticated Encryption]] [[AES-GCM]] [[ChaCha20-Poly1305]] [[Nonce]] [[Galois/Counter Mode]]