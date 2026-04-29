# Terraform

## What it is
Like an architect's blueprint that automatically constructs an entire city from scratch — or tears it down and rebuilds it identically elsewhere — Terraform is an Infrastructure-as-Code (IaC) tool by HashiCorp that lets you define cloud infrastructure (servers, networks, firewalls) in declarative configuration files and provision it automatically. It supports multi-cloud environments including AWS, Azure, and GCP through a unified workflow.

## Why it matters
A misconfigured Terraform template committing an AWS S3 bucket with `acl = "public-read"` to a Git repository can expose sensitive data to the entire internet the moment it's deployed — and that same misconfiguration gets replicated across every environment that inherits the template. Conversely, security teams use Terraform with policy-as-code tools like HashiCorp Sentinel or Open Policy Agent to enforce that *no* deployment can create an unencrypted database or overly permissive security group, making secure configuration the default rather than the exception.

## Key facts
- Terraform state files (`.tfstate`) often contain plaintext secrets, credentials, and resource metadata — storing them unencrypted in version control is a critical vulnerability
- IaC misconfigurations are scannable by tools like **Checkov**, **tfsec**, and **Terrascan** before deployment, enabling shift-left security
- Terraform uses a **plan → apply** workflow; the `plan` stage is a key control point to detect dangerous changes before they reach production
- Compromising a CI/CD pipeline with Terraform access can lead to **infrastructure takeover** — a high-value lateral movement target
- Least privilege for Terraform execution roles is a CIS Benchmark requirement; overly permissive IAM roles attached to Terraform runners are a common misconfiguration finding

## Related concepts
[[Infrastructure as Code]] [[CI/CD Pipeline Security]] [[Cloud Misconfiguration]] [[Secrets Management]] [[Policy as Code]]