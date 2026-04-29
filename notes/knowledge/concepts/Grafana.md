# Grafana

## What it is
Think of Grafana as the cockpit dashboard of a 747 — it doesn't fly the plane, but it displays every critical instrument reading in one visual panel. Precisely, Grafana is an open-source data visualization and monitoring platform that connects to time-series databases (like Prometheus, InfluxDB, or Elasticsearch) to render metrics, logs, and alerts as interactive dashboards. It is widely used for infrastructure monitoring, application performance, and increasingly, security operations.

## Why it matters
In 2021, a critical path traversal vulnerability (CVE-2021-43798) allowed unauthenticated attackers to read arbitrary files on the server by crafting malicious plugin URLs — exposing secrets like database credentials and private keys. This made publicly exposed Grafana instances high-value targets, demonstrating that monitoring tools themselves expand the attack surface. Defenders use Grafana to build SOC dashboards aggregating SIEM data, visualizing failed login spikes, or tracking anomalous network throughput in near real-time.

## Key facts
- **CVE-2021-43798**: A directory traversal flaw in Grafana versions 8.0.0–8.3.0 allowed unauthenticated file reads; affected thousands of internet-facing instances
- **Default credentials risk**: Older Grafana deployments ship with `admin/admin` default credentials, making them trivial targets in credential-stuffing attacks
- **Plugin architecture**: Grafana's plugin system extends functionality but also introduces third-party code risk — each plugin is a potential supply chain attack vector
- **Data source integration**: Grafana does not store metrics itself; it queries backends (Prometheus, Loki, Splunk), meaning compromised Grafana = potential pivot to backend data stores
- **RBAC controls**: Grafana supports role-based access control (Viewer, Editor, Admin) — misconfigured permissions can expose sensitive operational dashboards publicly

## Related concepts
[[SIEM]] [[Prometheus]] [[Directory Traversal]] [[Default Credentials]] [[Supply Chain Attack]]