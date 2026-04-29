# Trivy

## What it is
Think of Trivy as a full-body X-ray scanner for your software supply chain — it examines container images, filesystems, and Git repos layer by layer, flagging hidden vulnerabilities before they reach production. Precisely, Trivy is an open-source vulnerability and misconfiguration scanner developed by Aqua Security that detects CVEs in OS packages and application dependencies, exposed secrets, and IaC misconfigurations across multiple target types.

## Why it matters
In 2021, attackers compromised the Codecov build pipeline and injected malicious code into a widely-used Docker image, affecting thousands of downstream organizations. A tool like Trivy integrated into CI/CD pipelines would surface unexpected dependency changes or known-vulnerable package versions before that image ever shipped, giving defenders an automated gate to catch supply chain tampering early.

## Key facts
- Trivy scans container images (Docker, OCI), filesystems, Git repositories, Kubernetes clusters, and IaC files (Terraform, CloudFormation, Dockerfile) from a single CLI tool
- Pulls vulnerability data from multiple databases including NVD, GitHub Advisory Database, and OS-specific sources (Alpine, RHEL, Debian)
- Supports secret scanning — detecting hardcoded API keys, passwords, and tokens using regex and entropy-based detection
- Outputs results in multiple formats including JSON, SARIF, and CycloneDX SBOM, making it CI/CD pipeline-friendly
- Runs in two modes: **client mode** (local scanning) and **client-server mode** (centralized scanning with shared vulnerability DB cache for performance)

## Related concepts
[[Software Bill of Materials (SBOM)]] [[Container Security]] [[CVE (Common Vulnerabilities and Exposures)]] [[CI/CD Pipeline Security]] [[Supply Chain Attack]]