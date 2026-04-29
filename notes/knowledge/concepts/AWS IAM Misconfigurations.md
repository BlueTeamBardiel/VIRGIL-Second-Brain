# AWS IAM Misconfigurations

## What it is
Like leaving a master key under the doormat of a skyscraper because it's "easier for the cleaning crew," IAM misconfigurations grant excessive cloud permissions that attackers can exploit without ever touching the front door. AWS Identity and Access Management (IAM) misconfigurations occur when roles, policies, or credentials are improperly scoped, exposing resources to unauthorized access. Common forms include wildcard permissions (`*:*`), overly permissive trust policies, and publicly accessible S3 buckets tied to misconfigured roles.

## Why it matters
In the 2019 Capital One breach, a misconfigured WAF role allowed Server-Side Request Forgery (SSRF) to reach the EC2 metadata service, leaking IAM credentials that granted access to over 100 million customer records. Attackers routinely use tools like Pacu or ScoutSuite to enumerate misconfigured IAM roles and escalate privileges without exploiting a single CVE — pure misconfiguration abuse.

## Key facts
- **Principle of Least Privilege** violations are the root cause of most IAM misconfigurations; every role should have only the permissions required for its specific task
- **IAM Privilege Escalation** can occur when a low-privilege user has `iam:AttachUserPolicy` or `iam:CreatePolicyVersion` permissions, allowing self-promotion to admin
- **AWS Access Analyzer** natively detects externally accessible resources and overly permissive cross-account trust policies
- **Instance Metadata Service v1 (IMDSv1)** allows any process on an EC2 instance to query `169.254.169.254` for IAM credentials without authentication — IMDSv2 requires a token
- **Wildcard actions** (`"Action": "*"`) in inline policies frequently appear in exam questions as the textbook example of misconfiguration

## Related concepts
[[Principle of Least Privilege]] [[Cloud Security Posture Management]] [[Privilege Escalation]] [[Server-Side Request Forgery]] [[Zero Trust Architecture]]