# Cloud Provider Security

## What it is
Think of a cloud provider like a skyscraper landlord: they secure the building's foundation, elevators, and locks — but what tenants put in their apartments is their own responsibility. Cloud provider security formally describes the **Shared Responsibility Model**, where the provider (AWS, Azure, GCP) secures the underlying infrastructure, hypervisors, and physical hardware, while the customer remains responsible for data, identity, application configuration, and access controls.

## Why it matters
In 2019, Capital One suffered a breach exposing over 100 million customer records — not because AWS failed its infrastructure duties, but because a misconfigured Web Application Firewall (a *customer* responsibility) allowed SSRF attacks to extract AWS metadata credentials. The cloud was secure; the tenant configuration was not. This is the classic real-world consequence of misunderstanding where provider responsibility ends.

## Key facts
- The **Shared Responsibility Model** divides security into: provider owns "security *of* the cloud" (hardware, networking, hypervisors); customer owns "security *in* the cloud" (OS, data, IAM, encryption).
- **IaaS** gives customers the most responsibility; **SaaS** gives them the least — the provider handles nearly everything above the data layer.
- Cloud providers offer **compliance inheritance** (e.g., AWS inherits PCI-DSS controls for physical infrastructure), but customers must still achieve their own compliance for higher layers.
- **Instance metadata services** (IMDS) are a known attack surface — modern mitigations enforce IMDSv2, requiring token-based session authentication to prevent SSRF-based credential theft.
- Cloud security misconfigurations — not provider breaches — are consistently cited by CISA as the #1 cloud risk vector.

## Related concepts
[[Shared Responsibility Model]] [[Identity and Access Management]] [[SSRF (Server-Side Request Forgery)]] [[Misconfiguration Vulnerabilities]] [[Infrastructure as a Service (IaaS)]]