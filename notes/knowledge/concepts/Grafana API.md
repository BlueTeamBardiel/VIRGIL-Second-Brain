# Grafana API

## What it is
Think of Grafana as a control room full of dashboards showing every vital sign of your infrastructure — the API is the master key that lets anyone with credentials (or without them, if misconfigured) read those vitals, modify the displays, or plant false data. Precisely, the Grafana API is a RESTful HTTP interface that allows programmatic control over dashboards, data sources, users, alerts, and plugins in the Grafana observability platform. It authenticates via API keys, service accounts, or basic auth, and exposes sensitive infrastructure metadata through JSON responses.

## Why it matters
In 2021, CVE-2021-43798 revealed a path traversal vulnerability in Grafana's plugin system — unauthenticated attackers could query `/public/plugins/[plugin-name]/../../../` to read arbitrary files from the server, including `/etc/passwd` and Grafana's own `grafana.db` SQLite database containing hashed credentials and plaintext data source passwords. This made Grafana a high-value target in cloud environments where it connects directly to databases, Prometheus instances, and cloud provider APIs.

## Key facts
- **CVE-2021-43798** (CVSS 7.5): Unauthenticated path traversal affecting Grafana 8.0.0–8.3.0; patched in 8.3.1
- Default admin credentials (`admin:admin`) are commonly left unchanged in misconfigured deployments
- API keys in Grafana have three roles: **Viewer**, **Editor**, and **Admin** — leaked admin keys grant full platform control
- Grafana data source configurations often contain credentials for downstream systems (databases, Elasticsearch, AWS CloudWatch), making the API a pivot point into deeper infrastructure
- The `/api/datasources/proxy/` endpoint can be abused to proxy requests through Grafana to internal services, enabling SSRF attacks

## Related concepts
[[Server-Side Request Forgery (SSRF)]] [[Path Traversal]] [[API Key Management]] [[Credential Exposure]] [[CVE Exploitation]]