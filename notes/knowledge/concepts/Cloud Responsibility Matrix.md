# Cloud Responsibility Matrix

## What it is
Think of it like renting an apartment: the landlord owns the building's structure and plumbing, but you're responsible for locking your own door and securing your valuables. The Shared Responsibility Model (also called the Cloud Responsibility Matrix) is a framework that formally divides security obligations between a cloud service provider (CSP) and the customer, with the boundary shifting depending on the service model used (IaaS, PaaS, or SaaS).

## Why it matters
In 2019, Capital One suffered a breach exposing 100 million records — not because AWS failed, but because Capital One misconfigured a Web Application Firewall, a customer-side responsibility. AWS's infrastructure was secure; the customer's configuration layer was not. This breach is the textbook example of why misunderstanding the responsibility boundary creates exploitable gaps.

## Key facts
- **IaaS** (e.g., AWS EC2): CSP secures physical hardware, hypervisor, and networking; customer owns OS, applications, data, and identity management
- **PaaS** (e.g., AWS Elastic Beanstalk): CSP additionally manages the runtime and middleware; customer is responsible for application code and data
- **SaaS** (e.g., Microsoft 365): CSP manages nearly everything; customer retains responsibility for user access controls, data classification, and endpoint security
- The CSP is **always** responsible for security *of* the cloud (physical, hypervisor, core network); the customer is **always** responsible for security *in* the cloud (data, IAM, configurations)
- Misconfigured S3 buckets — a customer-side responsibility — have been the root cause in hundreds of major breaches, reinforcing that most cloud breaches are configuration failures, not CSP failures

## Related concepts
[[Shared Responsibility Model]] [[Infrastructure as a Service (IaaS)]] [[Cloud Security Posture Management (CSPM)]] [[Identity and Access Management (IAM)]] [[Data Classification]]