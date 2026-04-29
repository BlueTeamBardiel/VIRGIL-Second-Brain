# refresh token

## What it is
Think of a refresh token like a coat-check ticket: you hand it in to get back a fresh, short-lived access pass without proving your identity all over again. Precisely, a refresh token is a long-lived credential issued alongside a short-lived access token in OAuth 2.0 flows, used to obtain new access tokens when the old ones expire — without requiring the user to re-authenticate.

## Why it matters
In 2022, attackers compromising developer machines targeted stored refresh tokens in browser profiles and IDE credential caches, allowing persistent access to cloud APIs long after the original login session ended. Because refresh tokens can live for days or weeks, a single theft grants an attacker a durable foothold — even if the victim changes their password — unless the authorization server explicitly revokes the token.

## Key facts
- Refresh tokens are **not** sent to resource servers; they go only to the authorization server's token endpoint.
- Access tokens are intentionally short-lived (minutes to hours); refresh tokens may be valid for days, weeks, or indefinitely until revoked.
- **Token rotation** is a defense where each use of a refresh token invalidates it and issues a new one — reuse of an old token signals theft and can trigger revocation of the entire token family.
- Refresh tokens should be stored securely (e.g., encrypted storage, HttpOnly cookies) — never in `localStorage`, which is accessible to JavaScript and vulnerable to XSS.
- RFC 6749 defines refresh tokens; RFC 6819 and BCP 217 (OAuth 2.0 Security Best Current Practice) specify their threat model and mitigations.

## Related concepts
[[OAuth 2.0]] [[access token]] [[token revocation]] [[JSON Web Token (JWT)]] [[session hijacking]]