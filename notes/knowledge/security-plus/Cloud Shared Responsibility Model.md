# Cloud Shared Responsibility Model

## What it is
Think of renting an apartment: the landlord maintains the building's foundation, roof, and plumbing, but you're responsible for locking your own door and not leaving valuables on the windowsill. The Cloud Shared Responsibility Model defines the division of security obligations between a cloud service provider (CSP) and the customer — what the provider secures versus what the customer must secure themselves.

## Why it matters
In 2019, Capital One suffered a breach exposing 100 million records because a misconfigured AWS Web Application Firewall allowed an SSRF attack — AWS's infrastructure was never compromised. The breach lived entirely in the customer's responsibility zone: IAM roles, firewall rules, and data access controls. Understanding the model tells defenders *exactly where to look* when something goes wrong.

## Key facts
- **IaaS** (e.g., AWS EC2): CSP secures physical hardware and hypervisor; customer owns OS, applications, data, and network config
- **PaaS** (e.g., Google App Engine): CSP adds OS and runtime to its responsibilities; customer owns application code and data
- **SaaS** (e.g., Microsoft 365): CSP manages nearly everything; customer retains responsibility for user access management and data classification
- The CSP is **always** responsible for physical security, hypervisor integrity, and core network infrastructure — regardless of service model
- Misconfigured cloud storage buckets (S3, Azure Blob) are a top breach vector precisely because customers misunderstand their data-exposure responsibilities

## Related concepts
[[Identity and Access Management]] [[Principle of Least Privilege]] [[Cloud Security Posture Management]]