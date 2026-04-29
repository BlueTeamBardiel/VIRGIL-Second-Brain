# Elastic Cloud Hosted

## What it is
Think of it as renting a pre-wired server room where Elastic (the company) handles the plumbing — power, hardware, and Elasticsearch cluster management — while you just pipe in your data. Elastic Cloud Hosted is a fully managed, cloud-based deployment of the Elastic Stack (Elasticsearch, Kibana, Logstash, Beats) offered directly by Elastic on AWS, GCP, or Azure infrastructure. You configure the cluster size and features; Elastic handles patching, scaling, and node failover.

## Why it matters
A SOC team investigating a ransomware incident can centralize logs from firewalls, endpoints, and Active Directory into Elastic Cloud Hosted within hours — no on-prem hardware provisioning required. The built-in Elastic SIEM capabilities let analysts run EQL (Event Query Language) detection rules against petabytes of ingested data, drastically reducing mean time to detect (MTTD). Conversely, a misconfigured Elasticsearch instance with no authentication exposed to the internet has historically led to mass data breaches affecting millions of records.

## Key facts
- Elastic Cloud Hosted runs on the Elastic Stack; Elasticsearch is the core distributed search and analytics engine that indexes log and event data
- Authentication is **not enabled by default** in older self-managed Elasticsearch deployments — a critical misconfiguration that Elastic Cloud Hosted mitigates by enforcing TLS and role-based access control (RBAC) out of the box
- Supports integration with SIEM use cases via Elastic Security, which includes pre-built detection rules mapped to the **MITRE ATT&CK framework**
- Data is encrypted at rest (AES-256) and in transit (TLS 1.2+), making it relevant to compliance frameworks like SOC 2, HIPAA, and PCI-DSS
- Snapshot and restore functionality provides automated backups to object storage (S3/GCS/Azure Blob), supporting recovery time objectives (RTO)

## Related concepts
[[SIEM]] [[Log Management]] [[Elasticsearch Security Misconfiguration]] [[MITRE ATT&CK]] [[Role-Based Access Control]]