# HTTP server

## What it is
Think of it like a librarian who only speaks one language: you walk up, hand them a request slip (GET /index.html), and they hand back exactly what's on the shelf — or a polite "404, not found." An HTTP server is software that listens on a network port (typically TCP 80 or 443 for HTTPS) and responds to client requests using the Hypertext Transfer Protocol, serving files, APIs, or dynamically generated content. Common implementations include Apache, Nginx, and Microsoft IIS.

## Why it matters
In 2021, a misconfigured Apache HTTP server exposing its `/server-status` module allowed attackers to enumerate active connections, session tokens, and internal IP addresses — all without authentication. This reconnaissance data directly fed a lateral movement campaign. Hardening HTTP servers by disabling default modules, suppressing server version banners (`ServerTokens Prod`), and enforcing TLS is a foundational defensive control.

## Key facts
- HTTP operates over **TCP port 80**; HTTPS over **TCP port 443** using TLS to encrypt the session
- Server banners (e.g., `Server: Apache/2.4.51`) disclose version info — attackers use this for targeted CVE lookups
- **HTTP methods** like PUT and DELETE, if enabled, can allow unauthorized file uploads or deletions — a common misconfiguration
- HTTP **response codes** are security-relevant: `200` (OK), `301` (redirect), `403` (forbidden), `500` (server error indicating possible injection)
- Web Application Firewalls (WAFs) sit in front of HTTP servers to inspect and filter malicious requests before they reach the application layer

## Related concepts
[[TLS/SSL]] [[Web Application Firewall]] [[SQL Injection]] [[Banner Grabbing]] [[Directory Traversal]]