# Cloud Storage

## What it is
Think of cloud storage like a massive, climate-controlled warehouse where thousands of businesses rent shelf space — your data sits alongside others', separated only by access control labels, not physical walls. Precisely, cloud storage is the remote hosting of data on virtualized infrastructure managed by a third party (AWS S3, Azure Blob, Google Cloud Storage), accessed via APIs over the internet. The provider handles hardware; the customer controls what gets stored and who can reach it.

## Why it matters
In 2019, Capital One suffered a breach exposing 100 million customer records because a misconfigured AWS S3 bucket combined with an SSRF vulnerability allowed an attacker to harvest IAM credentials and exfiltrate data. This illustrates the shared responsibility model failure mode: AWS secured the infrastructure, but the customer misconfigured the access policy — leaving a public-facing bucket wide open. Defenders must audit bucket permissions continuously using tools like AWS Trusted Advisor or third-party CSPM solutions.

## Key facts
- **Shared Responsibility Model**: The provider secures *of* the cloud (hardware, hypervisors, facilities); the customer secures *in* the cloud (data, IAM policies, encryption settings)
- **Common misconfiguration**: S3 buckets set to public-read or public-write — a top finding in cloud breach investigations
- **Encryption options**: Server-Side Encryption (SSE) uses provider-managed keys; Customer-Managed Keys (CMK) via KMS give organizations control over key lifecycle
- **Data sovereignty**: Data stored in foreign-region cloud infrastructure may fall under that nation's legal jurisdiction (e.g., GDPR compliance requires knowing where EU data lives)
- **Access control mechanisms**: Bucket policies, ACLs, and IAM roles are layered — a permissive ACL can override a restrictive bucket policy depending on platform implementation

## Related concepts
[[Shared Responsibility Model]] [[Identity and Access Management]] [[Data Loss Prevention]] [[Cloud Security Posture Management]] [[Encryption at Rest]]