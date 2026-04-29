# Timing Attack

## What it is
Imagine a safecracker who listens for the faint click of each tumbler falling into place — they don't need the combination, just their ears and patience. A timing attack works the same way: an adversary measures *how long* a system takes to perform cryptographic or authentication operations to infer secret information, without ever breaking the algorithm directly.

## Why it matters
In 2003, David Brumley and Dan Boneh demonstrated a remote timing attack against OpenSSL's RSA implementation — by measuring network response times across thousands of requests, they recovered a server's private key without ever touching it directly. This forced a widespread shift toward **constant-time algorithms**, where execution time is deliberately kept identical regardless of input, eliminating the side-channel entirely.

## Key facts
- Timing attacks are a class of **side-channel attack** — they exploit implementation leakage, not mathematical weaknesses in the algorithm itself
- String comparison functions that short-circuit on the first mismatch (like `strcmp()`) are classic timing attack targets; secure code uses **constant-time comparison** instead
- Even *remote* timing attacks are viable over networks when averaged across thousands of requests to reduce jitter noise
- HMAC verification and password hashing functions (like bcrypt) must use timing-safe comparison to prevent leaking match/no-match information
- Countermeasures include: constant-time operations, adding random delay (less reliable), and hardware security modules (HSMs) that normalize execution time

## Related concepts
[[Side-Channel Attack]] [[Cryptographic Attack]] [[HMAC]] [[RSA]] [[Padding Oracle Attack]]