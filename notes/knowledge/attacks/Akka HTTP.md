# Akka HTTP

## What it is
Like a postal sorting office built on a conveyor belt system — messages flow through actors asynchronously rather than waiting in a single line — Akka HTTP is a toolkit built on the Akka actor model that provides fully asynchronous, non-blocking HTTP server and client capabilities for JVM applications. It is not a full framework but a library, giving developers fine-grained control over request/response pipelines in Scala or Java.

## Why it matters
In a penetration test against a microservices backend, an attacker may probe Akka HTTP endpoints for insecure route configurations that expose administrative APIs without authentication — a real pattern seen in misconfigured reactive service architectures. Because Akka HTTP uses Directives to compose routing logic, a missing `authenticate` directive silently opens protected resources, making code review and route auditing a critical defensive step.

## Key facts
- Akka HTTP runs on top of **Akka Streams**, meaning request processing is backpressure-aware — this mitigates certain volumetric DoS conditions but does not replace rate limiting controls.
- Default **HTTPS/TLS** must be explicitly configured via `SSLContext`; it does not enable TLS out of the box, a common misconfiguration vector.
- **Directive composition** (e.g., `path`, `get`, `authenticate`) controls access — missing or incorrectly ordered directives are a leading source of broken access control vulnerabilities (OWASP A01).
- Akka HTTP supports **WebSocket upgrades**, expanding the attack surface to include WebSocket-specific threats like cross-site WebSocket hijacking (CSWSH).
- Because it is **non-blocking and actor-based**, traditional thread-exhaustion attacks are less effective, but logic bugs in actor message handling can cause cascading failures.

## Related concepts
[[Broken Access Control]] [[TLS Configuration]] [[WebSocket Security]] [[Microservices Security]] [[Rate Limiting]]