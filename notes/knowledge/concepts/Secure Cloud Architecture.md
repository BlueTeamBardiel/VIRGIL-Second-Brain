# Secure Cloud Architecture

## What it is
Think of it like designing a bank vault inside a skyscraper you don't own — you control what goes inside and who has keys, but the building's locks, elevators, and guards belong to someone else. Secure Cloud Architecture is the deliberate design of cloud environments using security controls, segmentation, and governance frameworks to protect data and workloads across shared infrastructure. It operates under the **Shared Responsibility Model**, where cloud providers secure the underlying infrastructure while customers secure their configurations, data, and access controls.

## Why it matters
In 2019, Capital One suffered a breach exposing 100 million customer records because a misconfigured AWS Web Application Firewall allowed Server-Side Request Forgery (SSRF) to extract IAM credentials from the instance metadata service. A properly architected environment would have applied least-privilege IAM roles, disabled unnecessary metadata endpoints, and used VPC segmentation to contain the blast radius — demonstrating that misconfigurations, not provider failures, are the dominant cloud attack vector.

## Key facts
- The **Shared Responsibility Model** splits duties: AWS/Azure/GCP own security *of* the cloud; customers own security *in* the cloud
- **Zero Trust Architecture** is foundational — no implicit trust based on network location; every request must be authenticated and authorized
- **Cloud Security Posture Management (CSPM)** tools continuously audit configurations against benchmarks like CIS Controls or NIST 800-53
- Data must be encrypted **in transit** (TLS 1.2+) and **at rest** (AES-256), with customer-managed keys preferred for sensitive workloads
- **VPC segmentation** and security groups enforce micro-perimeters; overly permissive rules (0.0.0.0/0 on port 22) are a top misconfiguration finding

## Related concepts
[[Shared Responsibility Model]] [[Zero Trust Architecture]] [[Cloud Security Posture Management]] [[Identity and Access Management]] [[Defense in Depth]]