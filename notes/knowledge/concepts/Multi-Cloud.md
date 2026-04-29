# Multi-Cloud

## What it is
Like a restaurant that sources ingredients from multiple farms so a single drought can't kill the menu, multi-cloud is the practice of distributing workloads across two or more cloud providers (e.g., AWS + Azure + GCP) rather than depending on a single vendor. This strategy improves resilience, avoids vendor lock-in, and reduces the blast radius of provider-specific outages or breaches.

## Why it matters
In 2021, a major AWS us-east-1 outage took down Slack, Disney+, and thousands of other services simultaneously — organizations using multi-cloud with workload failover to Azure or GCP stayed operational. From a security standpoint, multi-cloud also limits an attacker's lateral movement: compromising credentials in one cloud environment doesn't automatically expose resources in a separately administered provider with different IAM policies and credential stores.

## Key facts
- **Expanded attack surface**: Each cloud provider introduces its own IAM model, APIs, and misconfigurations to monitor — security teams must master multiple control planes simultaneously.
- **Shared responsibility model applies per-provider**: Each vendor defines their own split of customer vs. provider responsibilities; a gap in one doesn't equal a gap in the other.
- **CSPM tools** (Cloud Security Posture Management) like Prisma Cloud or Wiz are essential for enforcing consistent policy across multi-cloud environments.
- **Data sovereignty complexity**: Distributing data across providers in different regions can create compliance conflicts with GDPR, HIPAA, or FedRAMP requirements.
- **Credential sprawl risk**: Service accounts, API keys, and federated identities multiply rapidly — poor secrets management across clouds is a leading cause of breaches in multi-cloud deployments.

## Related concepts
[[Cloud Security Posture Management]] [[Shared Responsibility Model]] [[Identity and Access Management]] [[Zero Trust Architecture]] [[Vendor Lock-in Risk]]