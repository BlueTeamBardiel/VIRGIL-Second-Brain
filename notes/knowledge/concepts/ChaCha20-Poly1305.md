# ChaCha20-Poly1305

## What it is
Imagine a high-speed assembly line where one worker (ChaCha20) seals packages in tamper-proof boxes while another worker (Poly1305) stamps each box with an unforgeable wax seal — neither step slows the other down. ChaCha20-Poly1305 is an authenticated encryption with associated data (AEAD) cipher suite that combines the ChaCha20 stream cipher for confidentiality with the Poly1305 message authentication code for integrity, operating as a single atomic operation. It was designed by Daniel J. Bernstein as a software-friendly alternative to AES-GCM.

## Why it matters
AES requires hardware acceleration (AES-NI instructions) to run efficiently; on older Android phones and low-power IoT devices lacking that hardware, AES-GCM was dangerously slow, pushing developers toward weaker or improperly implemented ciphers. Google adopted ChaCha20-Poly1305 in TLS 1.3 and QUIC specifically to protect mobile users on resource-constrained devices without sacrificing security — ensuring that "fast enough to use correctly" became a security property itself.

## Key facts
- ChaCha20 is a **stream cipher** operating on 512-bit blocks with a 256-bit key and a 96-bit nonce; it produces a keystream XORed with plaintext
- Poly1305 is a **one-time MAC** — reusing the same key with a different nonce is safe, but reusing the same (key, nonce) pair is catastrophic and breaks authentication
- ChaCha20-Poly1305 is a **mandatory cipher suite in TLS 1.3** (RFC 8446) alongside AES-256-GCM
- It provides **AEAD**: encrypts plaintext while also authenticating unencrypted header data (e.g., packet metadata), preventing tampering without decryption
- It is **immune to timing side-channel attacks** related to cache behavior because it uses only ARX (add-rotate-XOR) operations, unlike AES S-box table lookups

## Related concepts
[[AES-GCM]] [[TLS 1.3]] [[Authenticated Encryption (AEAD)]] [[Stream Ciphers]] [[Nonce Reuse Attacks]]