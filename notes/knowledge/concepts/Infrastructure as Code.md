# Infrastructure as Code

## What it is
Think of it like a blueprint for a skyscraper — instead of verbally telling construction crews what to build each time, you hand them precise, repeatable architectural drawings. Infrastructure as Code (IaC) is the practice of defining and provisioning computing infrastructure (servers, networks, firewalls, cloud resources) through machine-readable configuration files rather than manual processes or interactive tools. Tools like Terraform, Ansible, and AWS CloudFormation treat infrastructure the same way developers treat software: versioned, reviewed, and deployed automatically.

## Why it matters
In 2020, a misconfigured AWS S3 bucket exposed sensitive data at a major financial firm — the bucket was spun up manually, bypassing security review. Had IaC templates with enforced encryption and access controls been used, that configuration drift would have been impossible; the bucket couldn't have been created out-of-policy. IaC enables security guardrails to be baked into the deployment pipeline, not bolted on afterward.

## Key facts
- **Configuration drift** — the gap between documented and actual infrastructure state — is a primary security risk that IaC eliminates by enforcing declared-state consistency
- IaC files stored in version control (Git) create an **audit trail** of every infrastructure change, supporting forensic investigation and compliance requirements
- **Secrets sprawl** is a critical IaC vulnerability: hard-coded credentials in Terraform or Ansible files committed to public repos are a top cloud breach vector
- Security scanning tools (Checkov, tfsec, KICS) perform **static analysis on IaC templates** before deployment, catching misconfigurations like open security groups or unencrypted storage
- IaC supports **immutable infrastructure** — instead of patching live systems, you destroy and redeploy from a clean template, reducing attacker persistence opportunities

## Related concepts
[[Configuration Management]] [[DevSecOps]] [[Cloud Security]] [[Least Privilege]] [[CI/CD Pipeline Security]]