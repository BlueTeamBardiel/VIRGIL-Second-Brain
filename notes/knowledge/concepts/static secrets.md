# static secrets

## What it is
Like a house key copied once and handed out to ten contractors — it never changes, anyone who had it yesterday still has it today. A static secret is a credential (password, API key, symmetric encryption key, or token) that is generated once and remains valid indefinitely unless manually rotated or revoked.

## Why it matters
In the 2022 GitHub token exposure incident pattern, developers frequently committed AWS API keys directly into public repositories. Because those keys were static, attackers could harvest them hours later and still authenticate with full validity — no expiration, no automatic invalidation. The fix isn't just removing the key from the repo; it requires immediate revocation and replacement.

## Key facts
- Static secrets are the primary target of credential harvesting attacks because their long lifespan maximizes attacker opportunity windows.
- They violate the principle of least privilege *over time* — even if access was appropriate when issued, circumstances change while the secret doesn't.
- Secrets management vaults (HashiCorp Vault, AWS Secrets Manager) address static secrets by enforcing rotation schedules and generating dynamic, short-lived credentials.
- Hardcoded static secrets in source code are flagged by SAST tools and are a top finding in security audits; this is explicitly covered under OWASP A02 (Cryptographic Failures).
- The countermeasure on Security+/CySA+ exams is **credential rotation** combined with **secrets scanning** in CI/CD pipelines to detect embedded secrets before deployment.

## Related concepts
[[credential rotation]] [[secrets management]] [[hardcoded credentials]] [[API key security]] [[least privilege]]