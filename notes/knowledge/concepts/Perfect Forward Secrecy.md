# Perfect Forward Secrecy

## What it is
Imagine a spy who uses a different one-time pad for every message — even if the enemy captures their master codebook later, past messages stay unreadable. Perfect Forward Secrecy (PFS) works the same way: each session generates a fresh, ephemeral encryption key that is never stored, so compromising the server's long-term private key cannot decrypt previously recorded traffic.

## Why it matters
In 2013, NSA bulk-collection programs revealed that adversaries were recording encrypted TLS traffic en masse, betting they could decrypt it later once private keys were obtained through legal orders or breaches. Servers configured with PFS (using ephemeral Diffie-Hellman or ECDHE cipher suites) rendered those recordings permanently useless — the session keys had already been discarded and could never be reconstructed.

## Key facts
- PFS is achieved through **ephemeral key exchange algorithms**: DHE (Ephemeral Diffie-Hellman) and ECDHE (Elliptic Curve DHE) are the primary implementations in TLS
- In TLS 1.3, **PFS is mandatory** — static RSA key exchange was removed entirely from the spec
- The session key is derived during the handshake and **never transmitted**; both sides compute it independently, then discard it after the session ends
- Without PFS (e.g., static RSA key exchange in TLS 1.2), an attacker who later obtains the server's private key can decrypt **all previously captured sessions**
- PFS protects against **retroactive decryption** attacks but does NOT prevent real-time man-in-the-middle attacks if the attacker is already present

## Related concepts
[[Diffie-Hellman Key Exchange]] [[TLS Handshake]] [[Ephemeral Keys]] [[Key Exchange Algorithms]] [[Transport Layer Security]]