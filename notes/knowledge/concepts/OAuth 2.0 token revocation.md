# OAuth 2.0 token revocation

## What it is
Like a hotel key card that still opens your room even after you've checked out — unless the front desk explicitly deactivates it — OAuth tokens remain valid until they expire or are deliberately revoked. Token revocation (RFC 7009) is the mechanism that allows authorization servers or resource owners to invalidate access tokens or refresh tokens before their natural expiration time.

## Why it matters
When a user's account is compromised or an application is deauthorized, unexpired access tokens continue to grant attackers resource access until revocation is enforced. In the 2022 GitHub OAuth token theft (via Heroku/Travis-CI), stolen tokens remained valid for hours because third-party services weren't implementing revocation checks — demonstrating that expiration alone is insufficient protection.

## Key facts
- Revocation is performed by sending a POST request to the authorization server's revocation endpoint (`/revoke`) with the token and token type hint (`access_token` or `refresh_token`)
- Revoking a **refresh token** should cascade and invalidate all associated access tokens derived from it; revoking an access token does NOT necessarily revoke the refresh token
- Authorization servers are NOT required to support revocation (RFC 7009 is optional), meaning clients must not assume it exists
- Stateless JWTs are notoriously difficult to revoke because validity is self-contained — implementations must use blocklists or short expiration windows as compensating controls
- The revocation endpoint must require client authentication to prevent unauthorized token invalidation (denial-of-service against legitimate sessions)

## Related concepts
[[OAuth 2.0 authorization framework]] [[JSON Web Tokens (JWT)]] [[refresh token rotation]] [[token introspection]] [[session hijacking]]