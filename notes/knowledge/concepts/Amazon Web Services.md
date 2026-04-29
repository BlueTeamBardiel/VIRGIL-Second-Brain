# Amazon Web Services

## What it is
Think of AWS like a city of rental buildings — you can lease office space (compute), storage units (S3), or even hire security guards (IAM) without owning the land. Precisely, AWS is a cloud computing platform offering on-demand infrastructure, platform, and software services (IaaS/PaaS/SaaS) under a **Shared Responsibility Model** where Amazon secures *of* the cloud, customers secure *in* the cloud.

## Why it matters
In the 2019 Capital One breach, a misconfigured AWS Web Application Firewall allowed an attacker to exploit SSRF (Server-Side Request Forgery) to query the EC2 Instance Metadata Service, harvesting IAM credentials that exposed over 100 million customer records stored in S3 buckets. This illustrates how cloud misconfigurations — not AWS infrastructure failures — are the dominant attack surface defenders must own.

## Key facts
- **Shared Responsibility Model**: AWS owns hypervisor, physical hardware, and global infrastructure; customers own OS patching, IAM configuration, data encryption, and network security groups
- **IAM (Identity and Access Management)** is the primary access control layer — overly permissive roles and long-lived access keys are the #1 source of AWS compromise
- **S3 buckets** default to private since April 2023, but legacy public buckets have exposed sensitive data in thousands of documented breaches
- **CloudTrail** is the native audit logging service recording API calls — disabling CloudTrail is a key attacker anti-forensics technique to watch for in CySA+ scenarios
- **Security groups** act as stateful virtual firewalls at the instance level; **NACLs** are stateless and operate at the subnet level — a critical distinction for exam questions

## Related concepts
[[Shared Responsibility Model]] [[Identity and Access Management]] [[Cloud Security Posture Management]] [[S3 Bucket Misconfiguration]] [[SSRF Attacks]]