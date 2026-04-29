# libsodium

## What it is
Think of libsodium as a pre-assembled IKEA kitchen — all the dangerous power tools (cryptographic primitives) come pre-configured so you can't accidentally install the stove upside down. Precisely, libsodium is a modern, open-source cryptographic library that wraps complex primitives (encryption, hashing, key exchange, signatures) into high-level, hard-to-misuse APIs. It defaults to safe algorithms and parameter choices, dramatically reducing developer cryptographic error.

## Why it matters
A developer building a messaging app rolls their own AES-CBC implementation, forgets to randomize IVs, and every message becomes decryptable via a padding oracle attack. Had they used libsodium's `crypto_secretbox()`, the library would have automatically used XSalsa20-Poly1305 with a secure nonce, making that entire class of mistakes structurally impossible. This is the "pit of success" design philosophy — libsodium makes the secure path the easy path.

## Key facts
- **Default algorithm stack**: Uses XSalsa20-Poly1305 (symmetric), X25519 (key exchange), Ed25519 (signatures), and BLAKE2b (hashing) — all modern, audited primitives
- **Authenticated encryption by default**: `crypto_secretbox` and `crypto_box` always combine encryption + MAC, preventing ciphertext tampering without separate HMAC steps
- **Nonce management**: Provides `randombytes_buf()` for cryptographically secure random generation, eliminating weak-IV vulnerabilities
- **Constant-time operations**: Critical comparisons (e.g., MAC verification) run in constant time, preventing timing side-channel attacks
- **Cross-platform**: Available in C, Python (PyNaCl), JavaScript (libsodium.js), Go, and others — same security guarantees across languages
- **Derives from NaCl**: libsodium is a portable fork of Daniel Bernstein's NaCl library, adding packaging, documentation, and broader platform support

## Related concepts
[[Authenticated Encryption]] [[Elliptic Curve Cryptography]] [[Side-Channel Attacks]] [[HMAC]] [[NaCl Cryptography]]