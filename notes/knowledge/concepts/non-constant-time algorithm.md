# non-constant-time algorithm

## What it is
Like a bouncer who checks a VIP list by stopping as soon as he finds your name — he spends less time on names near the top, leaking information through timing alone. A non-constant-time algorithm is one whose execution duration varies based on the input values being processed, meaning an attacker can infer secret data by precisely measuring how long operations take. This stands in contrast to constant-time algorithms, which always take the same duration regardless of input.

## Why it matters
In 2003, David Brumley and Dan Boneh demonstrated a remote timing attack against OpenSSL's RSA implementation — by measuring network response times to thousands of crafted queries, they could reconstruct a server's private key without ever seeing it directly. Password comparison functions that return `false` the moment a character mismatch is found are a classic example: an attacker can brute-force one character at a time, dramatically reducing the search space from millions to mere dozens of attempts per position.

## Key facts
- String comparison using `==` or `strcmp()` is almost always non-constant-time; use `hmac_compare_digest()` or equivalent cryptographic comparison functions instead
- Timing differences as small as nanoseconds can be exploited remotely when averaged over thousands of repeated requests (statistical timing attacks)
- Early-exit logic (returning false at first mismatch) is the most common cause of timing vulnerabilities in authentication code
- AES lookup-table implementations (T-table AES) are non-constant-time due to CPU cache behavior — this enabled cache-timing attacks like FLUSH+RELOAD
- NIST and security standards now explicitly require constant-time implementations for cryptographic primitives, secret comparisons, and key operations

## Related concepts
[[timing attack]] [[side-channel attack]] [[constant-time comparison]] [[cache-timing attack]] [[padding oracle attack]]