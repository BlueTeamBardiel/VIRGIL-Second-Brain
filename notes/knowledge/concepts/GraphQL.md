# GraphQL

## What it is
Like a restaurant where instead of ordering from a fixed menu (REST), you hand the chef a custom list of exactly what ingredients you want — GraphQL is a query language for APIs that lets clients specify precisely what data they need in a single request. It replaces multiple rigid REST endpoints with one flexible endpoint where the client controls the shape and depth of the response.

## Why it matters
In 2019, attackers exploited GitLab's GraphQL endpoint by sending unauthenticated introspection queries, mapping the entire API schema — every object, field, and relationship — before harvesting private user email addresses at scale. Introspection, a built-in GraphQL feature that documents the API to developers, becomes a reconnaissance goldmine when left enabled in production environments.

## Key facts
- **Introspection attacks**: The `__schema` and `__type` queries reveal the full API structure; disabling introspection in production is a baseline hardening step
- **Single endpoint vulnerability**: All queries hit one URL (typically `/graphql`), making traditional URL-based WAF rules and rate limiting ineffective without query-aware inspection
- **Batching attacks**: GraphQL allows multiple operations in one HTTP request, enabling credential-stuffing or brute-force attacks that bypass per-request rate limiters
- **Excessive data exposure**: Misconfigured resolvers may return sensitive fields (e.g., password hashes, tokens) even if the client didn't explicitly request them — a top OWASP API Security risk
- **DoS via deeply nested queries**: Without query depth/complexity limits, attackers can craft exponentially expensive nested queries (`user → friends → friends → friends...`) to exhaust server resources

## Related concepts
[[API Security]] [[Injection Attacks]] [[Reconnaissance]] [[Rate Limiting]] [[OWASP API Top 10]]