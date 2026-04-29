# python-jose

## What it is
Think of it as a Swiss Army knife for handling digital ID badges in Python — it knows how to stamp them, verify them, and read every field. `python-jose` is a Python library implementing the JOSE (JSON Object Signing and Encryption) standards, including JWT (JSON Web Tokens), JWS (JSON Web Signature), JWE (JSON Web Encryption), and JWK (JSON Web Keys). It allows developers to create, sign, verify, and decrypt tokens used in authentication and authorization flows.

## Why it matters
A misconfigured `python-jose` implementation has directly enabled real-world authentication bypasses — notably, accepting tokens signed with the `none` algorithm, where an attacker strips the signature entirely and the library validates the token anyway. In the CVE-2022-29217 vulnerability affecting `python-jose`, attackers could craft tokens that confused the library's algorithm selection, bypassing signature verification and impersonating any user — including administrators.

## Key facts
- `python-jose` implements RFC 7519 (JWT), RFC 7515 (JWS), RFC 7516 (JWE), and RFC 7517 (JWK)
- The `none` algorithm attack is a classic JWT vulnerability — always explicitly reject it using an `algorithms` whitelist: `jwt.decode(token, key, algorithms=["HS256"])`
- Algorithm confusion attacks (e.g., swapping RS256 for HS256) can trick servers into verifying an asymmetric token using the public key as an HMAC secret
- JWT claims like `exp` (expiration), `iss` (issuer), and `aud` (audience) must be explicitly validated — `python-jose` does **not** always enforce them automatically
- Prefer `python-jose[cryptography]` backend over the default pure-Python backend for production use due to stronger cryptographic primitives

## Related concepts
[[JSON Web Tokens]] [[OAuth 2.0]] [[Algorithm Confusion Attack]] [[Signature Verification Bypass]] [[Public Key Infrastructure]]