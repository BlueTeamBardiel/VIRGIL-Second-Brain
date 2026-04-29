# Cloud

## What it is
Think of cloud computing like renting space in a shared office building — you get the desk, the Wi-Fi, and the coffee machine, but you don't own the walls or the HVAC system. Precisely, cloud computing is the on-demand delivery of computing resources (storage, servers, software) over the internet, managed by a third-party provider under a shared responsibility model. The provider secures the infrastructure; the customer secures what they put inside it.

## Why it matters
In 2019, Capital One suffered a breach affecting 100 million customers when a misconfigured AWS Web Application Firewall allowed an attacker to exploit an SSRF vulnerability and steal credentials from the instance metadata service. This is the canonical cloud failure mode: not a broken provider, but a misconfigured customer deployment — exactly what the shared responsibility model divides ownership over.

## Key facts
- **Service models define responsibility boundaries**: IaaS (customer manages OS up), PaaS (customer manages apps/data), SaaS (customer manages data/users only)
- **Deployment models**: Public (shared, multi-tenant), Private (dedicated), Hybrid (both), Community (shared among specific organizations)
- **Cloud-specific threats**: Insecure APIs, misconfigured storage buckets (public S3 buckets), account hijacking, and insufficient identity/access management top the OWASP Cloud-Native Top 10
- **CASB (Cloud Access Security Broker)** sits between users and cloud services to enforce policy, visibility, and DLP — a key control on Security+ exams
- **Elasticity ≠ security**: Auto-scaling can mask DDoS attacks or unexpected costs from cryptojacking if resource monitoring is absent

## Related concepts
[[Shared Responsibility Model]] [[CASB]] [[Identity and Access Management]] [[Virtualization]] [[Zero Trust]]