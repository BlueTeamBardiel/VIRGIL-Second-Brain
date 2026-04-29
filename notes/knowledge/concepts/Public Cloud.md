# Public Cloud

## What it is
Think of a public cloud like a massive apartment complex — you rent your unit, but you share the building's plumbing, elevators, and walls with hundreds of other tenants you've never met. Precisely: a public cloud is an IT infrastructure model where computing resources (servers, storage, networking) are owned and operated by a third-party provider (AWS, Azure, GCP) and delivered over the internet to multiple organizations sharing the same underlying physical hardware through virtualization.

## Why it matters
In 2019, Capital One suffered a breach affecting 100 million customers when a misconfigured AWS WAF allowed an attacker to perform SSRF attacks and reach the EC2 metadata service, harvesting IAM credentials. This illustrates the core security tension in public cloud: the provider secures the infrastructure, but *you* are responsible for configuration — the Shared Responsibility Model defines exactly where that line sits.

## Key facts
- **Shared Responsibility Model**: The provider secures "of" the cloud (hardware, hypervisors, physical facilities); the customer secures "in" the cloud (data, access controls, OS patching, application config).
- **Multi-tenancy risk**: Hypervisor vulnerabilities (e.g., VM escape attacks) could theoretically allow one tenant to access another's data on the same physical host.
- **Key security controls**: Cloud Access Security Brokers (CASBs), IAM least-privilege policies, and encryption at rest/in transit are the primary defensive layers customers must own.
- **Elasticity creates attack surface**: Auto-scaling and ephemeral resources make traditional asset inventory and vulnerability scanning difficult — resources may exist for minutes.
- **Compliance scope**: Public clouds can be HIPAA/PCI-DSS compliant, but compliance is *inherited partially* — customers must still configure services correctly to maintain compliance posture.

## Related concepts
[[Shared Responsibility Model]] [[Cloud Access Security Broker]] [[Identity and Access Management]] [[Virtualization Security]] [[Data Sovereignty]]