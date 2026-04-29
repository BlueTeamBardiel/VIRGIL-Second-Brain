# EC2

## What it is
Think of EC2 like renting a hotel room in Amazon's skyscraper — you get your own locked room with configurable amenities, but you share the building's infrastructure with other guests. Amazon EC2 (Elastic Compute Cloud) is a web service that provides resizable virtual machine instances in the cloud, allowing organizations to run workloads without owning physical hardware. Each instance runs on shared hypervisor infrastructure, isolated from neighbors via virtualization.

## Why it matters
In the famous 2019 Capital One breach, a misconfigured EC2 instance's firewall rules allowed an SSRF (Server-Side Request Forgery) attack to reach the AWS Instance Metadata Service (IMDSv1), leaking IAM credentials and exposing over 100 million customer records. Defenders must harden EC2 instances by enforcing IMDSv2 (which requires session tokens), restricting security group rules, and using IAM roles with least privilege instead of hardcoded credentials.

## Key facts
- **Security Groups** act as stateful virtual firewalls controlling inbound/outbound traffic to EC2 instances; they default to deny-all inbound and allow-all outbound
- **Instance Metadata Service (IMDS)** at `169.254.169.254` exposes IAM credentials, user data, and configuration — SSRF vulnerabilities targeting this endpoint are a critical EC2 attack vector
- **IMDSv2** mitigates SSRF attacks against the metadata service by requiring a PUT request to obtain a session token before metadata can be retrieved
- **User Data scripts** run at instance launch with root/SYSTEM privileges — injecting malicious content here enables persistence and privilege escalation
- EC2 instances can be assigned **IAM Instance Profiles** (roles) to grant AWS service permissions without storing access keys — improper role scope enables lateral movement to S3, RDS, and other services

## Related concepts
[[IAM]] [[Security Groups]] [[SSRF]] [[Cloud Security]] [[Least Privilege]]