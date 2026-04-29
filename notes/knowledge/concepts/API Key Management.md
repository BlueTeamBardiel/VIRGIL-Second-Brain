# API Key Management

## What it is
Think of an API key like a valet parking ticket — it grants specific, limited access without handing over the master keys. Precisely defined: API key management is the lifecycle governance of cryptographic tokens used to authenticate applications and services to APIs, covering creation, rotation, storage, auditing, and revocation.

## Why it matters
In 2022, Samsung engineers accidentally pushed source code to public GitHub repositories containing AWS API keys hardcoded in the codebase. Attackers who find exposed keys can immediately impersonate the legitimate application — calling paid services, exfiltrating data, or pivoting into cloud infrastructure — often before the organization even detects the exposure.

## Key facts
- **Never hardcode keys in source code** — use environment variables or secrets managers (AWS Secrets Manager, HashiCorp Vault) instead; keys in repos are scraped by automated bots within minutes of exposure
- **Rotate keys regularly and immediately after suspected compromise** — rotation limits the window of exploitation for any stolen credential
- **Apply least privilege** — API keys should be scoped to only the endpoints and actions the application actually needs, not granted blanket admin access
- **Audit and monitor key usage** — abnormal call volumes, off-hours access, or unexpected geographic origins are indicators of key compromise
- **Key length and entropy matter** — modern API keys should be at least 128 bits of randomness; short or predictable keys are vulnerable to brute-force enumeration

## Related concepts
[[Secrets Management]] [[Least Privilege]] [[OAuth 2.0]] [[Credential Exposure]] [[Zero Trust Architecture]]