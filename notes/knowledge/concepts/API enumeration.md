# API enumeration

## What it is
Like a thief who tests every door and window of a building before deciding which one to pick, API enumeration is the process of systematically probing an API to map its endpoints, parameters, methods, and data structures. An attacker sends crafted requests to discover hidden or undocumented functionality that developers never intended to expose publicly.

## Why it matters
In 2019, attackers exploited Facebook's poorly documented API endpoints to scrape phone numbers and user IDs for over 533 million accounts — data that surfaced publicly in 2021. Had proper rate limiting and endpoint access controls been enforced, automated enumeration tools like Burp Suite or ffuf would have been throttled before completing the harvest.

## Key facts
- **OWASP API Security Top 10** explicitly lists "Broken Object Level Authorization" (BOLA/IDOR) and "Excessive Data Exposure" — both commonly discovered through enumeration
- Attackers use tools like **Postman, ffuf, Arjun, and kiterunner** to fuzz endpoints and discover hidden parameters
- **Swagger/OpenAPI specification files** left publicly accessible (e.g., `/swagger.json`, `/api-docs`) hand attackers a complete map of all endpoints for free
- HTTP response codes during enumeration are informative: **200 = exists**, **401/403 = exists but restricted**, **404 = not found** — attackers tune attacks based on these signals
- **Mitigation** includes rate limiting, API gateways with authentication enforcement, removing spec files from production, and monitoring for abnormal request patterns (many 404s in sequence)

## Related concepts
[[IDOR (Insecure Direct Object Reference)]] [[fuzzing]] [[OWASP API Security Top 10]] [[rate limiting]] [[reconnaissance]]