# JWT token authentication

## What it is
Think of a JWT like a laminated government ID: anyone can read what's printed on it, but the laminate (cryptographic signature) proves it hasn't been tampered with since the issuing authority created it. A JSON Web Token is a compact, self-contained token consisting of three Base64URL-encoded sections — header, payload, and signature — used to transmit verified identity claims between parties without querying a central database on every request.

## Why it matters
In 2022, attackers exploiting misconfigured JWT libraries used the `alg: none` attack — setting the algorithm field to "none" so the server skips signature verification entirely, accepting a forged token with elevated privileges. This bypass allowed full account takeover because the server trusted the token's *claims* without validating the *proof*, the same as accepting a photocopy of an ID as genuine.

## Key facts
- JWTs have three dot-separated parts: **Header** (algorithm type), **Payload** (claims like `sub`, `exp`, `role`), **Signature** (HMAC or RSA-signed hash of the first two parts)
- The payload is **Base64URL-encoded, not encrypted** — anyone intercepting the token can read the claims; use JWE (JSON Web Encryption) if confidentiality is needed
- Tokens should include an `exp` (expiration) claim; without it, a stolen token is valid indefinitely
- **HS256** uses a shared secret (symmetric); **RS256** uses a public/private key pair (asymmetric) — RS256 is preferred in distributed systems where multiple services verify tokens
- JWT tokens are **stateless** — the server holds no session record, making revocation difficult before expiration; implement a token blocklist for logout scenarios

## Related concepts
[[OAuth 2.0]] [[Session hijacking]] [[Public key infrastructure]] [[Bearer token attacks]] [[HMAC integrity]]