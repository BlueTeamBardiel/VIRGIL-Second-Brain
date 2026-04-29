# Version Control

## What it is
Like a surgeon who photographs every step of an operation so any mistake can be traced and reversed, version control is a system that records every change made to files over time, allowing you to recall specific versions later. Precisely: it is a methodology and toolset (e.g., Git, SVN) for tracking modifications to code, configurations, or documents, maintaining a complete history of who changed what, when, and why.

## Why it matters
In 2020, attackers compromised SolarWinds' build pipeline and injected malicious code into the Orion software updates — a supply chain attack that version control auditing and code signing could have flagged earlier by detecting unauthorized commits. Security teams use version control logs as forensic evidence to identify when malicious code was introduced, by which account, and from which IP. Without it, determining the blast radius of a insider threat or compromised developer credential becomes nearly impossible.

## Key facts
- **Commit history as an audit trail:** Every change is timestamped and attributed to a user, making it a native integrity-monitoring mechanism for source code.
- **Branch protection rules** enforce that no code reaches production without peer review or CI/CD security scanning — a key DevSecOps control.
- **Exposed `.git` directories** on misconfigured web servers are a known attack vector, leaking full source code and secrets (API keys, credentials) to attackers.
- **Secrets in commit history** persist even after deletion; tools like `git log` and `truffleHog` can retrieve hardcoded credentials from old commits.
- **Integrity verification:** Combined with cryptographic signing (GPG-signed commits), version control supports non-repudiation — a core security principle tested on Security+.

## Related concepts
[[Supply Chain Security]] [[DevSecOps]] [[Integrity]] [[Non-Repudiation]] [[Secrets Management]]