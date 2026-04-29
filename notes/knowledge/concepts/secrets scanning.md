# secrets scanning

## What it is
Like a postal inspector running every outgoing letter through a metal detector for contraband, secrets scanning automatically inspects code repositories and pipelines for hardcoded credentials before they escape into the wild. It is the automated detection of sensitive values — API keys, passwords, private keys, OAuth tokens, and connection strings — embedded directly in source code, configuration files, or commit history.

## Why it matters
In 2022, Toyota exposed a GitHub repository containing a hardcoded access key for their customer data system for nearly five years — affecting 296,000 customers — because no automated scanning was in place to catch it. A properly configured secrets scanner running in the CI/CD pipeline would have blocked that commit at the moment of push, preventing the entire exposure.

## Key facts
- **Git history is permanent**: even if a secret is deleted in a later commit, it remains readable in earlier commits unless the history is actively rewritten with tools like `git filter-repo`
- **Pre-commit hooks** (using tools like `git-secrets`, `detect-secrets`, or `truffleHog`) catch secrets *before* they ever reach the remote repository — the earliest and cheapest intervention point
- **Entropy analysis** is a detection technique that flags high-randomness strings (like API keys) even when they don't match a known pattern — reducing false negatives at the cost of false positives
- **Regex pattern libraries** maintained by tools like GitHub Advanced Security and GitGuardian cover thousands of known secret formats (AWS keys, Stripe tokens, etc.) for high-confidence detection
- Secrets scanners should be integrated at three layers: **IDE** (developer machine), **pre-commit hook** (local gate), and **CI/CD pipeline** (organizational gate) — defense in depth for the pipeline

## Related concepts
[[credential exposure]] [[CI/CD pipeline security]] [[static application security testing]] [[hardcoded credentials]] [[supply chain security]]