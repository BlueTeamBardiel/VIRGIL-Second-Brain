# Gitleaks

## What it is
Like a metal detector sweeping a beach for buried coins, Gitleaks scans Git repositories — commit history and all — hunting for buried secrets developers accidentally left behind. It is an open-source SAST tool that uses regex patterns and entropy analysis to detect hardcoded credentials, API keys, tokens, and other sensitive data in source code repositories.

## Why it matters
In 2022, a Toyota contractor accidentally pushed source code to a public GitHub repository containing an access key for a cloud environment — exposing 296,000 customer records for nearly five years. Gitleaks (or a similar tool) running in a pre-commit hook or CI/CD pipeline would have blocked that commit before it ever reached the remote repository, catching the secret at the earliest possible moment.

## Key facts
- Gitleaks can scan entire Git **commit history**, not just current file state — meaning secrets deleted in a later commit are still discoverable
- Supports two primary modes: **protect** (pre-commit hook, blocks secrets before commit) and **detect** (scans existing repos for historical leaks)
- Uses a combination of **regex rules** and **Shannon entropy scoring** to reduce false negatives on high-randomness strings like tokens
- Findings are output in structured formats (JSON, SARIF) enabling integration with **SIEM platforms** and security dashboards for triaging
- Classified as a **secrets detection tool** within the broader SAST/SCA category; relevant to supply chain security controls under frameworks like NIST SP 800-161 and SLSA

## Related concepts
[[Static Application Security Testing]] [[CI/CD Pipeline Security]] [[Secrets Management]] [[Supply Chain Security]] [[Git Repository Exposure]]