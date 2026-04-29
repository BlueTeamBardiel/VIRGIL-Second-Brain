# Azure Infrastructure Security

## What it is
Think of Azure infrastructure security like the physical design of a bank vault building — not just the safe itself, but the reinforced walls, controlled entry points, security cameras, and guard rotations that protect everything inside. Precisely, it is the set of controls, configurations, and services Microsoft Azure provides to protect the underlying compute, network, storage, and identity layers of cloud-hosted systems from unauthorized access, misconfiguration, and attack.

## Why it matters
In 2021, researchers demonstrated that misconfigured Azure Blob Storage containers exposed sensitive data from thousands of organizations — no exploitation required, just a direct HTTP request to a public endpoint. Proper infrastructure security using Azure Policy, Network Security Groups (NSGs), and Private Endpoints would have blocked public exposure entirely and flagged the misconfiguration automatically before breach.

## Key facts
- **Shared Responsibility Model**: Microsoft secures the physical infrastructure and hypervisor; customers are responsible for OS hardening, identity, data, and application security.
- **Azure Security Center / Defender for Cloud** provides continuous posture assessment using a Secure Score, highlighting misconfigured resources against CIS Benchmarks.
- **Network Security Groups (NSGs)** operate at Layer 3/4, filtering inbound and outbound traffic to subnets and NICs using stateful rules — similar to ACLs but native to Azure VNets.
- **Azure Policy** enforces compliance at scale by auditing or denying resource deployments that violate defined security baselines (e.g., blocking public IP assignments).
- **Just-In-Time (JIT) VM Access** in Defender for Cloud reduces attack surface by opening management ports (RDP/SSH) only on-demand for approved time windows.

## Related concepts
[[Shared Responsibility Model]] [[Network Security Groups]] [[Cloud Security Posture Management]] [[Zero Trust Architecture]] [[Identity and Access Management]]