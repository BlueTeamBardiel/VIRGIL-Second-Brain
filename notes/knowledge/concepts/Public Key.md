# Public Key

## What it is
Think of a public key like a padlock you hand out freely to anyone — anyone can click it shut (encrypt a message), but only you hold the private key that opens it. Technically, a public key is one half of an asymmetric key pair, mathematically linked to its private counterpart, used to encrypt data or verify digital signatures.

## Why it matters
During a man-in-the-middle attack, an adversary may substitute their own public key for a legitimate server's — tricking clients into encrypting data the attacker can decrypt. This is precisely why **Certificate Authorities (CAs)** exist: they digitally sign public keys, binding them to verified identities so you can trust the key actually belongs to who you think it does.

## Key facts
- Public keys are derived from private keys using one-way mathematical functions (e.g., RSA uses prime factorization; ECC uses elliptic curves) — you cannot reverse-engineer the private key from the public key
- Public key length directly impacts security strength: RSA-2048 is the current minimum recommended size; RSA-1024 is considered broken
- Used in two distinct modes: **encrypt with public key → decrypt with private key** (confidentiality), or **sign with private key → verify with public key** (authentication)
- Public keys are embedded in X.509 digital certificates, which tie the key to an identity via a CA signature
- In TLS handshakes, the public key is exchanged early in the session to negotiate a symmetric session key — asymmetric crypto is too slow for bulk data transfer

## Related concepts
[[Private Key]] [[Digital Certificate]] [[Certificate Authority]] [[Asymmetric Encryption]] [[Public Key Infrastructure (PKI)]]