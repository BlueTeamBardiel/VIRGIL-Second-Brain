# YAML

## What it is
Like a recipe card written in plain English instead of chemical formulas — YAML (YAML Ain't Markup Language) is a human-readable data serialization format that uses indentation and key-value pairs to represent structured data. It's commonly used for configuration files, CI/CD pipelines, and infrastructure-as-code definitions where readability matters more than compactness.

## Why it matters
In 2022, attackers exploited misconfigured GitHub Actions YAML workflow files to inject malicious commands into CI/CD pipelines — a technique called **pipeline injection**. Because YAML parsers interpret certain characters and anchors in unexpected ways, a single unvalidated input in a `.github/workflows/*.yml` file can execute arbitrary code with repository privileges, silently exfiltrating secrets or poisoning build artifacts.

## Key facts
- **YAML anchors and aliases** (`&anchor` / `*alias`) enable recursive structures that can trigger a **Billion Laughs attack** (YAML bomb) — exponential memory expansion causing denial of service in unprotected parsers
- YAML allows **implicit type coercion**: the string `yes`, `true`, `on`, and `1` all parse as Boolean `true` in many parsers, creating logic bypass vulnerabilities in access control checks
- **Deserialization attacks** are a significant risk — Python's `PyYAML` using `yaml.load()` (without `Loader=yaml.SafeLoader`) executes arbitrary Python objects, equivalent to remote code execution
- YAML is the primary format for **Kubernetes manifests** and **Ansible playbooks**, meaning misconfiguration can grant attackers cluster-admin privileges or lateral movement across infrastructure
- The safe practice is always using **restricted/safe loaders** and validating YAML schema with tools like `yamllint` or OPA/Conftest before deployment

## Related concepts
[[Deserialization Attacks]] [[Supply Chain Security]] [[Infrastructure as Code Security]]