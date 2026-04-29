# RSA Key Transport

## What it is
Like slipping a house key inside a locked safe-deposit box that only the recipient can open, RSA Key Transport encrypts a symmetric session key using the recipient's RSA public key and sends it across the wire. The recipient decrypts the ciphertext using their private key to recover the symmetric key, which then drives bulk encryption. It's a *key encapsulation* mechanism, not a full encryption scheme for data itself.

## Why it matters
TLS 1.2 supported RSA key transport as a cipher suite handshake option — the client would generate a pre-master secret and encrypt it with the server's public key. DROWN and ROBOT attacks exploited padding oracle vulnerabilities in this exact mechanism, allowing attackers to decrypt captured sessions. TLS 1.3 abolished RSA key transport entirely in favor of ephemeral Diffie-Hellman, eliminating the attack surface.

## Key facts
- RSA Key Transport uses **PKCS#1 v1.5 padding** historically; this padding scheme is vulnerable to Bleichenbacher's adaptive chosen-ciphertext attack (the "million-message attack")
- Lacks **forward secrecy** — if the server's private key is later compromised, all past recorded sessions encrypted with RSA transport can be decrypted retroactively
- The **ROBOT attack (2017)** showed that 27 of the Alexa Top 100 websites were still vulnerable to Bleichenbacher-style oracles in RSA key transport
- **TLS 1.3 explicitly removes** all RSA static key exchange cipher suites (RFC 8446), mandating ephemeral key exchange
- RSA key transport is distinct from **RSA key agreement** (like RSA-based Diffie-Hellman); transport means one party *chooses* the key and encrypts it, not a jointly derived secret

## Related concepts
[[Forward Secrecy]] [[PKCS#1 Padding Oracle]] [[TLS Handshake]] [[Asymmetric Encryption]] [[Bleichenbacher Attack]]