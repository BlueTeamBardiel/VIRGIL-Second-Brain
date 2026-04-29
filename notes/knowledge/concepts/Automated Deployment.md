# Automated Deployment

## What it is
Like a factory assembly line stamping out identical cars with zero variation, automated deployment uses scripts and pipelines to push code, configurations, or infrastructure to production environments without manual intervention. Precisely: it is the use of CI/CD (Continuous Integration/Continuous Deployment) tooling—such as Jenkins, GitHub Actions, or Ansible—to automatically build, test, and release software or system changes at scale and speed.

## Why it matters
In 2020, attackers compromised SolarWinds' build pipeline and injected malicious code into the Orion software's automated deployment process, delivering backdoored updates to ~18,000 organizations simultaneously. This demonstrates that automated deployment pipelines are high-value targets—a single poisoned step in the pipeline propagates malicious changes across an entire enterprise fleet instantly, making pipeline integrity a critical security control.

## Key facts
- **Supply chain risk**: Compromising a CI/CD pipeline (build server, repo credentials, or dependency registry) allows attackers to weaponize legitimate update mechanisms at massive scale.
- **Secrets sprawl**: Automated pipelines frequently mishandle credentials—hardcoded API keys and tokens in pipeline scripts are a top misconfiguration finding.
- **Infrastructure as Code (IaC)**: Automated deployment often relies on IaC tools (Terraform, CloudFormation); misconfigured templates deployed automatically can expose entire cloud environments.
- **Immutable infrastructure**: A security best practice where deployed artifacts are never modified post-deployment—compromised instances are destroyed and redeployed from a clean baseline rather than patched in place.
- **Pipeline hardening controls**: Include signed commits, artifact signing/verification (e.g., Sigstore), least-privilege service accounts for deployment agents, and mandatory security scanning gates before promotion to production.

## Related concepts
[[CI/CD Pipeline Security]] [[Supply Chain Attack]] [[Infrastructure as Code]] [[Secrets Management]] [[Software Bill of Materials (SBOM)]]