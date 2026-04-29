# API Gateway

## What it is
Think of it as a bouncer at a nightclub who checks IDs, enforces the guest list, and keeps a log of everyone who enters — except instead of people, it's API requests. An API Gateway is a single entry point that sits between clients and backend services, handling authentication, rate limiting, request routing, and logging for all API traffic. It centralizes enforcement of security policies rather than baking them into each individual service.

## Why it matters
In 2019, attackers exploited a misconfigured API at Capital One by abusing an SSRF vulnerability in a WAF sitting in front of AWS metadata services — a scenario API Gateways are specifically positioned to mitigate by blocking abnormal request patterns and restricting internal routing. Properly configured, an API Gateway can enforce authentication on every endpoint, preventing unauthenticated access to sensitive data that developers forgot to protect. Without one, each microservice must independently implement security controls, dramatically increasing the attack surface.

## Key facts
- API Gateways enforce **rate limiting** to prevent brute-force and credential stuffing attacks against authentication endpoints
- They can terminate **TLS** centrally, ensuring all backend communication uses encrypted channels without requiring each service to manage certificates
- **JWT validation** and OAuth token inspection are commonly offloaded to the gateway, preventing unauthorized API calls from reaching backend services
- Gateways provide centralized **audit logging**, which is critical for SIEM ingestion and detecting anomalous API usage patterns
- Misconfigured gateways that allow **HTTP verb tampering** (e.g., using PUT instead of GET) can bypass access controls — a common CySA+ exam scenario

## Related concepts
[[OAuth]] [[JWT]] [[Rate Limiting]] [[Zero Trust Architecture]] [[WAF]]