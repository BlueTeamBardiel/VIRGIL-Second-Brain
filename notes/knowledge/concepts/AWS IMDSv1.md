# AWS IMDSv1

## What it is
Imagine a hotel concierge desk inside the building that anyone staying in any room can walk up to and ask for a master key — no ID required. AWS IMDSv1 (Instance Metadata Service version 1) is an unauthenticated HTTP endpoint available at `169.254.169.254` on every EC2 instance, allowing any process running on that machine to query instance metadata, including IAM credential tokens, without any authentication challenge.

## Why it matters
In the 2019 Capital One breach, attacker Paige Thompson exploited a misconfigured WAF running on an EC2 instance to perform a Server-Side Request Forgery (SSRF) attack — proxying a request to `http://169.254.169.254/latest/meta-data/iam/security-credentials/` and retrieving temporary IAM keys with broad S3 permissions. This single unauthenticated endpoint, reachable via SSRF, exposed over 100 million customer records.

## Key facts
- IMDSv1 uses a simple GET request with **zero authentication** — any process or SSRF payload can query it
- The endpoint `169.254.169.254` is a **link-local address** (RFC 3927), only reachable from within the instance itself — but SSRF bypasses this boundary
- IAM temporary credentials retrieved from IMDS include `AccessKeyId`, `SecretAccessKey`, and `Token`, enabling full API access at the role's permission level
- AWS introduced **IMDSv2** as a defense: it requires a session-oriented PUT request first, generating a token — this breaks most SSRF exploit chains
- Disabling IMDSv1 can be enforced via **AWS Organizations SCP** or at instance launch using `HttpTokens: required`

## Related concepts
[[Server-Side Request Forgery (SSRF)]] [[IAM Roles and Temporary Credentials]] [[IMDSv2]] [[Cloud Metadata Services]] [[Privilege Escalation in Cloud Environments]]