# TLS

## What it is
Think of TLS like a sealed diplomatic pouch: before any letter changes hands, both parties verify each other's credentials and negotiate a secret lock that only they share — then everything inside is tamper-evident and unreadable to bystanders. Technically, TLS (Transport Layer Security) is a cryptographic protocol that provides confidentiality, integrity, and authentication for data in transit over a network. It replaced SSL and operates between the Transport and Application layers.

## Why it matters
In 2014, the POODLE attack exploited a downgrade vulnerability that tricked servers into falling back to SSL 3.0, allowing attackers to decrypt session cookies via a padding oracle attack. This is why modern configurations explicitly disable SSL 3.0 and TLS 1.0/1.1 — leaving only TLS 1.2 and 1.3 enabled — and why cipher suite hardening is a routine hardening task for any internet-facing server.

## Key facts
- **TLS 1.3** (RFC 8446) eliminated weak cipher suites, removed RSA key exchange, and reduced the handshake to **1-RTT** (one round trip), improving both security and speed
- The TLS handshake establishes a **session key** using asymmetric crypto (e.g., ECDHE), then switches to symmetric encryption (e.g., AES-GCM) for bulk data transfer
- **Certificate pinning** defends against rogue CAs by hardcoding expected certificates or public keys into a client application
- TLS provides **server authentication** by default; **mutual TLS (mTLS)** adds client-side certificates for two-way authentication, common in zero-trust architectures
- A TLS **downgrade attack** forces negotiation to weaker protocol versions; HSTS (HTTP Strict Transport Security) and TLS_FALLBACK_SCSV help prevent this

## Related concepts
[[PKI]] [[Certificate Authority]] [[Symmetric Encryption]] [[Asymmetric Encryption]] [[HTTPS]] [[Man-in-the-Middle Attack]]