# CWE-798 - Use of Hard-coded Credentials

## What it is
Imagine a hotel that uses the same master key for every room, forever, with the key's serial number stamped on the front door — that's hard-coded credentials. This weakness occurs when a developer embeds a static username, password, or cryptographic key directly in source code or binary, making it immutable without a code patch and discoverable by anyone who reads the code.

## Why it matters
In 2022, researchers found hard-coded credentials in Cisco's Emergency Responder software (CVE-2023-20101) — a root account with a fixed password that could never be changed, granting full device access to any attacker who read the advisory. This is why public GitHub repositories are continuously scraped by threat actors specifically hunting for committed API keys, database passwords, and AWS secrets.

## Key facts
- Hard-coded credentials are classified under **CWE-798**, with two child weaknesses: CWE-259 (hard-coded password) and CWE-321 (hard-coded cryptographic key)
- Tools like **truffleHog**, **GitLeaks**, and **git-secrets** are specifically designed to detect credential strings in version control history — including deleted commits
- The CVSS scores for hard-coded credential vulnerabilities frequently reach **9.8 (Critical)** because exploitation requires no privileges and no user interaction
- Remediation requires replacing static credentials with **externalized secrets management** (e.g., HashiCorp Vault, AWS Secrets Manager) and rotating all exposed credentials immediately
- Hard-coded credentials violate **NIST SP 800-53 IA-5** (Authenticator Management) and appear on the **OWASP Top 10** under A07:2021 (Identification and Authentication Failures)

## Related concepts
[[CWE-259 Hard-coded Password]] [[Secrets Management]] [[Credential Exposure]] [[Static Code Analysis]] [[Principle of Least Privilege]]