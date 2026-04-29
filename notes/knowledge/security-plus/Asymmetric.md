# Asymmetric

## What it is
Like a padlock anyone can snap shut with the public shackle, but only the owner's private key can open it — asymmetric cryptography uses a mathematically linked key pair where what one key encrypts, only the other can decrypt. Specifically, a public key (freely shared) and a private key (kept secret) are generated together, and operations performed with one can only be reversed with the other. This solves the classic "how do we share a secret over an insecure channel?" problem.

## Why it matters
During TLS handshakes, your browser uses a server's public key to encrypt a session key or verify a digital signature — if an attacker intercepts this traffic, they cannot decrypt it without the server's private key. This is why certificate theft (stealing the private key) is catastrophic: an attacker with a server's private key can impersonate that server entirely, enabling man-in-the-middle attacks that appear legitimate to all parties.

## Key facts
- **Common algorithms**: RSA (key exchange/signatures), ECC (Elliptic Curve — smaller keys, same strength), Diffie-Hellman (key exchange only)
- **RSA key sizes**: 2048-bit is the current minimum standard; 4096-bit for high-security environments
- **Slower than symmetric**: Asymmetric is computationally expensive — in practice, it encrypts a symmetric session key (hybrid encryption), not bulk data
- **Digital signatures work in reverse**: You sign with your *private* key; others verify with your *public* key — proving authenticity and non-repudiation
- **Key distribution problem solved**: Unlike symmetric encryption, public keys can be shared openly without compromising security — the foundation of PKI

## Related concepts
[[Public Key Infrastructure (PKI)]] [[Digital Signatures]] [[TLS/SSL]] [[Symmetric Encryption]] [[Diffie-Hellman]]