# Caddy

## What it is
Think of Caddy as the hotel concierge who automatically handles your HTTPS paperwork before you even check in — no manual certificate requests required. Caddy is an open-source, Go-based web server and reverse proxy that provisions and renews TLS certificates automatically via ACME/Let's Encrypt by default, making HTTPS the path of least resistance rather than an afterthought.

## Why it matters
In a red team engagement, an attacker staging a phishing site or C2 infrastructure can spin up a fully trusted HTTPS server in minutes using Caddy — giving their malicious site a valid TLS certificate that bypasses browser warnings and lulls victims into false trust. Defenders benefit equally: organizations can eliminate "certificate expired" outages (a common misconfiguration finding) by deploying Caddy as a reverse proxy that handles certificate lifecycle autonomously, shrinking the attack surface created by manual certificate mismanagement.

## Key facts
- **Automatic HTTPS by default**: Caddy uses the ACME protocol to obtain certificates from Let's Encrypt or ZeroSSL without manual intervention — a sharp contrast to Apache/Nginx which require manual `certbot` integration.
- **Written in Go**: Its memory-safe language base reduces a class of vulnerabilities (buffer overflows) common in C-based servers like Apache httpd.
- **Reverse proxy capability**: Caddy can terminate TLS and forward traffic to internal services, making it relevant in network segmentation and zero-trust architecture scenarios.
- **Configuration via Caddyfile or JSON API**: Its API-first design enables dynamic reconfiguration without service restarts, which matters for detecting unauthorized config changes.
- **ACME protocol**: Caddy's automatic certificate issuance relies on ACME (RFC 8555) — understanding this protocol is relevant for PKI and certificate management questions on CySA+.

## Related concepts
[[TLS/SSL Certificates]] [[Reverse Proxy]] [[ACME Protocol]] [[Let's Encrypt]] [[Public Key Infrastructure]]