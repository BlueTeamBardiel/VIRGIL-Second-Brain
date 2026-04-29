# Cloud Infrastructure

## What it is
Think of cloud infrastructure like renting space in a giant, shared office building — you get your own locked suite, but the hallways, elevators, and plumbing are shared with hundreds of other tenants. Precisely, it refers to the virtualized compute, storage, networking, and services hosted by third-party providers (AWS, Azure, GCP) and delivered on-demand over the internet. The physical hardware exists somewhere — you just don't own or manage it directly.

## Why it matters
In the 2019 Capital One breach, a misconfigured Web Application Firewall in AWS allowed an attacker to exploit a Server Side Request Forgery (SSRF) vulnerability to query the EC2 Instance Metadata Service, harvesting temporary IAM credentials and exfiltrating over 100 million customer records. This demonstrates that cloud security failures are almost never the provider's fault — misconfigurations by the customer are the dominant attack vector.

## Key facts
- The **Shared Responsibility Model** divides security duties: the provider secures "of" the cloud (hardware, hypervisors, facilities); the customer secures "in" the cloud (data, identity, configurations, OS patching in IaaS)
- **IaaS, PaaS, and SaaS** represent increasing abstraction — with SaaS, you control almost nothing except user access and data
- **Cloud misconfigurations** are the #1 cause of cloud breaches — exposed S3 buckets and over-permissive IAM roles are the classic examples
- **Instance Metadata Services (IMDS)** are a frequent SSRF target; IMDSv2 in AWS requires session-oriented tokens to mitigate this
- The **CSA Cloud Controls Matrix (CCM)** is a key framework for evaluating cloud security controls, referenced in CySA+ objectives

## Related concepts
[[Shared Responsibility Model]] [[Identity and Access Management]] [[Server Side Request Forgery]] [[Virtualization Security]] [[Zero Trust Architecture]]