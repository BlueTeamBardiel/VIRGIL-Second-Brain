# algorithms

## What it is
Like a recipe that transforms raw ingredients into a finished dish through precise, ordered steps — an algorithm is a finite, deterministic sequence of instructions that transforms input into output. In cryptography specifically, algorithms define exactly how plaintext becomes ciphertext (and back), leaving no room for improvisation.

## Why it matters
In 2023, researchers demonstrated practical attacks against systems still using MD5 for certificate signing — because MD5's algorithm has known collision vulnerabilities, attackers can craft two different inputs that produce the same hash, allowing forged certificates to appear legitimate. Choosing the wrong algorithm doesn't just weaken security; it can make the entire system cryptographically worthless.

## Key facts
- **Symmetric algorithms** (AES, 3DES) use the same key for encryption and decryption; **asymmetric algorithms** (RSA, ECC) use mathematically linked key pairs — knowing the public key doesn't reveal the private key
- **AES-256** is the current gold standard for symmetric encryption; Security+ expects you to know it's a block cipher operating on 128-bit blocks
- **Hashing algorithms** (SHA-256, SHA-3) are one-way — they produce a fixed-length digest and cannot be reversed; MD5 and SHA-1 are considered **cryptographically broken**
- Algorithm strength is measured by **key length** and **resistance to known attacks** (brute force, collision, birthday attacks) — longer keys exponentially increase attack cost
- **Post-quantum algorithms** (e.g., CRYSTALS-Kyber, CRYSTALS-Dilithium) are being standardized by NIST because Shor's algorithm running on quantum computers can break RSA and ECC

## Related concepts
[[encryption]] [[hashing]] [[public key infrastructure]] [[cryptographic attacks]] [[key management]]