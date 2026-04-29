# Block Cipher Modes

## What it is
Imagine stamping the same rubber stamp on every page of a document — identical pages produce identical stamps, leaking the pattern. Block cipher modes solve exactly this problem: they define *how* a block cipher (like AES) repeatedly applies its fixed-size encryption function across a stream of data larger than one block. Without a mode, encrypting identical plaintext blocks always yields identical ciphertext — a catastrophic pattern leak.

## Why it matters
In 2013, researchers demonstrated that TLS 1.0 using AES in CBC mode was vulnerable to the BEAST attack, which exploited predictable IV chaining to decrypt session cookies. This forced a mass migration toward modes with proper IV randomization and eventually to authenticated encryption modes like GCM. Choosing the wrong mode is not theoretical — it directly enables session hijacking.

## Key facts
- **ECB (Electronic Codebook)** is the "bad stamp" mode — identical plaintext blocks = identical ciphertext blocks. Never use it for structured data; the famous "ECB penguin" image makes the flaw visible.
- **CBC (Cipher Block Chaining)** XORs each plaintext block with the previous ciphertext block; requires a random, unpredictable IV and is vulnerable to padding oracle attacks (e.g., POODLE).
- **CTR (Counter Mode)** turns a block cipher into a stream cipher by encrypting an incrementing counter; parallelizable and IV reuse is catastrophic — it reveals XOR of plaintexts.
- **GCM (Galois/Counter Mode)** = CTR + authentication tag; provides both confidentiality and integrity (AEAD). It is the dominant mode in TLS 1.3.
- **IV/Nonce reuse** is the universal cardinal sin across CBC, CTR, and GCM — it breaks security guarantees at different severity levels in each mode.

## Related concepts
[[AES Encryption]] [[Padding Oracle Attack]] [[Authenticated Encryption]] [[Initialization Vector]] [[TLS Protocol]]