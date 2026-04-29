# token introspection

## What it is
Like a bouncer calling the club manager to verify a VIP wristband instead of just eyeballing it, token introspection lets a resource server actively query the authorization server to validate an access token's current status. Defined in RFC 7662, it is a protocol endpoint (`/introspect`) where a protected resource sends a token and receives a JSON response declaring whether that token is active, who it belongs to, its scope, and when it expires.

## Why it matters
In 2022-style API attack chains, attackers who steal a leaked JWT from a log file can replay it anywhere the token's signature is never re-verified against a live source. Token introspection defeats this by allowing the resource server to discover in real time that a token has been revoked — for example, after a user logs out or an account is suspended — even if the token's cryptographic signature is still technically valid.

## Key facts
- The introspection endpoint returns `"active": true/false` as the critical field; all other claims are only meaningful when active is true.
- Only trusted resource servers (clients) should be permitted to call the introspect endpoint — unauthenticated access would leak user session metadata.
- Introspection solves the **revocation gap** inherent to self-contained tokens (JWTs) because short expiry alone cannot handle immediate account termination scenarios.
- Responses should **not** be cached aggressively; a stale "active: true" response defeats the entire revocation benefit.
- Introspection is a server-to-server call and adds latency — often traded against the security benefit using short-lived tokens plus introspection only on sensitive operations.

## Related concepts
[[OAuth 2.0]] [[JSON Web Token (JWT)]] [[token revocation]] [[access control]] [[API security]]