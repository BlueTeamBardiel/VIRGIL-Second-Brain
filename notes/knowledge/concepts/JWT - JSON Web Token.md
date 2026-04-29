# JWT - JSON Web Token

## What it is
Think of a JWT like a laminated casino chip: it's self-contained proof of your value, signed by the house, and anyone can verify it's real without calling headquarters. Precisely, a JWT is a compact, URL-safe token format that encodes claims (assertions about a user or session) as a Base64URL-encoded JSON object, cryptographically signed with either a symmetric (HMAC) or asymmetric (RSA/ECDSA) algorithm.

## Why it matters
In 2022, attackers exploited misconfigured JWT implementations by changing the token's header algorithm field from `RS256` to `none` — a well-known attack called the "algorithm confusion" or "alg:none" attack — causing servers to accept unsigned tokens as valid, granting arbitrary user impersonation. Proper JWT validation must explicitly reject the `none` algorithm and verify signatures against a pinned key, not whatever key the token itself suggests.

## Key facts
- A JWT has three Base64URL-encoded parts separated by dots: **Header.Payload.Signature** — the payload is *encoded*, not *encrypted*, meaning anyone can read it without the secret key
- The `alg:none` vulnerability and **algorithm confusion attacks** (e.g., tricking an RS256 server to use the public key as an HMAC secret) are top exam and real-world attack vectors
- JWTs are **stateless** — the server stores no session data, which improves scalability but makes token revocation difficult before expiration
- The `exp` claim defines token expiration; missing or distant expiration windows increase the blast radius of token theft
- JWTs are vulnerable to **brute-force attacks** if signed with weak HMAC secrets (tools like `hashcat` can crack them offline)

## Related concepts
[[OAuth 2.0]] [[Session Hijacking]] [[Public Key Infrastructure]] [[HMAC]] [[Broken Authentication]]