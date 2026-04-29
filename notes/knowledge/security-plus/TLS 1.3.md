# TLS 1.3

## What it is
Like a bouncer who memorized the VIP list ahead of time — the handshake happens in one round trip instead of two because both sides agree on parameters *before* the conversation even starts. TLS 1.3 is the current version of the Transport Layer Security protocol, standardized in RFC 8446 (2018), designed to encrypt data in transit while eliminating the weak cryptographic options that plagued earlier versions.

## Why it matters
In 2016, the DROWN attack exploited servers that still supported SSLv2 alongside TLS, allowing attackers to decrypt modern TLS sessions by leveraging the old protocol's weaknesses. TLS 1.3 eliminates this class of problem entirely by removing all legacy cipher suites — no RSA key exchange, no RC4, no SHA-1 — so there's nothing weak for attackers to downgrade to.

## Key facts
- **1-RTT handshake by default** (vs. 2-RTT in TLS 1.2), reducing latency and attack surface during negotiation
- **0-RTT resumption** allows returning clients to send data immediately, but introduces replay attack risk — important trade-off for exam questions
- **Forward secrecy is mandatory**: only ephemeral key exchange algorithms (ECDHE, DHE) are supported; static RSA key exchange is removed
- **Removed cipher suites**: RC4, DES, 3DES, MD5, SHA-1, and export-grade ciphers are all eliminated
- **Supported cipher suites** are exclusively AEAD algorithms: AES-GCM, AES-CCM, and ChaCha20-Poly1305

## Related concepts
[[Perfect Forward Secrecy]] [[Downgrade Attack]] [[Certificate Pinning]] [[Cipher Suite]] [[PKI]]