# CWE-522 - Secrets Management

## What it is
Imagine hiding a house key under the doormat — everyone knows to look there, and the "protection" is theater. CWE-522 describes insufficiently protected credentials: passwords, API keys, tokens, and certificates stored in plaintext, hardcoded in source code, or transmitted without encryption. The weakness is not that secrets exist, but that they are handled carelessly enough that an attacker can retrieve them with minimal effort.

## Why it matters
In 2022, researchers scanning public GitHub repositories found thousands of AWS access keys committed directly into source code — attackers automated this scan and spun up crypto-mining infrastructure within minutes of discovery. A proper secrets management solution (HashiCorp Vault, AWS Secrets Manager) would have injected credentials at runtime, meaning nothing sensitive ever touches the codebase. The difference between exposed and protected here is measured in millions of dollars of unauthorized cloud spend.

## Key facts
- Hardcoded credentials are flagged under both CWE-522 and the related CWE-798 (Use of Hardcoded Credentials); CWE-522 is the broader parent category
- OWASP lists secrets mismanagement under **A02:2021 – Cryptographic Failures** and **A07:2021 – Identification and Authentication Failures**
- Secrets should follow a **rotation + least-privilege + audit trail** triad — storing them securely but never rotating is still a failing control
- Environment variables are safer than hardcoded strings but are NOT a secrets management solution — process dumps and misconfigured logging can expose them
- The NIST SP 800-63B standard governs credential storage requirements, requiring salted hashing (bcrypt, Argon2) for passwords at rest

## Related concepts
[[CWE-798 Hardcoded Credentials]] [[Cryptographic Failures OWASP]] [[Principle of Least Privilege]] [[Key Management]] [[Credential Stuffing]]