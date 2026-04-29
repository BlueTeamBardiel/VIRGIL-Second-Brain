# authentication middleware

## What it is
Think of it as the bouncer standing between the velvet rope and the club floor — every request has to show ID before getting past, regardless of which door it came in. Authentication middleware is a software layer inserted into a web application's request-processing pipeline that intercepts every incoming request and verifies the caller's identity before the request reaches any protected resource or business logic.

## Why it matters
In 2021, attackers exploited misconfigured authentication middleware in several Spring Framework applications, bypassing JWT validation entirely by sending a token with the `alg: none` header — a flaw where the middleware accepted unsigned tokens as valid. This allowed full account takeover without knowing any credentials, illustrating that broken middleware logic is often more dangerous than a missing lock because it creates a false sense of security.

## Key facts
- Authentication middleware typically validates credentials (session tokens, JWTs, API keys, or OAuth bearer tokens) on **every request**, not just login.
- A common vulnerability is **middleware bypass**: sending requests to paths not covered by routing rules (e.g., `/API/v2/` vs `/api/v2/`) can skip authentication checks entirely due to case-sensitive path matching.
- JWT middleware must verify **signature**, **expiration (`exp`)**, and **algorithm** — accepting `alg: none` is a critical misconfiguration.
- Middleware operates in a **chain/pipeline**; the order matters — placing authorization before authentication creates logic flaws.
- In zero-trust architectures, authentication middleware enforces **continuous verification**, validating tokens on every request rather than trusting session state.

## Related concepts
[[JSON Web Tokens (JWT)]] [[session management]] [[OAuth 2.0]] [[access control]] [[API security]]