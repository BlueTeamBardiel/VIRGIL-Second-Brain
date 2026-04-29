# Nonce Reuse

## What it is
Imagine a one-time combination lock where using the same combination twice lets an attacker reverse-engineer everything you've ever locked. A nonce ("number used once") is a value that must never repeat within the same cryptographic context — reusing it catastrophically breaks confidentiality or authentication in stream ciphers and authenticated encryption schemes. In GCM and CTR mode, two ciphertexts encrypted with the same key+nonce pair can be XORed together, directly exposing the plaintexts.

## Why it matters
In 2012, researchers demonstrated the "forbidden attack" against TLS using AES-GCM: when a nonce repeated, attackers could forge authentication tags and decrypt traffic — breaking both confidentiality and integrity simultaneously. This vulnerability surfaced in real TLS implementations and led to strict nonce-misuse resistance becoming a design requirement for modern AEAD schemes like AES-GCM-SIV.

## Key facts
- **XOR catastrophe**: In stream-cipher-mode encryption (CTR, GCM), `C1 XOR C2 = P1 XOR P2`, meaning two ciphertexts under the same nonce leak plaintext directly.
- **TLS 1.3 mitigation**: TLS 1.3 uses a counter-based nonce derived from a sequence number, making accidental reuse structurally impossible.
- **AEAD double failure**: In GCM, nonce reuse doesn't just break confidentiality — it also breaks the authentication tag, enabling forgery.
- **WPA2 vulnerability**: KRACK (Key Reinstallation Attack, 2017) exploited nonce reuse in the WPA2 four-way handshake to decrypt Wi-Fi traffic.
- **Defense strategy**: Use deterministic counter-based nonces, randomized 96-bit nonces (acceptable at low volume), or nonce-misuse-resistant ciphers like AES-GCM-SIV or ChaCha20-Poly1305 with careful key management.

## Related concepts
[[Authenticated Encryption (AEAD)]] [[Stream Cipher Attacks]] [[KRACK Attack]] [[Initialization Vector (IV) Reuse]] [[CTR Mode Encryption]]