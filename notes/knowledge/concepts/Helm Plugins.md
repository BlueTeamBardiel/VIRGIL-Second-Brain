# Helm Plugins

## What it is
Like browser extensions that bolt extra functionality onto Chrome, Helm plugins are add-ons that extend the Helm package manager's CLI with custom commands. They are executable binaries or scripts placed in `~/.local/share/helm/plugins/` that Helm discovers and runs as if they were native subcommands.

## Why it matters
In a 2019 supply chain attack vector, a malicious Helm plugin distributed via a public repository contained a backdoored binary that executed arbitrary commands with the privileges of the Kubernetes operator who installed it. Because Helm plugins run with the full OS permissions of the invoking user, a compromised plugin can exfiltrate kubeconfig credentials, pivot into the Kubernetes cluster, or deploy malicious workloads across production namespaces.

## Key facts
- Helm plugins are installed via `helm plugin install <URL>` and can pull from GitHub repos or arbitrary URLs — no signature verification is enforced by default
- Plugin scripts execute with the **same OS-level privileges** as the user running Helm, making privilege escalation a direct risk in CI/CD pipelines running as root
- The `install` hook script defined in `plugin.yaml` runs automatically on installation — a common malware persistence mechanism
- Plugins inherit environment variables including `HELM_KUBECONTEXT` and `KUBECONFIG`, giving them implicit access to cluster credentials without additional authentication
- Auditing installed plugins with `helm plugin list` and verifying source integrity (checksums, signed releases) is a critical hardening step for Kubernetes environments

## Related concepts
[[Supply Chain Attacks]] [[Kubernetes Security]] [[Privilege Escalation]] [[CI/CD Pipeline Security]]