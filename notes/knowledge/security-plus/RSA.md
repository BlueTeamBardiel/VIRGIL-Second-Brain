# RSA

## What it is
Like a padlock that anyone can snap shut using your public key, but only you hold the unique key that opens it — RSA is an asymmetric encryption algorithm that uses a mathematically linked key pair (public and private) based on the computational difficulty of factoring the product of two large prime numbers.

## Why it matters
In 2012, researchers discovered that millions of RSA public keys on the internet shared prime factors due to poor random number generation during key creation — meaning private keys could be mathematically derived and attackers could silently decrypt "secure" communications. This attack, known as the factorable keys vulnerability, exposed that RSA's strength lives entirely in the quality of its prime number selection, not just key length.

## Key facts
- RSA key strength is measured in bits; **2048-bit is the current minimum standard**, with 4096-bit recommended for long-term sensitive data — keys below 1024-bit are considered broken
- RSA is used for **key exchange and digital signatures**, not bulk data encryption (it's too slow); hybrid schemes like TLS use RSA to encrypt a symmetric session key
- The **private key decrypts** what the public key encrypts; the private key **signs** what the public key verifies — these are opposite operations
- **PKCS#1 v1.5 padding** (older RSA padding scheme) is vulnerable to Bleichenbacher's oracle attack; use **OAEP padding** for encryption instead
- RSA is vulnerable to **quantum computing attacks** via Shor's Algorithm, which can factor large primes efficiently — driving the move toward post-quantum cryptography (NIST PQC standards)

## Related concepts
[[Asymmetric Encryption]] [[Public Key Infrastructure (PKI)]] [[Digital Signatures]] [[Diffie-Hellman Key Exchange]] [[TLS Handshake]]