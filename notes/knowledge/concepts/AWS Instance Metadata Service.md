# AWS Instance Metadata Service

## What it is
Think of it as a vending machine bolted to the wall *inside* the server room — any process running on an EC2 instance can walk up and request credentials, network config, and identity tokens without needing a password. Precisely, the AWS Instance Metadata Service (IMDS) is an internal HTTP endpoint (`http://169.254.169.254`) accessible only from within an EC2 instance, providing runtime configuration data including IAM role credentials, instance ID, and user data scripts.

## Why it matters
In the 2019 Capital One breach, a misconfigured WAF allowed an attacker to perform a Server-Side Request Forgery (SSRF) attack — they tricked the server into fetching `http://169.254.169.254/latest/meta-data/iam/security-credentials/`, harvesting temporary AWS credentials and exfiltrating over 100 million customer records. IMDSv2, which requires a session-oriented token obtained via a PUT request before any metadata query, was designed specifically to break this SSRF attack chain.

## Key facts
- **IMDSv1** is unauthenticated and vulnerable to SSRF; a single GET request returns sensitive credentials with no prior handshake
- **IMDSv2** requires a PUT request to obtain a session token (TTL 1–21600 seconds), which must be included in subsequent metadata requests — SSRF attacks using simple GET requests cannot complete this handshake
- The link-local IP `169.254.169.254` is non-routable and unreachable from outside the instance, but SSRF bypasses this boundary by weaponizing the server itself
- IAM credentials retrieved from IMDS are **temporary STS tokens** (Access Key ID, Secret Access Key, Session Token) tied to the instance's attached IAM role
- AWS recommends enforcing IMDSv2-only via instance metadata options and setting hop limit to **1** to prevent credential theft from containerized workloads

## Related concepts
[[Server-Side Request Forgery (SSRF)]] [[IAM Roles and Policies]] [[Cloud Security Misconfigurations]]