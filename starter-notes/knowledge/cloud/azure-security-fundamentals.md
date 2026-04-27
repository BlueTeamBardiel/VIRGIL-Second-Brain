# Azure Security Fundamentals

Azure employs a defense-in-depth security strategy with multiple layers of protection across physical datacenters, compute, storage, networking, applications, and identity. Security in the cloud is a shared responsibility between Microsoft and customers.

## Defense-in-Depth Approach

Azure's multilayered security architecture ensures that if one layer is compromised, additional layers continue protecting resources. The infrastructure is designed from the ground up to securely host millions of customers simultaneously.

## Built-in Platform Security

- **Network Protection**: [[Azure DDoS Protection]] automatically shields resources from distributed denial-of-service attacks
- **Encryption by Default**: Data encryption at rest enabled by default for [[Azure Storage]], [[SQL Database]], and other services
- **Identity Security**: [[Microsoft Entra ID]] provides secure authentication and authorization
- **Threat Detection**: Built-in monitoring for suspicious activities across Azure resources
- **Compliance**: Azure maintains the largest compliance portfolio in the industry

These foundational controls require no extra configuration for basic protection.

## Shared Responsibility Model

**Microsoft's Responsibility:**
- Secures underlying infrastructure (physical datacenters, hardware, network, host OS)

**Customer's Responsibility:**
- Secures data, applications, identities, and access management
- Configuration and customization of security controls

Responsibilities vary by deployment model ([[IaaS]], [[PaaS]], [[SaaS]]).

## Key Concepts

- Each workload has unique security requirements based on industry regulations, data sensitivity, and business needs
- Azure provides advanced security services for comprehensive protection
- See [[End-to-end security in Azure]] for detection and response capabilities
- See [[Azure infrastructure security]] for platform hardening details
- See [[Azure physical security]] for datacenter security information

## Tags

#azure #cloud-security #defense-in-depth #shared-responsibility #compliance

---
_Ingested: 2026-04-15 20:23 | Source: https://learn.microsoft.com/en-us/azure/security/fundamentals/overview_
