# Asymmetric Cryptography

## What it is
Imagine a public mailbox slot anyone can drop a letter into, but only you hold the key to open the box and retrieve it — that's asymmetric cryptography. It uses a mathematically linked key pair: a **public key** (freely shared, used to encrypt or verify) and a **private key** (secret, used to decrypt or sign). Unlike symmetric systems, you never need to secretly exchange the encryption key itself.

## Why it matters
When you connect to your bank's website over HTTPS, asymmetric cryptography (typically RSA or ECDH) is used during the TLS handshake to securely exchange a session key — without ever transmitting a shared secret over the wire. An attacker sniffing that handshake cannot derive the session key because breaking the asymmetric math (factoring a 2048-bit RSA modulus) is computationally infeasible with current technology. This is why stolen traffic captures alone don't expose your banking credentials.

## Key facts
- Uses two mathematically linked keys: **public** (encrypt/verify) and **private** (decrypt/sign) — data encrypted with one can only be decrypted by the other
- Common algorithms: **RSA** (factoring problem), **ECC/ECDSA** (elliptic curve discrete log problem), **Diffie-Hellman** (key exchange, not encryption)
- Asymmetric is **significantly slower** than symmetric; in practice it encrypts a symmetric key, not the bulk data (hybrid encryption model)
- **Digital signatures** reverse the key roles: sender signs with their *private* key, receiver verifies with the sender's *public* key — proving authenticity and non-repudiation
- Key lengths matter: RSA-2048 is currently acceptable; RSA-1024 is considered broken for most purposes

## Related concepts
[[Symmetric Cryptography]] [[Public Key Infrastructure (PKI)]] [[Digital Signatures]] [[TLS Handshake]] [[Diffie-Hellman Key Exchange]]