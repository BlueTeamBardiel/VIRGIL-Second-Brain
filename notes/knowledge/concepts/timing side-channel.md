# timing side-channel

## What it is
Like a safecracker who listens for the faint click of tumblers falling into place, an attacker measures *how long* a system takes to respond rather than reading protected data directly. A timing side-channel is an unintended information leak where the execution time of a cryptographic or authentication operation varies in ways that reveal secret values.

## Why it matters
In 2003, researchers demonstrated a timing attack against OpenSSL's RSA implementation: by sending thousands of crafted ciphertexts and measuring response times to microsecond precision, they recovered a server's private key without ever breaking the math. The fix — constant-time implementations where every code path takes identical time regardless of key bits — is now a baseline requirement for cryptographic libraries.

## Key facts
- **Root cause:** Conditional branches and early-exit logic (e.g., `if secret[i] != input[i]: return False`) cause measurable time differences that leak secret data bit by bit.
- **String comparison vulnerability:** Naive password/HMAC comparison functions that short-circuit on the first mismatched byte are classic timing side-channel targets; `hmac.compare_digest()` in Python exists specifically to prevent this.
- **Remote exploitability:** Attacks work even over networks; statistical analysis across thousands of requests can filter out network jitter and still extract signal.
- **Constant-time countermeasure:** Secure code ensures all branches execute in identical time using bitwise operations and masking, never early returns — this is the primary defense.
- **Bleichenbacher/Lucky13:** Both famous attacks on SSL/TLS (RSA PKCS#1 padding and CBC-mode MAC verification) used timing differences of nanoseconds to break real-world encrypted sessions.

## Related concepts
[[side-channel attack]] [[cache-timing attack]] [[cryptographic implementation security]]