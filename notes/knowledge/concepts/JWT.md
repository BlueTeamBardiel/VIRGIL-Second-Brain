# JWT

## What it is
Think of a JWT like a laminated festival wristband: the venue stamps it once, and every beer stand can verify it's real without calling back to the box office. Technically, a JSON Web Token is a compact, URL-safe token format that encodes claims (user identity, roles, expiration) in three Base64url-encoded segments — header, payload, and signature — separated by dots.

## Why it matters
In 2015–2017, a critical vulnerability allowed attackers to set the JWT header's `alg` field to `"none"`, causing vulnerable servers to skip signature verification entirely and accept forged tokens — granting full authentication bypass. This "Algorithm Confusion" attack meant an attacker could modify their own JWT payload (e.g., changing `"role":"user"` to `"role":"admin"`), strip the signature, and the server would trust it as valid.

## Key facts
- **Three-part structure:** `Header.Payload.Signature` — each Base64url encoded, NOT encrypted by default; the payload is readable by anyone
- **Signing algorithms:** HS256 uses a shared secret (symmetric); RS256 uses a public/private key pair (asymmetric) — RS256 is preferred in distributed systems
- **`alg: none` attack:** Servers must explicitly reject tokens with `"alg":"none"`; never trust the algorithm specified in the token header
- **Stateless by design:** The server holds no session state — revocation is difficult; short expiration (`exp` claim) and token rotation are critical mitigations
- **Storage risk:** JWTs stored in `localStorage` are vulnerable to XSS; `HttpOnly` cookies provide better protection but introduce CSRF risk

## Related concepts
[[Authentication]] [[OAuth 2.0]] [[Session Hijacking]] [[Cross-Site Scripting (XSS)]] [[Cryptographic Signing]]