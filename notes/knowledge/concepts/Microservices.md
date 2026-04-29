# Microservices

## What it is
Think of a Swiss Army knife versus a toolbox full of specialized tools — microservices is the toolbox approach. Instead of one monolithic application handling everything, microservices architecture breaks an application into small, independently deployable services that each perform a specific function and communicate over APIs (typically HTTP/REST or message queues).

## Why it matters
In 2021, attackers targeting a financial services firm exploited a vulnerability in a single microservice handling authentication, then used that foothold to pivot laterally through internal APIs to reach payment processing services — demonstrating that poor inter-service access controls can turn a small breach into a catastrophic one. Defenders must apply Zero Trust principles *between* services, not just at the network perimeter, because the east-west traffic between microservices is a massive, often overlooked attack surface.

## Key facts
- Each microservice runs in its own container (commonly Docker/Kubernetes), meaning a compromised service can be isolated and restarted without taking down the entire application
- **API gateway** is the single entry point managing authentication, rate limiting, and routing — compromise it and you control access to all downstream services
- Microservices dramatically expand the attack surface: more APIs, more endpoints, more credentials, and more network paths to secure
- Secrets management (API keys, service tokens) becomes critical — hardcoded credentials in microservice configs are a top vulnerability vector
- Logging and monitoring are harder to implement because requests span multiple services; security teams need distributed tracing tools (like Jaeger or Zipkin) to correlate events across services

## Related concepts
[[API Security]] [[Zero Trust Architecture]] [[Container Security]] [[Lateral Movement]] [[Secrets Management]]