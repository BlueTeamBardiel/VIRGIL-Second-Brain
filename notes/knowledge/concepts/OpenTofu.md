# OpenTofu

## What it is
Like a community-maintained recipe book after a restaurant chain locks away its original cookbook, OpenTofu is the open-source fork of HashiCorp's Terraform that emerged after HashiCorp changed Terraform's license from open-source (MPL 2.0) to the Business Source License (BUSL) in 2023. Maintained by the Linux Foundation, it provides infrastructure-as-code (IaC) tooling that lets teams define, provision, and manage cloud infrastructure through declarative configuration files.

## Why it matters
In a supply chain security scenario, organizations using Terraform discovered that HashiCorp's license change could restrict commercial use of the tool, forcing a rapid audit of their IaC pipelines for compliance risk. Security teams evaluating OpenTofu must still apply the same IaC hardening practices — securing state files containing plaintext secrets, enforcing least-privilege provider credentials, and scanning `.tf` files for hardcoded API keys — because the attack surface is nearly identical to Terraform's.

## Key facts
- OpenTofu state files (`.tfstate`) frequently contain **plaintext sensitive values** such as database passwords and API keys, making secure remote state storage (encrypted S3 buckets, etc.) a critical control
- Forked under the **Linux Foundation** governance model in 2023; first stable release was **OpenTofu 1.6.0** (January 2024)
- Inherits Terraform's **provider plugin model**, meaning malicious or compromised providers in the registry represent a software supply chain attack vector
- IaC misconfigurations (e.g., open security groups, public S3 buckets defined in `.tf` files) are a primary source of cloud breaches — scanners like **Checkov** or **tfsec** apply directly to OpenTofu configs
- Relevant to **CIS Benchmarks** and **NIST SP 800-53 CM-2** (Baseline Configuration) compliance frameworks

## Related concepts
[[Infrastructure as Code Security]] [[Supply Chain Attacks]] [[Secrets Management]] [[Cloud Misconfiguration]] [[Terraform]]