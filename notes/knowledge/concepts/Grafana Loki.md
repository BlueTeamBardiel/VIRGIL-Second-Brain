# Grafana Loki

## What it is
Think of Loki as a librarian who doesn't read every book but instead catalogues only the spine labels — it indexes log *metadata* (labels like host, app, environment) rather than the full log content, making storage cheap and queries fast. Grafana Loki is a horizontally scalable, open-source log aggregation system designed to collect, store, and query logs from distributed infrastructure without requiring full-text indexing of log bodies.

## Why it matters
During a cloud breach investigation, a SOC analyst can use Loki alongside Grafana dashboards to correlate authentication failures across hundreds of Kubernetes pods in near real-time — querying logs by label (`{app="nginx", env="prod"}`) to isolate the compromised service within minutes rather than hours. Without centralized log aggregation like Loki, attackers who pivot laterally and delete local logs on individual nodes can erase their trail entirely, making forensic reconstruction impossible.

## Key facts
- Loki uses **LogQL** as its query language — syntactically similar to PromQL, allowing log filtering and metric extraction from log streams
- Unlike Elasticsearch (ELK stack), Loki **does not index log content by default**, reducing storage costs by 10x but requiring exact label matching for efficient queries
- Loki integrates natively with **Promtail** (the log shipping agent) and **Grafana** (visualization), forming the PLG stack (Promtail-Loki-Grafana)
- Log streams are identified by **label sets** (key-value pairs); high-cardinality labels (e.g., unique user IDs) can cause serious performance degradation — a common misconfiguration
- Loki supports **alerting rules** via the ruler component, enabling automated detection of patterns like repeated `403` errors or privilege escalation attempts in logs

## Related concepts
[[SIEM]] [[Log Management]] [[Security Monitoring]] [[Kubernetes Security]] [[Threat Hunting]]