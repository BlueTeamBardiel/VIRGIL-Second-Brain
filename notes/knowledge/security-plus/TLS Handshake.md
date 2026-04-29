# TLS handshake

## What it is
Like two spies meeting in a café — they flash credentials, agree on a secret code word, and only then start talking privately — the TLS handshake is the negotiation phase where a client and server establish mutual trust and derive shared encryption keys before any application data is exchanged. It authenticates the server (and optionally the client), agrees on cipher suites, and establishes session keys using asymmetric cryptography to bootstrap symmetric encryption.

## Why it matters
In a **downgrade attack** (e.g., POODLE or DROWN), an attacker manipulates the handshake negotiation to force both parties to agree on a weaker, deprecated protocol like SSLv3 or export-grade ciphers — making the session trivially breakable. Defenders counter this by explicitly disabling legacy protocol versions and weak cipher suites on servers, ensuring the handshake can never negotiate below TLS 1.2.

## Key facts
- **TLS 1.3** (2018) eliminated the full RSA key exchange entirely; forward secrecy via ephemeral Diffie-Hellman (DHE/ECDHE) is now mandatory
- The handshake uses **asymmetric encryption** (e.g., RSA or ECDSA) only for authentication and key exchange — bulk data uses faster symmetric keys derived from it
- A **Certificate Authority (CA)** signature on the server's certificate is what the client trusts; without it, the handshake completes but identity is unverified (TOFU or self-signed risk)
- TLS 1.3 reduced handshake latency from **2 round-trips to 1** (and supports **0-RTT resumption**, which reintroduces replay risk)
- **SNI (Server Name Indication)** is transmitted in plaintext during the handshake, leaking which domain a client is connecting to — a surveillance/tracking concern addressed by **Encrypted Client Hello (ECH)**

## Related concepts
[[PKI]] [[Certificate Authority]] [[Cipher Suite]] [[Forward Secrecy]] [[Man-in-the-Middle Attack]]