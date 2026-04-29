# go-getter

## What it is
Think of go-getter like a delivery driver who will pick up packages from *anywhere* — your local warehouse, a remote storage unit, or even a suspicious back-alley address — without asking questions. In security contexts, `go-getter` is a Go library (and CLI tool) that downloads files and directories from various sources (HTTP, Git, S3, etc.) using a flexible URL scheme. It is widely used by tools like Terraform and Packer to fetch remote modules and configurations.

## Why it matters
Attackers targeting Infrastructure-as-Code pipelines exploit go-getter's permissive URL parsing to perform **path traversal and SSRF attacks**. For example, a malicious Terraform module can craft a go-getter URL using the `archive` or `file` subaddressing syntax to extract files outside the intended directory, or force the build server to make internal network requests — effectively turning your CI/CD runner into a pivot point into the internal network.

## Key facts
- go-getter supports multiple protocols: `git::`, `s3::`, `gcs::`, `http::`, and local `file::` — each with distinct security boundaries
- CVE-2024-3817 and earlier CVEs in go-getter involve **path traversal via malicious archive files** (zip-slip variant) during extraction
- The `//` double-slash syntax in go-getter URLs separates the repository URL from a subdirectory path — mishandling this enables directory escape
- Terraform and Nomad historically shipped with vulnerable go-getter versions, making **supply chain attacks on IaC** a realistic threat
- Mitigations include pinning module sources to specific commit hashes and restricting outbound network access from CI/CD runners

## Related concepts
[[Path Traversal]] [[Server-Side Request Forgery]] [[Supply Chain Attack]] [[Infrastructure as Code Security]]