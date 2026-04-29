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

## What Is Azure Security Fundamentals? (Feynman Version)

Imagine a city built on a network of fences, locks, guards, and watchtowers. Azure Security Fundamentals is the blueprint that tells each fence where to stand, which lock to use, which guard to hire, and how the watchtowers relay alerts. In plain English, it’s the collection of policies, controls, and services that Microsoft places around and inside every Azure resource to keep it safe from the outside world and from itself.

## Why Does Azure Security Fundamentals Exist?

Before cloud platforms, each company had to buy firewalls, encrypt data, and monitor for intrusions independently. That siloed approach meant gaps: one team might forget to patch a VM, another might misconfigure a storage account, and a third might lose track of which users had what permissions. Azure Security Fundamentals arose to solve that chaos by giving every customer a consistent, built‑in shield that covers physical, network, compute, storage, identity, and compliance layers. It eliminates the “who owns the fence” confusion and turns security from a patchwork into a single, auditable process.

## How It Works (Under The Hood)

1. **Resource creation** – When a user spins up a VM, Azure Resource Manager (ARM) automatically applies default network security groups (NSGs) and virtual network (VNet) isolation, ensuring traffic can only flow to allowed endpoints.
2. **Encryption** – ARM provisions Azure Disk Encryption keys stored in [[Azure Key Vault]] and turns on Transparent Data Encryption (TDE) for SQL Database, so every byte on disk is encrypted before writing to the storage medium.
3. **Identity** – ARM registers the resource with [[Microsoft Entra ID]], assigns a managed identity, and enforces role‑based access control (RBAC) so only explicitly granted users can interact with the resource.
4. **Threat detection** – Azure Security Center (now part of the Azure Defender suite) ingests logs via Azure Monitor, runs analytics against known threat patterns, and produces alerts or auto‑remediations (e.g., tightening NSG rules).
5. **Compliance** – Azure automatically tags resources with industry standard controls (ISO, SOC, HIPAA), and Security Center checks the configuration against those controls, flagging any deviations.
6. **Continuous monitoring** – All telemetry (network packets, VM performance, identity changes) flows into Azure Sentinel (or a third‑party SIEM), where it can be correlated with threat intelligence feeds and orchestrated into response playbooks.

Every step follows a well‑defined protocol: HTTPS for API calls, Kerberos/NTLM for identity, TLS for data in transit, and AES‑256 for data at rest. The entire flow is governed by policies that can be overridden only by explicit user action.

## What Breaks When It Goes Wrong?

When Azure Security Fundamentals is misconfigured or disabled, the city’s fences can collapse in three common ways:

- **Public data exposure** – If an Azure Storage account’s “allow anonymous read” flag is left enabled, attackers can download customer data with a simple HTTP request. The fallout can be immediate loss of sensitive information, legal penalties, and brand damage.
- **Privilege creep** – A misapplied RBAC role may grant developers administrative rights on production databases. Those extra permissions can lead to accidental data deletion or intentional sabotage, costing hours of recovery and potentially violating compliance.
- **Unpatched VMs** – If the automatic update policy is turned off, a single unpatched VM can become a pivot point, enabling lateral movement across the VNet. The ripple effect may bring down multiple services, causing outages that affect millions of users.

In each scenario, the first notice usually comes from a monitoring alert or a user reporting an error. The immediate impact is often a loss of data integrity or availability. Longer‑term costs include regulatory fines, legal suits, and the expense of rebuilding hardened infrastructure.

## Tags

#azure #cloud-security #defense-in-depth #shared-responsibility #compliance

---  
_Ingested: 2026-04-15 20:23 | Source: https://learn.microsoft.com/en-us/azure/security/fundamentals/overview_