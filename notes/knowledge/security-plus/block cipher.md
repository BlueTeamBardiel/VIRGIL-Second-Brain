# block cipher

## What it is
Like a combination lock that scrambles a fixed-size chunk of your luggage tag at a time — the same tag, same combo, same scrambled output every time — a block cipher is a symmetric encryption algorithm that operates on fixed-length groups of bits (called blocks), producing a ciphertext block of identical size. Unlike stream ciphers that encrypt one bit at a time, block ciphers process data in discrete chunks, typically 64 or 128 bits.

## Why it matters
In 2011, attackers exploited the BEAST attack against TLS 1.0, which used AES in CBC (Cipher Block Chaining) mode. Because CBC XORs each plaintext block with the previous ciphertext block, a flaw in how the IV was chosen allowed attackers to decrypt session cookies and hijack HTTPS sessions. This forced the industry toward TLS 1.2+ and modes like GCM that don't share CBC's IV predictability weakness.

## Key facts
- **AES (Advanced Encryption Standard)** uses a 128-bit block size with key lengths of 128, 192, or 256 bits — the current gold standard for symmetric encryption
- **DES** used a 64-bit block with a 56-bit key; it's broken and deprecated — 3DES is also being phased out by NIST as of 2023
- **Modes of operation** (ECB, CBC, CTR, GCM) determine how a block cipher handles data larger than one block — mode choice is as critical as algorithm choice
- **ECB mode is dangerous**: identical plaintext blocks produce identical ciphertext blocks, leaking patterns (the "ECB penguin" is the canonical demo)
- **AES-GCM** provides both confidentiality and integrity (authenticated encryption), making it the preferred mode in TLS 1.3

## Related concepts
[[symmetric encryption]] [[modes of operation]] [[AES]] [[stream cipher]] [[cipher block chaining]]