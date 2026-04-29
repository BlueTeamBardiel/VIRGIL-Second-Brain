# Tokens

## What it is
Like a casino chip that proves you already exchanged real money at the cage, a token is a temporary credential that proves authentication already happened — without carrying the original secret. Technically, a token is a cryptographically signed or random string issued after successful authentication, used to authorize subsequent requests in place of a password.

## Why it matters
In a 2022-style session hijacking attack, an adversary who steals a valid JWT (JSON Web Token) from a browser's localStorage via XSS can replay it against an API to impersonate the victim indefinitely — because the server trusts the token's signature, not the user's identity at that moment. Proper token design (short expiry, binding tokens to IP or device fingerprint, and using HttpOnly cookies instead of localStorage) dramatically shrinks this attack window.

## Key facts
- **JWT structure**: three Base64URL-encoded segments — Header (algorithm), Payload (claims), Signature — separated by dots. The signature validates integrity but does NOT encrypt the payload.
- **"alg: none" vulnerability**: Attackers can modify a JWT header to specify no algorithm, tricking poorly implemented libraries into accepting unsigned tokens as valid.
- **Token types**: Access tokens are short-lived (minutes); Refresh tokens are long-lived (days/weeks) and used only to obtain new access tokens — separating risk exposure.
- **OAuth 2.0 bearer tokens**: Defined in RFC 6750; possession alone grants access ("bearer" = whoever holds it), making transmission security (TLS) critical.
- **Token revocation problem**: Unlike sessions stored server-side, stateless JWTs cannot be invalidated before expiry without maintaining a deny-list — a key trade-off on Security+ exams.

## Related concepts
[[OAuth 2.0]] [[Session Hijacking]] [[JSON Web Token (JWT)]] [[Cross-Site Scripting (XSS)]] [[Multi-Factor Authentication]]