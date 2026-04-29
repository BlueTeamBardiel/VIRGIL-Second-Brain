# Cloud Security Misconfigurations

## What it is
Imagine renting a storage unit but accidentally leaving the padlock open and posting your unit number on a billboard — that's essentially what happens when cloud resources are deployed with default or overly permissive settings. Cloud security misconfigurations occur when cloud services, storage buckets, databases, or APIs are improperly configured, exposing sensitive data or functionality to unauthorized users. Unlike traditional vulnerabilities, these aren't software flaws — they're human configuration errors in an environment where defaults are often dangerously permissive.

## Why it matters
In 2019, Capital One suffered a breach exposing over 100 million customer records because a misconfigured AWS Web Application Firewall allowed an attacker to perform a Server-Side Request Forgery (SSRF) attack and extract credentials from the EC2 metadata service. A properly scoped IAM role with least-privilege permissions would have prevented lateral movement entirely. This illustrates that misconfigurations are consistently ranked by the Cloud Security Alliance as a top cloud threat.

## Key facts
- **S3 bucket exposure** is among the most common misconfigurations — publicly readable buckets have leaked medical records, source code, and government data
- The **Shared Responsibility Model** places configuration security on the *customer*, not the cloud provider — AWS secures the infrastructure, you secure what runs on it
- **CSPM (Cloud Security Posture Management)** tools continuously audit cloud configurations against frameworks like CIS Benchmarks to detect drift
- Overly permissive **IAM roles and policies** (e.g., wildcard `*` permissions) are a primary attack vector for privilege escalation
- Misconfigurations are listed as a top risk in both the **OWASP Cloud-Native Application Security Top 10** and **CSA's Egregious Eleven**

## Related concepts
[[Identity and Access Management]] [[Shared Responsibility Model]] [[Cloud Security Posture Management]]