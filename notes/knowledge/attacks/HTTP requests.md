# HTTP requests

## What it is
Think of an HTTP request like a formal letter you send to a library: it has a specific envelope format, a stated purpose (I want to *borrow* this book, not *return* one), and a precise address. Technically, an HTTP request is a structured client-to-server message specifying a method (GET, POST, PUT, DELETE, etc.), a target URL, headers, and optionally a body — all transmitted over TCP, typically on port 80 (HTTP) or 443 (HTTPS).

## Why it matters
SQL injection attacks are delivered directly inside HTTP requests — an attacker crafts a malicious POST body or GET query parameter like `?id=1' OR '1'='1` that the backend executes against a database. Web Application Firewalls (WAFs) work by inspecting every inbound HTTP request and blocking those matching known attack signatures before they reach the application server.

## Key facts
- **Methods matter for access control**: GET requests should be read-only; PUT/DELETE modify resources — misconfigured servers accepting unsafe methods expose dangerous attack surfaces (see HTTP verb tampering).
- **Headers carry security context**: `Authorization`, `Cookie`, `Content-Type`, and `Host` headers are frequent attack and defense targets; header injection can smuggle malicious directives.
- **HTTP request smuggling** exploits discrepancies between how front-end proxies and back-end servers parse `Content-Length` vs. `Transfer-Encoding` headers, bypassing security controls.
- **HTTPS encrypts the body and headers** but the destination IP and Server Name Indication (SNI) may still be visible to network observers.
- **Status codes in responses** (400, 401, 403, 500) help attackers fingerprint server behavior and guide further enumeration.

## Related concepts
[[SQL Injection]] [[Web Application Firewall]] [[HTTP Request Smuggling]] [[HTTPS and TLS]] [[OWASP Top 10]]