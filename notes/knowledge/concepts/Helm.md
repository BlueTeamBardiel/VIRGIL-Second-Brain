# Helm

## What it is
Think of Helm as the `apt` or `yum` package manager for Kubernetes — instead of manually writing dozens of YAML manifests, you bundle them into a versioned "chart" and deploy with a single command. Precisely, Helm is a package manager for Kubernetes that templates, versions, and deploys collections of resources (called charts) to a cluster.

## Why it matters
In 2019, misconfigured Helm v2 deployments left Tiller — Helm's server-side component — exposed with cluster-admin privileges and no authentication, allowing attackers to deploy arbitrary workloads across entire clusters. This became a well-known supply chain and privilege escalation vector, directly prompting the architectural overhaul in Helm v3, which eliminated Tiller entirely.

## Key facts
- **Helm v2 vs v3**: Helm v2 used a server-side component called Tiller with excessive RBAC permissions; Helm v3 removed Tiller and uses the caller's kubeconfig credentials instead, dramatically reducing the attack surface.
- **Charts**: A chart is a directory of templated YAML files plus a `values.yaml` file; compromising a public chart repository (e.g., artifact hub) enables supply chain attacks via malicious templates.
- **Releases**: Each deployment of a chart is called a "release," stored as Kubernetes Secrets by default — attackers with Secret read access can extract full deployment configurations.
- **Repositories**: Helm pulls charts from HTTP/S repositories; organizations should use private, signed registries and validate chart provenance using Helm's built-in `--verify` flag and GPG signatures.
- **Secrets management risk**: Sensitive values passed via `--set password=abc` appear in shell history and Kubernetes Secret objects; best practice is using external secrets managers (Vault, AWS Secrets Manager) instead.

## Related concepts
[[Kubernetes RBAC]] [[Container Security]] [[Supply Chain Attack]] [[Secrets Management]] [[Least Privilege]]