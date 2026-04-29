# API gateways

## What it is
Think of an API gateway like a hotel concierge who intercepts every guest request, checks their reservation, enforces house rules, and routes them to the right floor — guests never wander the building unsupervised. Precisely: an API gateway is a reverse proxy that sits between clients and backend services, centralizing authentication, rate limiting, logging, and traffic routing for all API calls. It acts as the single entry point through which all API traffic must pass.

## Why it matters
In 2019, attackers exploited Capital One's misconfigured WAF by abusing a Server-Side Request Forgery (SSRF) vulnerability to reach AWS metadata endpoints — a properly hardened API gateway enforcing strict egress rules and input validation could have blocked the lateral movement. API gateways are also the primary defense layer against enumeration attacks, where attackers probe endpoints to map backend architecture. By centralizing throttling and authentication, they prevent credential stuffing and rate-based abuse before requests ever hit application logic.

## Key facts
- API gateways enforce **rate limiting** (throttling) to mitigate DoS and brute-force attacks against API endpoints
- They provide **centralized authentication/authorization** — validating OAuth tokens, API keys, or JWTs before requests reach backend services
- A misconfigured gateway can introduce **broken object level authorization (BOLA/IDOR)** if it forwards requests without proper user-context validation
- They generate **centralized audit logs** critical for SIEM ingestion, anomaly detection, and incident response
- API gateways are distinct from WAFs but are often deployed **in tandem** — the gateway handles routing and auth; the WAF inspects payload content for injection attacks

## Related concepts
[[OAuth 2.0]] [[Rate Limiting]] [[Reverse Proxy]] [[Web Application Firewall]] [[Zero Trust Architecture]]