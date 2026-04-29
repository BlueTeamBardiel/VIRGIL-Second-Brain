# middleware

## What it is
Think of middleware as the universal translator in a diplomatic meeting — it sits between two parties who speak different languages and brokers all communication between them. Precisely, middleware is software that connects application components, services, or systems, handling requests, authentication, logging, and data transformation between a client and a backend server. It operates in the processing pipeline *between* receiving a request and generating a response.

## Why it matters
Middleware is a prime attack surface because it processes *every* request before business logic does — a vulnerability here compromises the entire application stack. In the 2021 Log4Shell vulnerability, the Log4j logging middleware was exploited via crafted JNDI strings in HTTP headers, allowing remote code execution on millions of servers. Defenders use middleware for positive security too: WAF middleware can inspect and strip malicious payloads before they ever reach application code.

## Key facts
- Middleware vulnerabilities can include **injection flaws, insecure deserialization, and authentication bypass** — all OWASP Top 10 staples
- **Insecure deserialization** frequently occurs in middleware layers (e.g., Apache Struts, Java RMI) where serialized objects are processed without validation
- Middleware often runs with **elevated privileges**, meaning a compromise can escalate to full system access
- **API gateways** are a form of middleware that enforce rate limiting, authentication (OAuth/JWT), and logging for microservices architectures
- Misconfigured middleware (e.g., exposed admin consoles on Apache Tomcat port 8080) is a common finding in penetration tests and CySA+ scenario questions

## Related concepts
[[injection attacks]] [[insecure deserialization]] [[API security]] [[WAF]] [[supply chain attacks]]