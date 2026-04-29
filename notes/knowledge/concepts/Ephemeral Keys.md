# Ephemeral Keys

## What it is
Like a one-time combination lock that self-destructs after a single use, ephemeral keys are cryptographic key pairs generated fresh for each session and discarded immediately afterward. Unlike long-term static keys, they exist only for the duration of a single exchange and are never stored or reused.

## Why it matters
In 2011, a compromise of RSA's SecurID seeds demonstrated why static, long-lived keys are dangerous — once stolen, they unlock everything, past and future. Ephemeral keys solve this by enabling **Perfect Forward Secrecy (PFS)**: even if an attacker records encrypted TLS traffic today and steals the server's private key tomorrow, they still cannot decrypt past sessions because the session keys were never stored and are mathematically unrecoverable.

## Key facts
- Ephemeral Diffie-Hellman (DHE) and Elliptic Curve Diffie-Hellman Ephemeral (ECDHE) are the most common mechanisms for generating ephemeral keys in TLS 1.3
- TLS 1.3 **mandates** ephemeral key exchange, eliminating static RSA key exchange entirely — this is a direct Security+ exam point
- The "E" in ECDHE signals ephemeral; cipher suites without it (e.g., plain DH) do **not** provide forward secrecy
- Ephemeral keys protect against **retroactive decryption attacks**, where adversaries bulk-record ciphertext to decrypt later once keys are obtained
- Key generation overhead is the main trade-off: servers under heavy load must generate fresh key pairs per session, though ECDHE mitigates this with smaller key sizes and faster math

## Related concepts
[[Perfect Forward Secrecy]] [[Diffie-Hellman Key Exchange]] [[TLS Handshake]] [[Public Key Infrastructure]] [[Session Keys]]