# Elastic Cloud Serverless

## What it is
Like renting a self-driving taxi instead of owning a car — you describe your destination (your workload), and the platform handles routing, fuel, and maintenance invisibly. Elastic Cloud Serverless is Elastic's fully managed deployment model where users provision Elasticsearch, Kibana, and related security tools without managing underlying infrastructure, scaling, or cluster operations. Resource allocation adjusts automatically based on demand, and users pay per workload consumed rather than per reserved capacity.

## Why it matters
A SOC team using Elastic Cloud Serverless for SIEM ingestion during a ransomware incident benefits from automatic scaling — log volume can spike 10x during active attacks without the analyst manually provisioning nodes or worrying about pipeline backpressure. Conversely, the shared-responsibility model means the organization must still secure data access, API keys, and role-based permissions, since Elastic manages the infrastructure but *not* your data governance decisions.

## Key facts
- **Shared responsibility boundary**: Elastic owns infrastructure patching, availability, and scaling; the customer owns data classification, access control (RBAC), and API key lifecycle management.
- **Three core serverless project types**: Elasticsearch (search/analytics), Observability (APM, logs, metrics), and Security (SIEM, endpoint detection) — each is purpose-scoped, not a generic cluster.
- **No cluster management**: Users cannot SSH into nodes or tune JVM heap — attack surface from misconfigured cluster settings is reduced but visibility into infrastructure layer is also eliminated.
- **Data encryption at rest and in transit** is enabled by default; however, customer-managed encryption keys (BYOK) require specific tier configurations.
- **Audit logging of API activity** must be explicitly enabled and routed — it does not automatically feed your SIEM without configuration, a common compliance gap.

## Related concepts
[[SIEM Architecture]] [[Cloud Shared Responsibility Model]] [[Role-Based Access Control]] [[API Key Management]] [[Log Ingestion Pipelines]]