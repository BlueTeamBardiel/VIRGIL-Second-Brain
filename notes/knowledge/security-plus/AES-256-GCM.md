# AES-256-GCM

## What it is
Think of AES-256-GCM as a lockbox with a tamper-evident seal: it encrypts your data (the lock) AND proves nobody touched it in transit (the seal). Formally, it's AES in Galois/Counter Mode—a symmetric encryption algorithm combining 256-bit key encryption with built-in authentication, producing both ciphertext and an authentication tag in a single operation.

## Why it matters
When TLS 1.3 handshakes happen, your browser and server use AES-256-GCM to encrypt session data. If an attacker intercepts and modifies even one byte, the authentication tag fails to verify and the connection drops. Without the GCM (authenticated encryption), an attacker could flip bits in encrypted traffic and you'd decrypt garbage undetected.

## Key facts
- **256-bit keys**: 2^256 possible keys—unbreakable by brute force with known computing
- **Counter mode (CTR)**: Converts block cipher into stream cipher; parallelizable and fast
- **Galois/Counter Mode (GCM)**: Adds polynomial-based GHASH authentication over ciphertext
- **Nonce requirement**: A unique 96-bit nonce per message is CRITICAL; reuse breaks confidentiality and authenticity catastrophically
- **12-byte nonce sweet spot**: GCM optimized for 96-bit nonces; other lengths require expensive GHASH computation

## Related concepts
[[Authenticated Encryption]] [[TLS 1.3]] [[Block Cipher Modes]] [[Nonce Reuse]] [[ChaCha20-Poly1305]]