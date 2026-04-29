# GMAC

## What it is
Think of GMAC as a wax seal on a royal letter — it proves the letter hasn't been tampered with, but unlike encryption, it doesn't hide the contents. GMAC (Galois Message Authentication Code) is the authentication-only variant of GCM (Galois/Counter Mode), using Galois field multiplication to produce an integrity tag over data without encrypting it. It provides authenticity and integrity but no confidentiality.

## Why it matters
In network protocols like TLS 1.3, cipher suites can use GMAC to authenticate plaintext traffic where performance matters but secrecy is less critical — such as authenticating headers or metadata. An attacker who forges or flips bits in unauthenticated traffic would be caught by GMAC's tag verification, making bit-flipping attacks ineffective. However, if an implementation reuses a nonce with the same key, the entire authentication scheme collapses and an attacker can recover the authentication key.

## Key facts
- GMAC is essentially AES-GCM with a plaintext input of zero length — all data is treated as Additional Authenticated Data (AAD), not encrypted
- Produces a 128-bit authentication tag using Galois field (GF(2¹²⁸)) multiplication
- **Nonce reuse is catastrophic**: reusing a (key, nonce) pair leaks the authentication key H, completely breaking integrity guarantees
- GMAC provides **integrity and authenticity only** — it is NOT a confidentiality mechanism; data remains in plaintext
- Used in IPsec and TLS cipher suites such as `TLS_RSA_WITH_AES_128_GCM_SHA256` as the MAC component

## Related concepts
[[GCM]] [[AES]] [[HMAC]] [[Message Authentication Code]] [[Nonce]]