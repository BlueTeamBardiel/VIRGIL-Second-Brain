# Censys

## What it is
Like a tax assessor who catalogs every property in a city — its size, condition, and ownership — Censys continuously scans the entire IPv4 address space and catalogs every internet-exposed device, certificate, and service it finds. It is a search engine for internet-connected infrastructure, providing structured, queryable data about open ports, running services, TLS certificates, and device banners across billions of hosts.

## Why it matters
A red team conducting reconnaissance on a target organization can query Censys for all hosts presenting TLS certificates issued to `*.targetcorp.com`, instantly revealing forgotten subdomains, staging servers, and misconfigured cloud instances the security team didn't know were public-facing. Defensively, a SOC analyst can use Censys to audit their own attack surface and discover that an internal Elasticsearch instance is exposed to the internet before an attacker does.

## Key facts
- Censys indexes data from its own ZMap-based internet-wide scans, covering ports like 80, 443, 22, 25, and hundreds more
- Provides structured search queries (e.g., `services.tls.certificates.leaf_data.subject.organization = "Acme Corp"`) making it far more precise than simple banner grabbing
- Unlike Shodan, Censys emphasizes certificate transparency data integration, making it particularly powerful for subdomain enumeration and PKI analysis
- Operates as both a free web interface and a REST API, commonly used in OSINT workflows and automated attack surface management platforms
- Certificate data is sourced from CT logs (Certificate Transparency), meaning it passively captures infrastructure even before active scanning finds it

## Related concepts
[[Shodan]] [[OSINT]] [[Attack Surface Management]] [[Certificate Transparency]] [[Passive Reconnaissance]]