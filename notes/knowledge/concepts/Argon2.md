# Argon2

## What it is
Think of it like a password vault that's deliberately built in a labyrinth requiring both a strong flashlight (CPU power) and a wide truck (memory) to navigate — you can't just sprint through it with lots of fast runners. Argon2 is a memory-hard key derivation function (KDF) and the winner of the 2015 Password Hashing Competition, designed to make brute-force and GPU-accelerated cracking prohibitively expensive by requiring large amounts of RAM in addition to processing time.

## Why it matters
When an attacker dumps a credential database and attempts offline cracking using a GPU farm, bcrypt and PBKDF2 remain vulnerable because GPUs can run thousands of parallel threads cheaply. Argon2's configurable memory requirement (e.g., 64MB per hash) forces each parallel cracking attempt to consume dedicated RAM, meaning a GPU with 8GB of VRAM can only run ~128 simultaneous guesses — turning a million-guess-per-second attack into a few thousand.

## Key facts
- **Three variants**: Argon2d (GPU-resistant, vulnerable to side-channel), Argon2i (side-channel resistant, weaker against GPU), and Argon2id (hybrid — recommended for most password hashing use cases)
- **Three tunable parameters**: time cost (iterations), memory cost (KiB of RAM), and parallelism (threads)
- OWASP recommends Argon2id with minimum 19MB memory, 2 iterations, and 1 parallelism factor as a baseline
- Argon2 is the default password hashing algorithm in PHP 7.2+ and is natively supported in libsodium
- Unlike MD5 or SHA-1, Argon2 is not a general-purpose hash — it is purpose-built to be *slow and memory-intensive* for credential storage

## Related concepts
[[bcrypt]] [[PBKDF2]] [[Rainbow Tables]] [[Key Derivation Function]] [[Credential Stuffing]]