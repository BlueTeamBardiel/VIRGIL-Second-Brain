# entropy

## What it is
Think of entropy like the difference between a messy teenager's room (high entropy — stuff everywhere, unpredictable) versus a military barracks (low entropy — perfectly ordered, highly predictable). In cryptography and security, entropy measures the degree of randomness or unpredictability in a dataset, key, or password — higher entropy means more possible states and therefore harder to guess or brute-force.

## Why it matters
When a random number generator has low entropy — say, a poorly seeded PRNG on an embedded device — attackers can predict the "random" values it produces. This is exactly what happened with the Debian OpenSSL bug in 2008, where a code change accidentally reduced key generation entropy to only 32,767 possible values, allowing attackers to precompute and crack SSL/SSH keys across thousands of exposed systems in hours.

## Key facts
- Password entropy is calculated as **log₂(R^L)**, where R = character set size and L = password length; a 12-character password using all ASCII printable characters (~95) yields ~78.8 bits of entropy
- NIST recommends a minimum of **128 bits of entropy** for cryptographic keys used in symmetric encryption
- `/dev/random` on Linux blocks until sufficient entropy is available; `/dev/urandom` does not block and is preferred for most cryptographic operations
- Entropy pools are seeded by unpredictable system events: keystroke timing, disk I/O, network packet arrival times
- Low entropy is a critical vulnerability in IoT and embedded devices, which often boot with identical seeds before any user interaction occurs

## Related concepts
[[random number generation]] [[password complexity]] [[key generation]] [[cryptographic weaknesses]] [[brute force attacks]]