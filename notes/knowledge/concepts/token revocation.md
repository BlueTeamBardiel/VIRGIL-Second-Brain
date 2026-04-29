# token revocation

## What it is
Like canceling a stolen hotel key card mid-stay — the lock doesn't wait for check-out day, it just stops accepting that card immediately. Token revocation is the process of invalidating an authentication or authorization token before its natural expiration, rendering it unusable even if the token itself is still technically valid and unexpired.

## Why it matters
When a privileged employee is terminated, their OAuth access tokens or session tokens may still be valid for hours or days if revocation isn't enforced. An attacker — or the former employee — can exploit this window to exfiltrate data or maintain persistence long after account deprovisioning. Proper revocation infrastructure (like OAuth 2.0 token introspection endpoints) closes this gap by checking token validity in real time against a server-side blocklist.

## Key facts
- **JWT (JSON Web Tokens) are stateless by design**, making revocation difficult — there's no built-in server-side state to invalidate, requiring workarounds like blocklists or short expiry windows
- **OAuth 2.0 defines token revocation in RFC 7009**, which specifies a dedicated `/revoke` endpoint that invalidates both access tokens and refresh tokens
- **Refresh tokens are higher-value revocation targets** — revoking a refresh token prevents the issuance of new access tokens, even if the current access token is still live
- **Token introspection (RFC 7662)** allows resource servers to query the authorization server in real time to confirm a token is still active — the primary mechanism for enforcing revocation
- **Short-lived tokens reduce revocation urgency** — a 5-minute access token expiry minimizes the blast radius of a compromised token without requiring complex revocation infrastructure

## Related concepts
[[JSON Web Tokens (JWT)]] [[OAuth 2.0]] [[session management]] [[access control]] [[identity and access management (IAM)]]