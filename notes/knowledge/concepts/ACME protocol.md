# ACME protocol

## What it is
Think of ACME like an automated notary service for the internet: instead of manually proving you own a domain to a certificate authority, ACME lets your server prove it automatically. ACME (Automated Certificate Management Environment) is an open protocol that automates the issuance and renewal of SSL/TLS certificates by allowing servers to prove domain ownership through cryptographic challenges, eliminating manual certificate requests.

## Why it matters
Before ACME, expired certificates were a major attack surface—misconfigured manual renewal processes led to widespread outages and forced HTTPS downgrades. With ACME (used by Let's Encrypt), certificates renew automatically every 90 days with zero human intervention, making it practically impossible for an attacker to exploit expired certificate vulnerabilities at scale.

## Key facts
- Uses HTTP-01, DNS-01, and TLS-ALPN-01 challenges to prove domain ownership without human interaction
- Let's Encrypt is the dominant ACME server; it issues billions of certificates annually
- Certificates issued via ACME are limited to 90-day validity to force automation and reduce revocation risks
- ACME is defined in RFC 8555 and is completely open-source and patent-free
- Enables wildcard and multi-domain certificates through the same automated validation process

## Related concepts
[[Certificate Authority]] [[TLS/SSL]] [[Let's Encrypt]] [[DNS validation]] [[Certificate pinning]]