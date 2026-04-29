# Cloud Account

## What it is
Like a master keyring to a skyscraper where every key you carry opens a different floor, a cloud account is the root identity and billing container that controls access to an entire cloud provider's infrastructure. It is the top-level organizational unit (AWS account, Azure subscription, GCP project) under which all resources, identities, and permissions are provisioned and billed.

## Why it matters
In 2019, Capital One suffered a breach when a misconfigured WAF allowed an attacker to exploit an SSRF vulnerability and steal AWS IAM credentials — ultimately exfiltrating data from S3 buckets across the account. A single compromised cloud account can expose every resource within it, making account-level security controls (MFA on root, SCPs, account isolation) critical defensive layers.

## Key facts
- **Root account** credentials should never be used for daily operations; instead, least-privilege IAM users or roles should be created immediately after account creation
- Cloud accounts are a primary target in the **MITRE ATT&CK for Cloud** framework under the *Initial Access* tactic (T1078.004 — Valid Accounts: Cloud Accounts)
- **Account separation** (using multiple accounts per environment: dev/staging/prod) is a defense-in-depth strategy that limits blast radius if one account is compromised
- Multi-Factor Authentication (MFA) on cloud root/admin accounts is a **CIS Benchmark Level 1** control and appears directly in Security+ exam objectives
- Credential exposure via **public repository leaks** (e.g., AWS keys pushed to GitHub) is one of the most common cloud account takeover vectors

## Related concepts
[[IAM (Identity and Access Management)]] [[Privilege Escalation]] [[Least Privilege]] [[Multi-Factor Authentication]] [[SSRF (Server-Side Request Forgery)]]