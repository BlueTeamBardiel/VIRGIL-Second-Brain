# Shared Security Model

## What it is
Think of it like renting an apartment: the landlord secures the building, locks the lobby, and maintains the roof — but you're responsible for locking your own door and not leaving your laptop on the windowsill. The Shared Security Model (also called Shared Responsibility Model) is a cloud computing framework that divides security obligations between the cloud service provider (CSP) and the customer, with the boundary shifting depending on the service type (IaaS, PaaS, SaaS).

## Why it matters
In 2019, Capital One suffered a breach exposing 100 million customer records hosted on AWS. AWS's infrastructure was never compromised — the failure was a misconfigured Web Application Firewall, which was Capital One's responsibility to configure correctly. This is the classic shared model failure: customers assume the cloud provider handles more than it actually does.

## Key facts
- **IaaS** (e.g., EC2): CSP secures hardware and hypervisor; customer secures OS, apps, and data
- **PaaS** (e.g., Elastic Beanstalk): CSP adds runtime and middleware responsibility; customer still owns application code and data
- **SaaS** (e.g., Office 365): CSP handles nearly everything; customer is responsible for identity management, access controls, and data classification
- The CSP is **always** responsible for security *of* the cloud (physical infrastructure, network fabric, hypervisors)
- The customer is **always** responsible for security *in* the cloud (their data, credentials, and configurations)
- Misconfiguration is the #1 cloud security failure — directly caused by misunderstanding where customer responsibility begins

## Related concepts
[[Cloud Service Models]] [[Misconfiguration Vulnerabilities]] [[Identity and Access Management]] [[Defense in Depth]] [[Data Classification]]