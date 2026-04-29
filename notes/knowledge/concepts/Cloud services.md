# Cloud services

## What it is
Think of cloud services like renting space in a professional storage facility rather than building your own warehouse — you share infrastructure but get your own locked unit. Precisely, cloud services are IT resources (compute, storage, networking, applications) delivered on-demand over the internet by third-party providers, consumed under a shared responsibility model where security duties are split between provider and customer.

## Why it matters
In 2019, Capital One suffered a breach affecting 100 million customers when a misconfigured AWS Web Application Firewall allowed an attacker to exploit SSRF (Server-Side Request Forgery) to steal IAM credentials and access S3 buckets. This illustrates the core cloud security danger: the provider secured the physical infrastructure, but the *customer* misconfigured the controls they were responsible for — a classic shared responsibility failure.

## Key facts
- **Service models carry different responsibility splits**: In IaaS, customers manage OS and up; in PaaS, customers manage applications and data; in SaaS, customers manage only data and access control
- **The #1 cloud threat is misconfiguration**, not provider-side breaches — publicly exposed S3 buckets and open security groups are leading causes of cloud data loss
- **CASB (Cloud Access Security Broker)** sits between users and cloud providers to enforce security policies, visibility, and compliance — key tool for cloud security architecture
- **Four deployment models**: Public, Private, Hybrid, and Community cloud — each carries different trust boundaries and compliance implications (Security+ exam staple)
- **Elasticity introduces ephemeral assets** — VMs spin up and down automatically, making traditional asset inventory and patch management approaches ineffective; cloud-native tools like AWS Config or Azure Security Center are required

## Related concepts
[[Shared responsibility model]] [[Identity and Access Management]] [[CASB]] [[Misconfiguration vulnerabilities]] [[Zero trust architecture]]