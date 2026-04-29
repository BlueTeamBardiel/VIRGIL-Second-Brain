# CI-CD Pipeline

## What it is
Think of it like a factory assembly line where raw code enters one end and a tested, deployed application exits the other — automatically, without a human touching each station. A CI/CD (Continuous Integration/Continuous Deployment) pipeline is an automated software delivery chain that builds, tests, and deploys code changes whenever a developer pushes updates to a repository. It collapses the gap between writing code and shipping it to production, often completing the full cycle in minutes.

## Why it matters
In the 2020 SolarWinds supply chain attack, adversaries injected malicious code directly into the build pipeline, meaning the compromised payload was automatically signed, packaged, and distributed to ~18,000 customers as a "trusted" update. This demonstrates that a pipeline without integrity controls (code signing, artifact verification, isolated build environments) becomes a force multiplier for attackers — turning your own deployment automation against you.

## Key facts
- **Pipeline poisoning** occurs when an attacker compromises a build server or SCM (e.g., GitHub Actions workflow) to inject malicious code before it reaches production
- **Secrets sprawl** is a top CI/CD risk — hardcoded API keys and credentials in pipeline config files (`.yml`, `.env`) are routinely scraped by attackers scanning public repos
- **SLSA (Supply-chain Levels for Software Artifacts)** is a security framework specifically designed to establish integrity standards across build pipelines
- Build environments should be **ephemeral and isolated** — a fresh container per build prevents artifact poisoning from persisting between runs
- **Shift-left security** (SAST, dependency scanning, secrets detection) embeds security checks early in the pipeline rather than as a final gate

## Related concepts
[[Supply Chain Attack]] [[Software Composition Analysis]] [[Secrets Management]] [[Code Signing]] [[DevSecOps]]