# Prometheus

## What it is
Like a gas station's pump meters that constantly report gallons dispensed, pressure, and temperature back to a central dashboard, Prometheus is an open-source time-series monitoring and alerting toolkit that scrapes numeric metrics from instrumented targets at defined intervals. It stores these metrics locally and provides a query language (PromQL) to evaluate and alert on threshold violations.

## Why it matters
In a 2023-era attack scenario, a misconfigured Prometheus `/metrics` endpoint exposed without authentication allowed attackers to enumerate internal service names, IP addresses, request rates, and error patterns — essentially handing adversaries a live network topology map. Defenders use Prometheus with Grafana dashboards to detect anomalies like sudden spikes in failed authentication attempts, enabling real-time incident response.

## Key facts
- **Default port is 9090**; the metrics scrape endpoint (`/metrics`) is commonly exposed on port 9100 (Node Exporter) — both are frequent targets in cloud misconfiguration scans
- **Unauthenticated by default** in many deployments; Prometheus itself had no built-in authentication/TLS until recent versions, requiring a reverse proxy (e.g., nginx) for access control
- **Pull-based model**: Prometheus scrapes targets rather than targets pushing data, meaning firewall rules must allow inbound connections from the Prometheus server
- **Alertmanager** is the companion component that routes alerts to PagerDuty, Slack, or email — a high-value target if attackers want to suppress security notifications
- Exposed Prometheus instances have been weaponized for **internal network reconnaissance**, since scrape configs often list every monitored host and service in the environment

## Related concepts
[[Security Misconfiguration]] [[Metrics Exposure]] [[Grafana]] [[Network Reconnaissance]] [[Authentication Bypass]]