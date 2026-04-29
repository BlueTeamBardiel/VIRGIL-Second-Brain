# DevSecOps

## What it is
Like installing smoke detectors *during* construction instead of bolting them on after move-in, DevSecOps weaves security controls directly into every phase of the software development pipeline rather than auditing finished code at the end. It is a cultural and technical practice that integrates security into CI/CD workflows, making developers, security engineers, and operations teams jointly responsible for secure outcomes from the first commit to production deployment.

## Why it matters
In 2021, a Log4Shell-vulnerable dependency shipped inside countless enterprise applications because security scanning happened *after* release, not during build. Organizations with mature DevSecOps pipelines caught the vulnerable Log4j version in their software bill of materials (SBOM) within hours and deployed patches before active exploitation reached their systems — while others scrambled for weeks.

## Key facts
- **Shift-left security** is the core principle: move vulnerability testing earlier in the SDLC to reduce the cost and complexity of remediation.
- **SAST** (Static Application Security Testing) analyzes source code without execution; **DAST** (Dynamic Application Security Testing) tests running applications — both are automated gates in DevSecOps pipelines.
- **Infrastructure as Code (IaC) scanning** tools (e.g., Checkov, Terraform Sentinel) catch misconfigured cloud resources before they are provisioned.
- A **Software Bill of Materials (SBOM)** documents all components and dependencies, enabling rapid response to newly disclosed CVEs in third-party libraries.
- DevSecOps aligns with **NIST SP 800-218** (Secure Software Development Framework) and supports compliance with frameworks requiring continuous monitoring and audit trails.

## Related concepts
[[CI/CD Pipeline Security]] [[Static Application Security Testing]] [[Software Bill of Materials]] [[Threat Modeling]] [[Supply Chain Attack]]