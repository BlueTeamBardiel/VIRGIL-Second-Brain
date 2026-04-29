# BerNAEL

## What it is
Like a Swiss Army knife that someone has quietly removed two blades from — it looks complete but it's not. BerNAEL (Bernstein's Nonce-Abusing Encryption Layer) refers to a cryptographic vulnerability class where nonce reuse in authenticated encryption schemes (particularly those derived from Bernstein's designs like XSalsa20-Poly1305) collapses confidentiality and authentication simultaneously, exposing both plaintext and the ability to forge messages.

## Why it matters
In 2016, researchers demonstrated that implementations of libsodium's `crypto_secretbox` misused in multi-session contexts reused nonces due to improper state management — an attacker intercepting two ciphertexts encrypted under the same nonce could XOR them to cancel the keystream, recovering plaintext fragments and forging authenticated messages without ever touching the key. This class of failure directly undermines zero-trust encrypted channels in applications that assumed the underlying library "handled" nonce generation safely.

## Key facts
- Nonce reuse in stream-cipher-based AEAD (Authenticated Encryption with Associated Data) allows keystream recovery via ciphertext XOR: C1 ⊕ C2 = P1 ⊕ P2
- Bernstein-family ciphers (ChaCha20, XSalsa20) are semantically secure *only* when nonces are never repeated under the same key
- Forgery becomes possible because Poly1305 authentication tags can be manipulated once the keystream is known
- Mitigation: use random 192-bit nonces (XChaCha20) or stateful counters with strict monotonicity enforcement
- Security+ relevance: falls under "weak cipher implementation" and "improper key management" failure categories

## Related concepts
[[Nonce Reuse Attack]] [[AEAD]] [[ChaCha20-Poly1305]] [[Stream Cipher Vulnerabilities]] [[Message Forgery]]