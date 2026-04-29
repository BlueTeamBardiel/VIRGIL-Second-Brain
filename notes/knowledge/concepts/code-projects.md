# code-projects

## What it is
Like a blueprint shared in a public library where anyone can read it, copy it, or add graffiti — code-projects are structured collections of source code, assets, and documentation organized to build specific software applications. Precisely, a code project is a version-controlled repository (commonly hosted on platforms like GitHub or GitLab) containing all the components needed to compile, deploy, or run a piece of software.

## Why it matters
In 2021, attackers compromised the SolarWinds Orion build pipeline by injecting malicious code directly into the project's source during the build process — a supply chain attack that backdoored 18,000+ organizations. Defenders must treat code projects themselves as attack surfaces, applying integrity controls like signed commits, dependency pinning, and SAST (Static Application Security Testing) to catch malicious insertions before deployment.

## Key facts
- **Supply chain risk**: Malicious packages introduced into open-source code projects (e.g., typosquatting on npm or PyPI) can propagate to thousands of downstream consumers automatically.
- **Dependency confusion attacks** exploit how package managers resolve internal vs. public package names, allowing attackers to hijack builds by uploading higher-versioned packages to public registries.
- **SAST tools** (e.g., Bandit, SonarQube) scan code project source files for vulnerabilities before compilation — a key control in a DevSecOps pipeline.
- **Secrets exposure**: Hardcoded credentials (API keys, passwords) accidentally committed to code project repositories are a leading cause of cloud breaches; tools like `git-secrets` or truffleHog detect them.
- **CI/CD pipeline integrity**: Code projects connected to automated pipelines must have branch protection rules and signed artifacts to prevent unauthorized code injection between commit and deployment.

## Related concepts
[[Supply Chain Attacks]] [[Static Application Security Testing]] [[Software Composition Analysis]]