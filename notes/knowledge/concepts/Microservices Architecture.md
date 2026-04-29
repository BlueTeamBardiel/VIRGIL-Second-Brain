# Microservices Architecture

## What it is
Think of a Swiss Army knife vs. a toolbox: instead of one monolithic blade doing everything, you have specialized, independent tools you grab as needed. Microservices architecture decomposes an application into small, independently deployable services that communicate over APIs (typically HTTP/REST or message queues), each owning its own data and business logic.

## Why it matters
In the 2021 breach of a major financial platform, attackers compromised a single authentication microservice and leveraged its internal API trust relationships to pivot laterally — accessing payment, user-profile, and notification services without re-authenticating. This illustrates the **east-west traffic problem**: microservices create massive internal attack surfaces that perimeter firewalls never see, making service mesh security (mTLS, zero trust between services) critical.

## Key facts
- **Expanded attack surface**: each service endpoint (often hundreds) is a potential entry point; API gateways become critical chokepoints for authentication and rate-limiting
- **Container dependency**: microservices almost always run in containers (Docker/Kubernetes), meaning container escape vulnerabilities and misconfigured RBAC directly threaten the architecture
- **Blast radius reduction**: a well-segmented microservice breach is contained to that service's data scope — a direct security *advantage* over monoliths if properly isolated
- **Service-to-service authentication** is a common exam theme: credentials/tokens passed between services must be validated (OAuth 2.0, mTLS), not implicitly trusted
- **Logging complexity**: distributed tracing (e.g., OpenTelemetry) is required for forensics; a missing correlation ID can make incident reconstruction nearly impossible

## Related concepts
[[API Security]] [[Zero Trust Architecture]] [[Container Security]] [[Lateral Movement]] [[Service Mesh]]