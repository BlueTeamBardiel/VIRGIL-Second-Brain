# stateless authentication

## What it is
Like a concert wristband that contains your ticket tier printed on it — the bouncer at each stage doesn't need to call headquarters, they just read the band. Stateless authentication is a mechanism where all identity and authorization data is embedded in a self-contained token (typically a signed JWT), so the server validates requests by checking the token's cryptographic signature rather than querying a session store. No server-side session memory is required between requests.

## Why it matters
In a horizontal-scaling web application, an attacker who steals a valid JWT can replay it from any location until expiration — because there is no central session registry to invalidate it. This is the core weakness exploited in token theft attacks: unlike cookie-based sessions, a stolen JWT cannot be silently revoked server-side without adding stateful infrastructure (like a token blocklist), which partially defeats the purpose.

## Key facts
- JWTs consist of three Base64URL-encoded parts: **Header.Payload.Signature** — tampering with the payload invalidates the signature
- The **"alg: none"** attack tricks vulnerable servers into accepting unsigned tokens; always validate the algorithm explicitly server-side
- Expiration (`exp` claim) is the primary revocation mechanism — short lifetimes (15 minutes) reduce the replay window
- Stateless tokens are horizontally scalable because no shared session store is needed across server instances
- Confidential data should never be stored in JWT payloads — they are encoded, not encrypted, and trivially decoded by anyone

## Related concepts
[[JSON Web Token (JWT)]] [[session hijacking]] [[token replay attack]] [[OAuth 2.0]] [[cryptographic signing]]