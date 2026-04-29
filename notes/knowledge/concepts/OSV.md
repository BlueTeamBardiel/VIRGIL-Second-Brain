# OSV

## What it is
Think of OSV like a universal blood type label for software vulnerabilities — a standardized tag that any package manager, language ecosystem, or security scanner can read without translation. OSV (Open Source Vulnerability) is an open vulnerability schema and database format developed by Google that provides a machine-readable, precise way to describe vulnerabilities in open source packages, including exact affected version ranges.

## Why it matters
When a critical vulnerability like Log4Shell (CVE-2021-44228) hits, security teams scramble to identify every affected dependency across Java, Python, Go, and npm projects simultaneously. OSV allows a single tool like `osv-scanner` to query multiple ecosystems at once using a unified format, dramatically reducing the triage time from days to minutes by matching your dependency lockfiles against a consolidated, structured vulnerability feed.

## Key facts
- OSV is backed by Google and aggregates data from multiple sources including GitHub Advisory Database, PyPI, npm, crates.io, and dozens of other ecosystems into one queryable schema
- The schema uses **precise version ranges** (introduced, fixed, last_affected) rather than vague CVSS descriptions, making automated dependency scanning more accurate
- OSV differs from NVD (National Vulnerability Database) in that it is **ecosystem-native** — vulnerabilities are mapped directly to package names and versions, not just CPE strings
- The `osv-scanner` CLI tool is open source and can scan dependency manifests (e.g., `package-lock.json`, `go.sum`, `requirements.txt`) directly against the OSV database
- OSV records use a JSON format and are accessible via a public API at `api.osv.dev`, enabling integration into CI/CD pipelines for automated SCA (Software Composition Analysis)

## Related concepts
[[Software Composition Analysis]] [[CVE]] [[SBOM]] [[NVD]] [[Dependency Confusion]]