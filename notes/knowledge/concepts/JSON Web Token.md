# JSON Web Token

## What it is
Think of a JWT like a laminated airport boarding pass: it contains your identity and permissions printed right on it, and anyone who trusts the issuer can verify it without calling back to a central database. Precisely, a JSON Web Token is a compact, URL-safe token format (RFC 7519) consisting of three Base64URL-encoded sections — Header, Payload, and Signature — separated by dots, used to transmit claims between parties in a cryptographically verifiable way.

## Why it matters
In 2015–2017, researchers discovered that many JWT libraries honored the `"alg": "none"` header value, meaning an attacker could strip the signature entirely, modify the payload to escalate privileges (e.g., changing `"role": "user"` to `"role": "admin"`), and the server would accept the forged token as valid. This algorithm confusion attack is a canonical example of why cryptographic agility without strict server-side algorithm enforcement is dangerous.

## Key facts
- JWTs have three parts: **Header** (algorithm + token type), **Payload** (claims like `sub`, `exp`, `iss`), and **Signature** — all Base64URL encoded and dot-separated
- JWTs can be signed (JWS) using symmetric HMAC-SHA256 or asymmetric RS256/ES256; they can also be encrypted (JWE), which is distinct from merely signed
- The `"alg": "none"` vulnerability and the **RS256-to-HS256 confusion attack** (tricking a server into using the public key as an HMAC secret) are both testable attack classes
- JWTs are **stateless** — the server holds no session; revoking a token before expiration requires a blocklist, which is a common architectural weakness
- The `exp` (expiration) claim is critical; tokens without it remain valid indefinitely if intercepted

## Related concepts
[[OAuth 2.0]] [[Bearer Token]] [[Public Key Infrastructure]] [[Session Hijacking]] [[Authentication vs Authorization]]