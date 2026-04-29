# Controller facade

## What it is
Like a hotel concierge who appears to handle your requests personally but actually just routes them to housekeeping, maintenance, or room service behind the scenes — a controller facade is a simplified interface that sits in front of multiple subsystems, accepting requests and delegating them without exposing the underlying complexity. In web application architecture, it is a single entry-point controller (often a Front Controller) that intercepts all incoming requests before routing them to appropriate handlers or services.

## Why it matters
Attackers targeting a poorly implemented controller facade can exploit improper input validation at the routing layer to achieve insecure direct object references (IDOR) or path traversal attacks — if the facade trusts user-supplied routing parameters without sanitizing them, an attacker can redirect requests to restricted subsystems. Conversely, a well-hardened facade centralizes authentication and authorization checks, meaning security controls only need to be enforced in one place rather than scattered across dozens of handlers.

## Key facts
- A controller facade acts as a **centralized choke point** — ideal for logging, rate limiting, and enforcing authentication before requests reach backend logic
- **Misconfigured facades** are a common source of broken access control (OWASP Top 10 #1), where routing logic can be manipulated to bypass authorization
- In MVC frameworks (Django, Spring, ASP.NET), the Front Controller pattern *is* the controller facade — all HTTP requests pass through a single dispatcher
- **Attack surface reduction**: centralizing request handling reduces the number of exposed endpoints that individually require hardening
- Facade pattern vulnerabilities often appear in **API gateway misconfigurations**, where the gateway facade fails to strip internal headers attackers can spoof

## Related concepts
[[Front Controller Pattern]] [[Broken Access Control]] [[API Gateway Security]] [[Input Validation]] [[Defense in Depth]]