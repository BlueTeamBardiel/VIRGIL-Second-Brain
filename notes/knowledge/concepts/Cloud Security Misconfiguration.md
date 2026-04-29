# Cloud Security Misconfiguration

## What it is
Imagine renting a safe deposit box at a bank, then accidentally leaving the combination written on a sticky note taped to the outside — the vault is sophisticated, but your setup is the vulnerability. Cloud security misconfiguration occurs when cloud services (storage buckets, databases, identity policies) are deployed with insecure default or user-defined settings that expose resources to unauthorized access.

## Why it matters
In 2019, Capital One suffered a breach exposing 100 million customer records because an AWS WAF role was misconfigured with overly permissive EC2 metadata service access, allowing an SSRF attack to escalate into credential theft. Proper IAM least-privilege policies and continuous configuration scanning with tools like AWS Config or Microsoft Defender for Cloud would have detected and blocked this exposure before exploitation.

## Key facts
- **S3 bucket exposure** is the most commonly tested misconfiguration: public read/write ACLs on storage buckets have leaked government records, health data, and source code repeatedly
- **Default credentials** left unchanged on cloud management consoles (MongoDB, Elasticsearch) represent a top-10 CIS benchmark failure
- The **Shared Responsibility Model** is critical: misconfigurations are almost always the *customer's* responsibility, not the cloud provider's
- **CSPM (Cloud Security Posture Management)** tools continuously audit cloud environments against frameworks like CIS Benchmarks and NIST CSF to detect drift
- **Over-permissive IAM roles** — especially wildcard permissions (`*:*`) — are flagged by Security+ and CySA+ as primary attack surface in cloud environments

## Related concepts
[[Shared Responsibility Model]] [[Identity and Access Management]] [[Cloud Security Posture Management]] [[Principle of Least Privilege]] [[Server-Side Request Forgery]]