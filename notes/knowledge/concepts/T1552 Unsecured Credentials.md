# T1552 Unsecured Credentials

## What it is
Like finding a sticky note with the vault combination taped directly to the vault door, unsecured credentials are authentication secrets stored in plaintext or easily accessible locations rather than protected storage. This MITRE ATT&CK technique covers adversaries searching for passwords, API keys, and tokens left exposed in config files, scripts, environment variables, or version control systems.

## Why it matters
In the 2019 Capital One breach, a misconfigured WAF allowed an attacker to query AWS metadata endpoints and retrieve temporary credentials stored in environment variables — granting access to over 100 million customer records. Defenders who implement secrets scanning in CI/CD pipelines (using tools like GitLeaks or truffleHog) can catch committed credentials before they reach production.

## Key facts
- Sub-techniques include T1552.001 (Credentials in Files), T1552.002 (Credentials in Registry), T1552.003 (Bash History), T1552.004 (Private Keys), and T1552.005 (Cloud Instance Metadata API)
- `.git` history is a primary target — developers frequently commit `.env` files containing database passwords and API keys, then delete them, not realizing git history persists
- Windows Registry keys like `HKLM\SOFTWARE\OpenSSH` and auto-logon entries under `Winlogon` commonly expose plaintext credentials
- Cloud metadata APIs (e.g., `http://169.254.169.254`) return IAM credentials to any process that can reach them — SSRF vulnerabilities are a common attack path
- Detection strategy: monitor for unusual processes reading credential files, alert on access to `/proc/*/environ` on Linux or registry credential paths on Windows

## Related concepts
[[T1003 OS Credential Dumping]] [[T1528 Steal Application Access Token]] [[T1078 Valid Accounts]] [[Secrets Management]] [[SSRF Server-Side Request Forgery]]