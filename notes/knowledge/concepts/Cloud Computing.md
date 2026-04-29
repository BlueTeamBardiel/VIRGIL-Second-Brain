# cloud computing

## What it is
Think of it like renting a fully-staffed commercial kitchen instead of building your own — you get the equipment, the utilities, and the maintenance staff, but you share the building with other chefs. Cloud computing is the on-demand delivery of computing resources (servers, storage, databases, networking) over the internet from a provider's infrastructure, billed by usage. Resources are pooled, elastic, and accessible without direct physical management by the consumer.

## Why it matters
In 2019, Capital One suffered a breach of 100 million customer records when a misconfigured AWS Web Application Firewall allowed an attacker to exploit Server-Side Request Forgery (SSRF), reaching EC2 instance metadata and stealing IAM credentials. This demonstrates that cloud security failures are almost always *configuration* failures, not provider infrastructure failures — the shared responsibility model means you own your data and access controls even when someone else owns the hardware.

## Key facts
- **Three service models**: IaaS (you manage OS and up), PaaS (you manage apps and data), SaaS (provider manages everything — you use it)
- **Shared Responsibility Model**: the provider secures "of" the cloud (hardware, facilities, hypervisor); the customer secures "in" the cloud (data, IAM, configurations)
- **Four deployment models**: Public, Private, Hybrid, Community — each with distinct risk profiles for Security+ exams
- **Top cloud threats (CSA)**: misconfiguration, insecure APIs, account hijacking, and insufficient identity management — not hardware exploits
- **Cloud access broker (CASB)** sits between users and cloud services to enforce security policies, providing visibility, compliance, and threat protection

## Related concepts
[[shared responsibility model]] [[identity and access management]] [[CASB]] [[virtualization]] [[zero trust architecture]]