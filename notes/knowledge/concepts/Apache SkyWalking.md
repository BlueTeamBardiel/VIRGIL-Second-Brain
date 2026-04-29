# Apache SkyWalking

## What it is
Like a flight data recorder embedded in every microservice conversation, Apache SkyWalking is an open-source Application Performance Monitoring (APM) and observability platform that traces distributed transactions across microservices, collects metrics, and visualizes service dependencies. It instruments backend services to provide end-to-end request tracing without requiring code changes.

## Why it matters
In 2020, CVE-2020-9483 revealed a critical SQL injection vulnerability in SkyWalking's GraphQL query endpoint, allowing unauthenticated attackers to dump the entire backend database — including credentials and topology data — with a single malformed request. Because SkyWalking deployments often sit on internal networks assumed to be "safe," organizations frequently left it unpatched and internet-exposed, making it a prime pivot point for attackers who breached perimeter defenses.

## Key facts
- **CVE-2020-9483** (CVSS 9.8): Unauthenticated SQL injection in SkyWalking UI prior to version 8.3.0; exploitation requires only HTTP access to the web interface.
- SkyWalking uses **H2, MySQL, or Elasticsearch** as its backend storage; successful SQL injection can exfiltrate all stored trace data, service credentials, and topology maps.
- Default installations expose the **UI on port 8080** with no authentication enabled, violating the principle of least privilege.
- As an APM tool, it collects **distributed traces using OpenTracing/OpenTelemetry standards**, making it a high-value intelligence target — an attacker reading trace data can reconstruct internal API structures and authentication flows.
- Remediation requires upgrading to 8.3.0+, placing the UI behind an **authenticated reverse proxy**, and applying network segmentation so SkyWalking is not reachable from untrusted zones.

## Related concepts
[[SQL Injection]] [[CVE Vulnerability Scoring]] [[Principle of Least Privilege]] [[Network Segmentation]] [[Distributed Tracing]]