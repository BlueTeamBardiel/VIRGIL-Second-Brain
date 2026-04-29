# Diffie-Hellman

## What it is
Two strangers mix their secret paint colors into a shared public color, and even if an eavesdropper watches every step, they can't reverse-engineer the final private mixture. Formally, Diffie-Hellman (DH) is a key exchange protocol that allows two parties to establish a shared secret over an insecure channel using modular exponentiation — without ever transmitting the secret itself. Neither party needs a pre-existing shared key, making it the foundation of forward-secure communications.

## Why it matters
In the **FREAK** and **Logjam** attacks (2015), attackers forced TLS servers to downgrade DH to "export-grade" 512-bit parameters, then cracked the weak keys using precomputed discrete logarithm tables to decrypt live HTTPS sessions. This demonstrated that DH is only as strong as its group parameters — weak primes make the whole system breakable at scale.

## Key facts
- **Core math:** Security relies on the hardness of the Discrete Logarithm Problem — easy to compute `g^x mod p`, computationally infeasible to reverse it
- **DHE vs. static DH:** Ephemeral Diffie-Hellman (DHE) generates a new key pair per session, providing **Perfect Forward Secrecy (PFS)** — compromising the server's long-term key doesn't expose past sessions
- **Elliptic Curve variant (ECDHE)** offers equivalent security to DHE with smaller key sizes (256-bit ECDH ≈ 3072-bit DH), preferred in modern TLS 1.3
- **Vulnerable to MitM:** DH alone provides no authentication — an attacker can intercept and impersonate both parties; certificates (PKI) are required to prevent this
- **Minimum safe parameters:** NIST recommends ≥ 2048-bit primes for standard DH; 1024-bit is considered broken

## Related concepts
[[Perfect Forward Secrecy]] [[TLS Handshake]] [[Elliptic Curve Cryptography]] [[Public Key Infrastructure]] [[Man-in-the-Middle Attack]]