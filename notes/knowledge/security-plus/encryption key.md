# encryption key

## What it is
Think of an encryption key like a specific cut of a physical key — the lock (algorithm) is public knowledge, but only the exact tooth pattern (key value) determines what opens it. Precisely: an encryption key is a string of bits used by a cryptographic algorithm to transform plaintext into ciphertext (encryption) or reverse that process (decryption). The algorithm is the mechanism; the key is the secret.

## Why it matters
In 2011, RSA Security was breached and seed values for their SecurID tokens were stolen — not the algorithm, but the keys. This illustrates the core principle: a compromised key breaks security regardless of how strong the algorithm is. Protecting key material is often more critical than choosing the algorithm itself.

## Key facts
- **Symmetric keys** use the same key for encryption and decryption (AES-256); **asymmetric keys** use a mathematically linked public/private pair (RSA, ECC)
- Key length directly impacts brute-force resistance: AES-128 offers ~2¹²⁸ possible keys; AES-256 doubles the bit strength, squaring the search space
- **Key exchange problem**: symmetric keys must be shared securely before communication — solved by Diffie-Hellman or asymmetric wrapping
- **Key stretching** (PBKDF2, bcrypt) derives strong keys from weak passwords by adding salt and iteration cost, defending against rainbow table attacks
- NIST recommends a minimum of 2048-bit RSA keys and 256-bit ECC keys for equivalent security to AES-128

## Related concepts
[[symmetric encryption]] [[asymmetric encryption]] [[key management]] [[certificate authority]] [[Diffie-Hellman]]