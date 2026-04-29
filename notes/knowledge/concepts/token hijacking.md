# token hijacking

## What it is
Imagine stealing someone's hotel keycard after they've already checked in — you skip the front desk entirely and walk straight to their room. Token hijacking works the same way: an attacker steals a session token or authentication token (JWT, OAuth bearer token, cookie) that was already issued to a legitimate user, then uses it to impersonate that user without ever needing their password.

## Why it matters
In 2022, attackers targeting Okta stole session tokens from a support engineer's machine, allowing lateral movement through customer environments without triggering password-based alerts. Defenders counter this by binding tokens to device fingerprints or IP addresses and enforcing short token lifetimes with mandatory refresh cycles.

## Key facts
- **Tokens replace credentials** after initial login — stealing one grants access for its entire validity window, bypassing MFA entirely
- **Common theft vectors**: XSS (injecting scripts to read `document.cookie`), man-in-the-middle on unencrypted connections, and malware reading browser memory or disk storage
- **JWTs are stateless** — a server cannot invalidate a stolen JWT before expiration unless it maintains a blocklist, making short expiration (≤15 minutes) critical
- **SameSite cookie attribute** (`Strict` or `Lax`) reduces CSRF-style token abuse by blocking cross-origin requests from sending cookies automatically
- **Pass-the-token** is the network equivalent of pass-the-hash: the raw token string is replayed directly in an Authorization header without any cracking required

## Related concepts
[[session hijacking]] [[cross-site scripting (XSS)]] [[JSON Web Token (JWT)]] [[OAuth 2.0]] [[man-in-the-middle attack]]