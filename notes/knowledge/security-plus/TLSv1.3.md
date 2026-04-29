# TLSv1.3

## What it is
Like a bouncer who memorized the guest list in advance so you walk straight past the velvet rope — no fumbling for ID — TLS 1.3 cuts the cryptographic handshake from two round trips down to one. It is the 2018 IETF-standardized revision of the Transport Layer Security protocol (RFC 8446) that encrypts data in transit, removing legacy cipher suites and streamlining authentication to be faster and inherently more secure.

## Why it matters
Older TLS versions supported weak ciphers like RC4 and export-grade RSA, which enabled downgrade attacks such as POODLE and DROWN — attackers forced servers to negotiate the weakest mutually supported option. TLS 1.3 eliminates this threat by removing the negotiation of insecure algorithms entirely; there is no "downgrade" path because weak options simply don't exist in the protocol. A server enforcing TLS 1.3-only connections is immune to these entire attack families.

## Key facts
- **Removed cipher suites**: RC4, DES, 3DES, MD5, SHA-1, and static RSA key exchange are all gone; only AEAD ciphers (AES-GCM, ChaCha20-Poly1305) are permitted.
- **1-RTT handshake** by default; **0-RTT resumption** (early data) is supported but carries replay attack risk and must be used cautiously.
- **Perfect Forward Secrecy (PFS) is mandatory**: ephemeral Diffie-Hellman (ECDHE) is required for every session, meaning past sessions can't be decrypted even if the server's long-term key is later compromised.
- **Encrypted handshake metadata**: certificates are now sent encrypted, reducing information leakage compared to TLS 1.2.
- TLS 1.0 and 1.1 were formally deprecated by the IETF in RFC 8996 (2021), making 1.2 the minimum acceptable baseline and 1.3 the recommended standard.

## Related concepts
[[Perfect Forward Secrecy]] [[Downgrade Attack]] [[Certificate Pinning]] [[AEAD Encryption]] [[PKI]]