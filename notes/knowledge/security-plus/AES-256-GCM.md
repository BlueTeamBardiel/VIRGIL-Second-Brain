# AES-256-GCM

## What it is

Think of sending a sealed loot crate in Escape from Tarkov to a teammate: the crate is locked (nobody can see what's inside), and it has a tamper-evident seal (if anyone pries it open mid-transit, your teammate knows instantly and refuses delivery). AES-256-GCM is that crate. It locks your data **and** seals it in one swing.

Technically, AES-256-GCM is a symmetric encryption algorithm — same key on both ends — that does two jobs simultaneously:

1. **Encryption** via AES (Advanced Encryption Standard) with a 256-bit key
2. **Authentication** via GCM (Galois/Counter Mode), which spits out a short "authentication tag" proving the ciphertext wasn't tampered with

The "256" is the key size: 2²⁵⁶ possible keys. That's a number with 78 digits. Brute-forcing it is the cryptographic equivalent of trying to roll a perfect Elden Ring run blindfolded with the controller unplugged — not happening on this side of heat death.

The "GCM" part is two ideas glued together:

- **Counter Mode (CTR)**: AES is a *block* cipher — natively it encrypts fixed 128-bit chunks. CTR mode turns it into a *stream* cipher. Instead of encrypting your data directly, it encrypts a counter (1, 2, 3, 4...) and XORs the result against your plaintext. Like a Minecraft world seed: feed the same counter value into AES with the same key, you get the same pseudo-random keystream every time. XOR that keystream onto your data and you've got ciphertext. Because each block depends only on its own counter value, you can encrypt all the blocks **in parallel** — your CPU can chew on block 47 and block 4,000 at the same time. This is why AES-GCM is screamingly fast on modern hardware.
- **GHASH (the Galois part)**: After encryption, GCM runs the ciphertext through GHASH, a polynomial hash over the finite field GF(2¹²⁸). The output is the authentication tag. Modify even one bit of ciphertext in transit, the tag won't match on the receiver's side, and the whole message gets rejected.

One operation. Two guarantees. No separate "encrypt-then-MAC" dance.

## Why it matters

Every time you load a website over HTTPS in 2024, there's a very good chance AES-256-GCM is doing the heavy lifting underneath. TLS 1.3 — the protocol securing basically the modern web — uses AEAD ciphers like AES-256-GCM to encrypt session data after the handshake. Your Discord messages, your bank login, the Steam download for the next CS2 update: all riding on this.

The "authenticated" part is the quiet hero. Older setups encrypted data without authenticating it, which is like locking your front door but leaving the hinges exposed — attackers could flip bits in transit to manipulate the decrypted output without you ever knowing. GCM closes that hole. If a single ciphertext bit gets flipped by a bad actor (or by a flaky network), tag verification fails, and TLS 1.3 **terminates the connection** rather than process garbage data. Fail loud, fail fast.

## The nonce: the one rule you cannot break

Here's the catch, and it's a big one. GCM requires a **unique 96-bit nonce per message** under the same key. "Nonce" = "number used once." Think of it like the spawn seed for each match in a roguelike: every run needs a fresh seed, otherwise you're playing the exact same dungeon twice.

Reuse a nonce with the same key, and AES-256-GCM detonates:

- **Confidentiality dies**: XOR two ciphertexts encrypted with the same keystream and the keystream cancels out, leaving the XOR of the two plaintexts — recoverable with basic cryptanalysis.
- **Authenticity dies**: Nonce reuse leaks the GHASH authentication subkey. Once an attacker has that, they can forge valid tags for arbitrary messages. They can pretend to be you. Forever. With that key.

This isn't "things degrade a little." This is *catastrophic*. It's the cryptographic equivalent of a Helldivers 2 friendly-fire 500kg eagle strike — total wipe.

Why exactly 96 bits? GCM is **optimized** for 96-bit nonces. That length plugs directly into the counter format with no preprocessing. Use any other length and GCM has to run an expensive GHASH computation just to derive the internal nonce — slower, and historically a source of implementation bugs. Stick to 96 bits.

## Key facts

- **Symmetric**: one shared 256-bit key encrypts and decrypts. Both sides need it; key exchange happens elsewhere (e.g., the TLS handshake).
- **2²⁵⁶ keyspace**: brute force is not a real threat. Quantum computers might eventually halve effective strength via Grover's algorithm, but 128 bits of post-quantum security is still absurd.
- **AEAD cipher**: Authenticated Encryption with Associated Data. You can also feed it unencrypted-but-authenticated metadata (like packet headers) — it won't encrypt that data, but it will refuse to decrypt if someone tampers with it.
- **Output**: ciphertext (same length as plaintext, since CTR is a stream cipher) plus a 128-bit authentication tag.
- **Parallelizable**: CTR mode lets modern CPUs with AES-NI instructions hit multi-gigabit-per-second throughput. Same reason a multi-threaded Minecraft chunk loader smokes a single-threaded one.
- **Nonce: 96 bits, unique per message under the same key.** Repeat = game over. Common strategies: random 96-bit nonces (safe up to ~2³² messages before birthday-bound collisions), or a counter you increment per message.
- **Tag verification is constant-time and binary**: pass or fail. In TLS 1.3, fail = connection torn down immediately. No partial trust, no "let's see what the plaintext says anyway."
- **TLS 1.3 cipher suite**: `TLS_AES_256_GCM_SHA384` is one of the standard suites. The handshake derives session keys, then bulk encryption switches to AES-256-GCM.
- **Hardware accelerated**: Intel/AMD AES-NI and ARMv8 crypto extensions make AES-256-GCM faster in hardware than many "lightweight" software ciphers. Speed and security, rare combo.

## Related concepts

[[AES]] · [[TLS 1.3]] · [[Block ciphers vs stream ciphers]] · [[AEAD]] · [[ChaCha20-Poly1305]] · [[Nonce reuse attacks]] · [[CTR mode]] · [[GHASH and GF(2^128)]] · [[Symmetric vs asymmetric encryption]] · [[AES-NI]] · [[Key exchange]]
---
*Source: VIRGIL knowledge base — 2026-05-08*
