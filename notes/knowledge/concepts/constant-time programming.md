# constant-time programming

## What it is
Like a poker player who always takes exactly 5 seconds before betting — whether holding a royal flush or a busted hand — constant-time code executes in the same duration regardless of the secret data it processes. Precisely: it is a coding discipline where the execution time of a function does not vary based on secret inputs, eliminating timing side channels that attackers could exploit to infer private values.

## Why it matters
In 2013, researchers demonstrated a timing attack against OpenSSL's RSA implementation: by measuring thousands of decryption operations and observing nanosecond-level timing differences, they could reconstruct private keys. Lucky Thirteen similarly exploited non-constant MAC comparison in TLS's CBC padding validation — patching required rewriting the HMAC check to always run in fixed time regardless of where padding errors occurred.

## Key facts
- **Early exit is the enemy**: a string comparison like `if (s[i] != t[i]) return false` leaks key length and position of first mismatch through timing differences
- **The core rule**: never branch on secret data and never allow secret data to influence memory access patterns (which leak through cache timing)
- **`memcmp()` is NOT constant-time** for security purposes; use dedicated functions like `crypto_verify_32()` (libsodium) or `CRYPTO_memcmp()` (OpenSSL)
- **Compiler betrayal**: optimizers can *remove* constant-time constructs, so implementations use compiler barriers, volatile keywords, or assembly to prevent "helpful" optimizations
- **Relevant standards**: NIST and cryptographic libraries (libsodium, BoringSSL) mandate constant-time operations for all secret-key comparisons, ECDSA nonce generation, and AES S-box lookups

## Related concepts
[[timing side-channel attacks]] [[cache-timing attacks]] [[side-channel analysis]] [[cryptographic implementation security]]