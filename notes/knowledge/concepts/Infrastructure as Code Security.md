# Infrastructure as Code Security

## What it is
Like a blueprint for a skyscraper that contractors follow exactly — if the blueprint has a flaw, every building made from it inherits that flaw. Infrastructure as Code (IaC) is the practice of defining and provisioning cloud infrastructure (servers, networks, permissions) through machine-readable configuration files (Terraform, CloudFormation, Ansible) rather than manual clicks, meaning security misconfigurations in templates propagate instantly and at scale.

## Why it matters
In 2019, Capital One was breached partly because an over-permissive IAM role was provisioned into AWS infrastructure — exactly the kind of misconfiguration that lives in an IaC template. Had that template been scanned with a tool like Checkov or tfsec before deployment, the excessive permissions granting SSRF-exploitable metadata access could have been caught before a single server was spun up.

## Key facts
- **Shift-left security**: IaC enables scanning for misconfigurations *before* deployment using static analysis tools (Checkov, tfsec, KICS), reducing remediation cost by catching issues in the pipeline
- **Hardcoded secrets** in IaC templates (API keys, passwords) are a critical finding — tools like truffleHog or git-secrets scan repos specifically for this
- **Immutable infrastructure**: IaC promotes replacing servers rather than patching them, reducing configuration drift and unauthorized in-place changes
- **Least privilege violations** are the most common IaC security finding — overly broad IAM policies and open security groups (0.0.0.0/0) baked into templates
- IaC files stored in version control (Git) require branch protection and peer review as security controls; a malicious commit can redeploy vulnerable infrastructure automatically via CI/CD

## Related concepts
[[Cloud Security Misconfiguration]] [[CI/CD Pipeline Security]] [[Secrets Management]] [[Least Privilege]] [[Shift-Left Security]]