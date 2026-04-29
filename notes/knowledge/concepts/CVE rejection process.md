# CVE rejection process

## What it is
Like a patent office rejecting a duplicate invention claim, the CVE program rejects vulnerability submissions that fail to meet specific criteria for uniqueness, scope, or documentation. Formally, CVE rejection occurs when the CVE Numbering Authority (CNA) or MITRE determines that a submitted CVE ID cannot be published because the vulnerability is out of scope, a duplicate of an existing entry, or lacks sufficient evidence to distinguish it as a discrete flaw.

## Why it matters
In 2021, researchers discovered that many "new" vulnerabilities in open-source libraries were being submitted as fresh CVEs when they were already tracked under existing identifiers — causing organizations to double-patch or miss mitigations entirely. Understanding the rejection process helps security teams avoid acting on phantom CVEs and ensures vulnerability management programs aren't bloated with noise that obscures real risk prioritization.

## Key facts
- A CVE is rejected (marked **REJECTED**) rather than deleted — the ID remains visible with a rejection notice to prevent ID reuse or confusion
- Common rejection reasons: **duplicate of existing CVE**, **not a vulnerability** (e.g., intended behavior), **out of scope for CVE program**, or **insufficient information**
- Rejected CVEs display the status tag `REJECTED` in the NVD and CVE database, but no CVSS score is assigned
- CNAs have authority to reject CVEs within their own scope; MITRE handles disputes and out-of-scope submissions
- A single vulnerability affecting multiple products requires only **one CVE ID** — submitting separate IDs per product is a common rejection trigger

## Related concepts
[[CVE Numbering Authority (CNA)]] [[Common Vulnerabilities and Exposures (CVE)]] [[National Vulnerability Database (NVD)]] [[CVSS scoring]] [[vulnerability disclosure policy]]