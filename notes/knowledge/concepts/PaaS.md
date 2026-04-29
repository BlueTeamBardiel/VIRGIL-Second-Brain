# PaaS

## What it is
Think of PaaS like renting a fully equipped commercial kitchen: the building, ovens, and utilities are handled for you — you just bring your recipe and ingredients. Platform as a Service provides a managed cloud environment where developers deploy and run applications without managing the underlying OS, runtime, or middleware infrastructure.

## Why it matters
In 2021, attackers exploited misconfigured Heroku (a PaaS provider) pipelines to steal OAuth tokens from GitHub integrations, compromising dozens of downstream applications. Because PaaS abstracts infrastructure management, organizations often assume the provider handles *all* security — creating dangerous blind spots around application-layer configurations, secrets management, and third-party integrations that remain the customer's responsibility.

## Key facts
- **Shared Responsibility Model**: In PaaS, the provider secures OS, runtime, and infrastructure; the customer is responsible for application code, data, and access controls
- **Attack surface shifts upward**: Vulnerabilities focus on application logic, APIs, insecure dependencies (supply chain), and misconfigured deployment pipelines rather than OS-level exploits
- **Common PaaS providers**: Heroku, Google App Engine, Microsoft Azure App Service, AWS Elastic Beanstalk — each with platform-specific security controls (e.g., managed identity, environment variable secrets)
- **Multitenancy risk**: Multiple customers share underlying infrastructure; container escape or hypervisor vulnerabilities could theoretically breach tenant isolation
- **Compliance impact**: Customers retain data residency and compliance obligations (HIPAA, PCI-DSS) even though they don't control the underlying infrastructure

## Related concepts
[[Shared Responsibility Model]] [[IaaS]] [[SaaS]] [[Container Security]] [[Supply Chain Attack]]