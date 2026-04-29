# fast-jwt

## What it is
Like a high-performance assembly line that stamps and verifies passport seals in milliseconds instead of minutes, fast-jwt is a Node.js library that encodes, signs, and verifies JSON Web Tokens (JWTs) with optimized speed and minimal overhead. It is a drop-in alternative to the popular `jsonwebtoken` library, designed to reduce cryptographic processing latency in high-throughput authentication pipelines.

## Why it matters
In a microservices architecture where every API call requires token validation, a slow JWT library creates a measurable bottleneck — attackers can exploit this by flooding endpoints with malformed tokens, amplifying latency into a denial-of-service condition. fast-jwt's caching of verification keys and decoded headers directly reduces this attack surface by cutting per-request CPU time. However, misconfigured fast-jwt instances that disable signature verification (setting `complete: false` carelessly) can silently accept unsigned or tampered tokens.

## Key facts
- fast-jwt supports RS256, ES256, HS256, and other standard algorithms defined in RFC 7518, making algorithm confusion attacks relevant if the library is not pinned to an explicit algorithm
- It implements a **decode cache** that stores parsed token components, which can introduce memory exhaustion risks if cache size limits are not configured in token-flood scenarios
- The `allowedJwt` and `allowedAud` options enforce audience and issuer validation — omitting these opens the door to **token substitution attacks** where a token from one service is replayed against another
- Unlike `jsonwebtoken`, fast-jwt uses **synchronous and asynchronous APIs separately**, reducing risk of accidentally blocking the event loop during high-volume verification
- Always specify `algorithms` explicitly; accepting the `alg: none` header is a known critical vulnerability (CVE-class) in JWT implementations

## Related concepts
[[JSON Web Token]] [[Algorithm Confusion Attack]] [[Token Replay Attack]] [[OAuth 2.0]] [[Denial of Service]]