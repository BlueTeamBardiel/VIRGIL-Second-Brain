# Credential Exposure

## What it is
Like leaving your house keys photocopied on a public bulletin board, credential exposure occurs when authentication secrets (usernames, passwords, API keys, tokens, or certificates) become accessible to unauthorized parties. This can happen through misconfigured repositories, unencrypted storage, verbose error messages, or data breaches — making valid credentials available without the attacker needing to crack anything.

## Why it matters
In 2021, a researcher discovered thousands of AWS secret keys hardcoded directly into public GitHub repositories, allowing anyone to authenticate as those developers and access cloud infrastructure. This illustrates why credential exposure is often more dangerous than a brute-force attack — the attacker skips the "breaking in" phase entirely and walks through the front door with legitimate credentials.

## Key facts
- **Hardcoded credentials** in source code are a Top 10 OWASP vulnerability (A07: Identification and Authentication Failures) and a frequent finding in penetration tests
- **Credential stuffing** attacks depend entirely on exposed credentials from prior breaches, using tools like Sentry MBA or Snipr to automate testing across multiple sites
- **Have I Been Pwned (HIBP)** is a primary resource used in CySA+ scenarios to detect whether organizational email credentials appear in known breach datasets
- **Secrets management tools** (HashiCorp Vault, AWS Secrets Manager) are the recommended countermeasure — rotating and vaulting credentials rather than embedding them statically
- **MITRE ATT&CK T1552** (Unsecured Credentials) catalogs adversary techniques including credentials in files, registry, bash history, and cloud metadata services

## Related concepts
[[Credential Stuffing]] [[Password Spraying]] [[Multi-Factor Authentication]] [[Secrets Management]] [[Data Breach]]