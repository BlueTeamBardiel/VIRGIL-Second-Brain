# AWS IAM

## What it is
Think of AWS IAM like a hotel's keycard system: the front desk (IAM) issues cards (credentials) that only open specific doors (services) for specific guests (identities), and a master log tracks every swipe. Precisely, AWS Identity and Access Management (IAM) is a cloud access control framework that manages *who* (users, roles, services) can do *what* (actions) on *which* AWS resources through policy-based permissions. It enforces least privilege at the API level across every AWS service call.

## Why it matters
In the 2019 Capital One breach, an attacker exploited a misconfigured WAF running on an EC2 instance that had an overly permissive IAM role — the role could call `s3:GetObject` on *any* bucket, exposing 100 million customer records. A properly scoped IAM role restricted to only the specific S3 bucket that application needed would have contained the blast radius entirely.

## Key facts
- **Policies are JSON documents** evaluated as Allow/Deny logic; an explicit `Deny` always overrides any `Allow`
- **IAM roles** are preferred over long-lived access keys — roles issue temporary STS (Security Token Service) credentials that expire automatically
- **The AWS root account** has unrestricted access and cannot be restricted by IAM policies; MFA should be enabled and the root never used for daily tasks
- **Permission boundaries** set the maximum permissions an identity can have, even if broader policies are attached — useful for delegated administration
- **CloudTrail** logs all IAM API calls, making it the primary forensic tool for detecting privilege escalation or credential misuse

## Related concepts
[[Least Privilege Principle]] [[Role-Based Access Control]] [[OAuth and Token-Based Authentication]] [[Cloud Security Posture Management]] [[Privilege Escalation]]