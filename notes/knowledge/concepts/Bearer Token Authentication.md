# Bearer Token Authentication

## What it is
Like a movie ticket stub — whoever holds it gets in, no questions asked about how they got it. Bearer token authentication is an HTTP authentication scheme where possession of a token alone grants access to protected resources, with no cryptographic proof of identity required from the holder.

## Why it matters
In 2022, attackers targeting OAuth-based APIs routinely intercepted bearer tokens from insecure mobile apps transmitting over HTTP, then replayed them to impersonate legitimate users — no password needed. Defenders mitigate this by enforcing TLS everywhere, setting short token expiration windows, and binding tokens to specific IP ranges or device fingerprints.

## Key facts
- Bearer tokens are defined in **RFC 6750** as part of the OAuth 2.0 framework; the Authorization header format is `Authorization: Bearer <token>`
- They are **possession-based only** — unlike HMAC-signed tokens, the server doesn't verify the requester's identity, just that the token is valid
- Tokens must be transmitted over **TLS/HTTPS exclusively**; sending over plaintext HTTP exposes them to trivial interception
- **Token theft = account takeover**: since there's no second factor in the bearer model, a stolen token grants full access until expiration or revocation
- JWT (JSON Web Token) is the most common format used as a bearer token, embedding claims directly in a Base64-encoded, signed payload

## Related concepts
[[OAuth 2.0]] [[JSON Web Token (JWT)]] [[Session Hijacking]] [[Transport Layer Security (TLS)]] [[Token Replay Attack]]