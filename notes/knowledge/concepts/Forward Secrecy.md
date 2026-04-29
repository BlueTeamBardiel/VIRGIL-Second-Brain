# forward secrecy

## What it is
Imagine a spy who uses a different one-time pad for every message — even if the enemy captures the spy's master codebook, yesterday's messages remain unreadable. Forward secrecy (also called Perfect Forward Secrecy, or PFS) works the same way: it generates a unique, ephemeral session key for each connection, so that compromising a server's long-term private key cannot decrypt previously recorded traffic.

## Why it matters
In 2014, the NSA's MUSCULAR and PRISM programs revealed that intelligence agencies were bulk-collecting encrypted internet traffic to decrypt later — a "harvest now, decrypt later" strategy. Organizations using TLS cipher suites without PFS (e.g., RSA key exchange) were vulnerable: one stolen private key could retroactively expose years of captured sessions. Switching to ECDHE-based cipher suites eliminates this threat because the ephemeral keys are never stored.

## Key facts
- PFS is achieved through **ephemeral Diffie-Hellman** key exchanges — specifically **DHE** (classic) or **ECDHE** (elliptic curve, preferred for performance)
- TLS 1.3 **mandates** forward secrecy by eliminating static RSA key exchange entirely
- The session key is derived fresh per handshake and **never transmitted** — it exists only in memory during the session
- Cipher suites offering PFS contain the letter **"E"** in DHE/ECDHE (the "E" stands for ephemeral)
- PFS protects **confidentiality of past sessions** but does NOT protect against real-time man-in-the-middle attacks — authentication (certificates) still handles that

## Related concepts
[[TLS handshake]] [[Diffie-Hellman key exchange]] [[elliptic curve cryptography]] [[key management]] [[session keys]]