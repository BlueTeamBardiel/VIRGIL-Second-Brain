# CVE Program

## What it is
Think of it like a universal ISBN system for books — but instead of tracking novels, it tracks vulnerabilities. The Common Vulnerabilities and Exposures (CVE) Program is a MITRE-maintained, federally funded catalog that assigns unique, standardized identifiers (CVE IDs) to publicly disclosed cybersecurity vulnerabilities, enabling consistent communication across vendors, researchers, and defenders worldwide.

## Why it matters
In 2021, the Log4Shell vulnerability (CVE-2021-44228) became one of the most critical flaws ever discovered in Apache Log4j. Because it had a CVE ID, security teams globally could immediately query their patch management tools, SIEMs, and vulnerability scanners using a single identifier — without ambiguity about which flaw was being discussed. Without CVE standardization, coordinating that response across thousands of organizations would have been chaotic.

## Key facts
- CVE IDs follow the format **CVE-[YEAR]-[NUMBER]** (e.g., CVE-2021-44228); the year reflects when the ID was assigned, not necessarily when the vulnerability was discovered
- **CVE Numbering Authorities (CNAs)** — including major vendors like Microsoft, Google, and Red Hat — are authorized to assign CVE IDs within their own product scope without going through MITRE directly
- The CVE Program is **separate from CVSS** (Common Vulnerability Scoring System); CVE identifies the vulnerability, while CVSS scores its severity
- CVE feeds directly into the **National Vulnerability Database (NVD)**, maintained by NIST, which enriches CVE entries with CVSS scores, CWE classifications, and remediation data
- A vulnerability must be **independently fixable** and affect one codebase to qualify for its own CVE ID — widespread library flaws affecting multiple products can generate multiple CVEs

## Related concepts
[[CVSS Scoring]] [[National Vulnerability Database (NVD)]] [[Vulnerability Management]] [[CWE]] [[Patch Management]]