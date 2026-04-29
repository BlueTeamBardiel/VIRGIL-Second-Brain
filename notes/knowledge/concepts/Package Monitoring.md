# Package Monitoring

## What it is
Like a mail room clerk who logs every package entering a building — noting the sender, weight, and contents — package monitoring tracks software libraries and dependencies being installed in a development environment or production system. It is the continuous auditing of third-party packages for malicious code, unexpected updates, version changes, or known vulnerabilities against databases like the NVD.

## Why it matters
In the 2021 **ua-parser-js** attack, a threat actor hijacked a legitimate npm package used by millions of projects, pushing a malicious version that installed a cryptominer and credential-stealing malware. Organizations with package monitoring in place could detect the unexpected version bump or flagged hash mismatch before execution; those without it were silently compromised at scale.

## Key facts
- **Dependency confusion attacks** exploit package managers (npm, PyPI, pip) by publishing a malicious public package with the same name as an internal private one, causing the manager to fetch the attacker's version
- Package monitoring tools (e.g., **Snyk, Dependabot, OWASP Dependency-Check**) compare installed packages against CVE databases and alert on vulnerable or tampered versions
- **Software Bill of Materials (SBOM)** is a formal inventory of all packages in a project; NIST and U.S. Executive Order 14028 now require SBOMs for federal software supply chains
- Hash verification (SHA-256 checksums or **package signing with Sigstore**) confirms a downloaded package hasn't been tampered with between the registry and the developer
- Typosquatting — registering packages like `reqeusts` instead of `requests` — is a common attack vector that package monitoring tools flag via name-similarity analysis

## Related concepts
[[Software Supply Chain Security]] [[Dependency Confusion]] [[Software Bill of Materials (SBOM)]]