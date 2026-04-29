# Azure

## What it is
Like renting floors in a skyscraper where Microsoft owns the building, handles the plumbing, but you're responsible for locking your own office doors. Azure is Microsoft's cloud computing platform offering IaaS, PaaS, and SaaS services, where security responsibilities are split between Microsoft (physical infrastructure, hypervisor) and the customer (identity, data, configurations).

## Why it matters
In the 2021 ChaosDB vulnerability, researchers discovered a misconfigured Azure Cosmos DB feature (Jupyter Notebooks) that allowed attackers to escalate privileges and access other customers' primary keys — exposing data for thousands of organizations worldwide. This illustrates that even Microsoft's infrastructure being secure doesn't protect you from misconfigurations within *your* tenant.

## Key facts
- **Shared Responsibility Model**: Microsoft secures the cloud infrastructure; customers are responsible for data classification, identity management, and workload configurations
- **Azure Active Directory (Entra ID)** is the primary identity provider — compromising it via password spray or token theft is the #1 path to tenant takeover
- **Azure Security Center / Defender for Cloud** provides continuous security posture scoring (Secure Score) and threat detection across hybrid environments
- **RBAC (Role-Based Access Control)** governs Azure resource access; over-permissive roles like "Owner" or "Contributor" are common misconfigurations attackers exploit
- **Azure logs** (Activity Log, Azure Monitor, Microsoft Sentinel) are critical for forensics — disabled logging is a red flag during incident response

## Related concepts
[[Shared Responsibility Model]] [[Identity and Access Management]] [[Cloud Security Posture Management]] [[Microsoft Sentinel]] [[Zero Trust Architecture]]