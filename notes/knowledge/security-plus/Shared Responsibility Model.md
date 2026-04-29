# Shared Responsibility Model

## What it is
Think of a commercial kitchen rental: the building owner provides the stoves and ventilation codes, but you're responsible for not burning the food or leaving raw chicken on counters. In cloud computing, the Shared Responsibility Model divides security obligations between the cloud provider (CSP) and the customer — the CSP secures the underlying infrastructure, while the customer secures what they deploy *on top of it*. The exact split shifts depending on the service model: IaaS, PaaS, or SaaS.

## Why it matters
In 2019, Capital One suffered a breach exposing 100 million records from AWS S3 buckets — AWS's infrastructure was never compromised. The misconfigured firewall rule and overpermissioned IAM role were entirely the *customer's* responsibility, yet many organizations wrongly assumed the CSP's security posture extended to their own data and configurations. This breach is the textbook example of why misunderstanding this model kills organizations.

## Key facts
- **IaaS** (e.g., AWS EC2): CSP secures hardware, hypervisor, and physical facilities; customer owns OS, apps, data, and network configuration
- **PaaS** (e.g., AWS RDS): CSP adds OS and runtime security; customer still owns data, access controls, and application logic
- **SaaS** (e.g., Microsoft 365): CSP handles nearly everything; customer is responsible for user access management, data classification, and endpoint security
- The CSP is **always** responsible for physical security of data centers — the customer never is
- Misconfigurations are the #1 cloud breach vector precisely because customers underestimate their side of the model (per Gartner, through 2025, 99% of cloud failures will be the customer's fault)

## Related concepts
[[Cloud Security Posture Management]] [[Identity and Access Management]] [[Principle of Least Privilege]]