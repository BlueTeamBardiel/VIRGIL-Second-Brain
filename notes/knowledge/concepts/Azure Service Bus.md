# Azure Service Bus

## What it is
Think of it as a post office for cloud applications — messages get dropped into queues or topics, and recipients pick them up on their own schedule, even if the sender is offline. Azure Service Bus is a fully managed enterprise message broker that enables asynchronous, reliable communication between distributed applications using queues (point-to-point) and topics (publish/subscribe patterns). It decouples producers and consumers so neither needs to be available simultaneously.

## Why it matters
In a supply chain attack scenario, a compromised application writing malicious payloads to a Service Bus queue can silently poison downstream microservices that trust and process those messages without validation. Defenders must implement message-level authentication using Shared Access Signatures (SAS) or Azure Active Directory RBAC, and apply input validation on all consumed messages to prevent injection or deserialization attacks propagating through the pipeline.

## Key facts
- **Authentication options**: Shared Access Signatures (SAS tokens) grant scoped, time-limited access; Azure AD with RBAC is the preferred zero-trust approach
- **Encryption**: Data is encrypted at rest (AES-256) and in transit (TLS 1.2+); customer-managed keys (CMK) via Azure Key Vault are supported
- **Network isolation**: Private Endpoints and Virtual Network service endpoints restrict Service Bus access to specific VNets, reducing public attack surface
- **Dead-letter queue (DLQ)**: Messages that fail processing or exceed delivery counts are moved to the DLQ — attackers may exploit misconfigured DLQ retention to exfiltrate sensitive data
- **Threat model concern**: Overly permissive SAS policies (e.g., RootManageSharedAccessKey with full namespace access) violate least privilege and are a common misconfiguration finding in cloud security audits

## Related concepts
[[Shared Access Signatures]] [[Azure Active Directory RBAC]] [[Message Queue Security]] [[Zero Trust Architecture]] [[Cloud Storage Encryption]]