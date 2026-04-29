# Cloud Security Architecture

## What it is
Think of a traditional data center as a medieval castle — everything valuable sits behind one thick wall. Cloud security architecture is like redesigning that castle into a series of guarded checkpoints across multiple cities, where trust is never assumed just because you're already inside. It is the deliberate design of policies, controls, and technologies that protect data, workloads, and infrastructure across cloud environments using shared responsibility, segmentation, and identity-centric controls.

## Why it matters
In 2019, Capital One suffered a breach exposing 100 million customer records because a misconfigured AWS WAF allowed a Server-Side Request Forgery (SSRF) attack to extract IAM credentials from the metadata service. A proper cloud security architecture — including IMDSv2 enforcement, least-privilege IAM roles, and network segmentation — would have broken the attack chain before data exfiltration occurred.

## Key facts
- **Shared Responsibility Model**: The cloud provider secures infrastructure *of* the cloud; the customer secures everything *in* the cloud (configurations, data, identities).
- **Zero Trust is mandatory**: Because perimeter boundaries dissolve in cloud environments, identity becomes the new perimeter — verify every request, always.
- **CASB (Cloud Access Security Broker)**: Acts as a policy enforcement point between users and cloud services, providing visibility, compliance, and threat protection.
- **Misconfiguration is the #1 threat**: Per the Cloud Security Alliance, exposed S3 buckets and over-permissive IAM roles cause the majority of cloud breaches — not zero-days.
- **Security Groups vs. NACLs**: In AWS, Security Groups are stateful (return traffic allowed automatically); NACLs are stateless (both directions must be explicitly permitted) — a classic exam distinction.

## Related concepts
[[Zero Trust Architecture]] [[Identity and Access Management]] [[CASB]] [[Shared Responsibility Model]] [[Misconfiguration Vulnerabilities]]