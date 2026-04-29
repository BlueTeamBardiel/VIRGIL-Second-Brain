# Metadata Service

## What it is
Think of it as a sticky note taped to the inside of a cloud server's locker — available only from within, containing the server's own identity, credentials, and configuration. A metadata service is an internal HTTP endpoint (typically at `169.254.169.254`) that cloud instances query to retrieve instance-specific information such as IAM role credentials, network configuration, and startup scripts. It's only reachable from within the instance itself — by design.

## Why it matters
In the 2019 Capital One breach, a misconfigured WAF was exploited via Server-Side Request Forgery (SSRF) to make the cloud instance query its own metadata service. The attacker retrieved temporary AWS IAM credentials from the endpoint, then used those credentials to access over 100 million customer records stored in S3 buckets. This single pivot point — SSRF to metadata service — turned a web vulnerability into a full cloud compromise.

## Key facts
- The default metadata service IP is `169.254.169.254` (link-local), accessible on AWS, GCP, and Azure instances
- AWS IMDSv1 requires no authentication; IMDSv2 (the hardened version) requires a session-oriented token obtained via a PUT request, blocking most SSRF attacks
- Sensitive data returned can include: IAM role credentials (with expiry), user-data scripts, AMI IDs, and security group info
- Disabling or restricting access to the metadata endpoint via host-based firewall rules is a defense-in-depth control
- CIS Benchmarks and AWS Security Hub explicitly flag IMDSv1 as a finding; enforcing IMDSv2 is a scored hardening requirement

## Related concepts
[[Server-Side Request Forgery (SSRF)]] [[IAM Roles and Policies]] [[Cloud Security Posture Management]] [[Privilege Escalation]] [[Instance Profiles]]