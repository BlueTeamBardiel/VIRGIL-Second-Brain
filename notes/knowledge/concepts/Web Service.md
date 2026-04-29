# Web Service

## What it is
Think of a web service like a restaurant's drive-through window — your car (application) doesn't need to go inside; it just speaks through a standardized slot and gets what it needs. A web service is a software component that exposes functionality over a network using standardized protocols (HTTP/HTTPS, SOAP, REST) so disparate applications can communicate regardless of platform or language.

## Why it matters
In 2021, attackers exploited the Accellion File Transfer Appliance — essentially a web service — by sending maliciously crafted SOAP requests that bypassed authentication and triggered SQL injection, compromising dozens of organizations including government agencies. This illustrates how insecure web service endpoints become high-value attack surfaces because they're intentionally internet-facing and often trusted by internal systems.

## Key facts
- **SOAP vs REST**: SOAP uses XML with strict schemas (harder to misuse but verbose); REST uses JSON/XML and is stateless — both require proper input validation and authentication controls.
- **WSDL (Web Services Description Language)** documents describe a SOAP service's operations and data types; an exposed WSDL file gives attackers a full attack map of available functions.
- **Common vulnerabilities**: XML injection, XXE (XML External Entity) attacks, broken object-level authorization (BOLA/IDOR), and insecure direct API exposure are top threats (per OWASP API Security Top 10).
- **Authentication mechanisms**: Web services commonly use API keys, OAuth 2.0 tokens, or mutual TLS (mTLS) — absence of these makes unauthenticated endpoints critical findings in assessments.
- **API gateways** act as the security enforcement layer for web services — handling rate limiting, authentication, and logging before requests reach backend systems.

## Related concepts
[[API Security]] [[XML External Entity (XXE)]] [[OWASP API Top 10]] [[OAuth 2.0]] [[Input Validation]]