# AES-GCM

## What it is
Imagine a sealed diplomatic pouch: not only is the contents locked inside (encryption), but the wax seal proves no one tampered with it (authentication). AES-GCM (Advanced Encryption Standard – Galois/Counter Mode) is an authenticated encryption mode that simultaneously encrypts data with AES-CTR and produces a cryptographic authentication tag using GHASH, guaranteeing both confidentiality and integrity in a single operation.

## Why it matters
In TLS 1.3, AES-GCM replaced older modes like AES-CBC with HMAC precisely because CBC was vulnerable to padding oracle attacks (e.g., POODLE). If an attacker modifies even a single byte of AES-GCM ciphertext in transit, the 128-bit authentication tag verification fails and the receiver discards the message entirely — no silent data corruption or decryption of tampered content.

## Key facts
- **Nonce reuse is catastrophic**: Reusing the same IV/nonce with the same key completely breaks both confidentiality and authenticity — attackers can recover the authentication key (GHASH key) and forge messages.
- **Tag size matters**: The authentication tag is typically 128 bits; truncating it below 96 bits is considered dangerous and weakens forgery resistance.
- **AEAD construction**: AES-GCM is an Authenticated Encryption with Associated Data (AEAD) cipher — it can authenticate unencrypted header data (like IP headers) without encrypting it.
- **Counter mode base**: The encryption component uses AES-CTR, meaning AES-GCM is a stream cipher variant — no block-padding is needed, and random-access decryption is possible.
- **Hardware acceleration**: Intel's AES-NI and CLMUL CPU instructions make AES-GCM extremely fast in modern hardware, which is why it dominates TLS 1.3 cipher suites.

## Related concepts
[[AES-CBC]] [[TLS 1.3]] [[Authenticated Encryption (AEAD)]] [[IV/Nonce Reuse Attacks]] [[Padding Oracle Attack]]