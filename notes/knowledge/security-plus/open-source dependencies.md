# open-source dependencies

## What it is
Like buying a house built with lumber from dozens of unknown suppliers — you own the house, but you're trusting every piece of wood in the walls. Open-source dependencies are third-party libraries and packages that a software project imports to avoid reinventing common functionality, where the consuming application inherits all security properties (and flaws) of that external code.

## Why it matters
In 2021, the Log4Shell vulnerability (CVE-2021-44228) exposed a critical flaw in Log4j, a logging library embedded in thousands of Java applications worldwide — including enterprise systems, cloud services, and government infrastructure. Organizations discovered they were vulnerable to remote code execution through software they didn't even know contained Log4j, simply because a dependency of a dependency had pulled it in silently.

## Key facts
- **Transitive dependencies** are the hidden risk: your app may directly import Library A, which imports Library B, which imports the vulnerable Library C — you never consciously chose C.
- A **Software Bill of Materials (SBOM)** is a formal inventory of all components in a software product; NIST and executive orders now push for SBOMs as a supply chain defense.
- **Dependency confusion attacks** trick package managers (npm, PyPI, pip) into downloading a malicious public package instead of a private internal one by exploiting namespace priority rules.
- **CVE scoring** applies to open-source components just like any software — tools like OWASP Dependency-Check and Snyk scan projects against the NVD to flag known-vulnerable packages.
- Unmaintained packages ("abandoned dependencies") represent a persistent risk because disclosed vulnerabilities will never receive patches from the original author.

## Related concepts
[[software supply chain attacks]] [[SBOM]] [[CVE and vulnerability scoring]]