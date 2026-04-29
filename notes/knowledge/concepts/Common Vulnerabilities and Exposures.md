# Common Vulnerabilities and Exposures

## What it is
Think of CVE like a universal SKU barcode system for a grocery store — every product gets a unique identifier so any store, anywhere, can unambiguously refer to the exact same item. CVE is a standardized naming scheme maintained by MITRE that assigns unique identifiers (e.g., CVE-2021-44228) to publicly known security vulnerabilities, ensuring vendors, researchers, and defenders all speak the same language when discussing a specific flaw.

## Why it matters
When Log4Shell was discovered in December 2021, it was assigned CVE-2021-44228, allowing every security team worldwide to immediately correlate threat intelligence, scanner results, and vendor patches to the *same* vulnerability without ambiguity. Without CVE, a defender might patch "Apache logging bug" while their SIEM was alerting on "Log4j RCE" — leaving them blind to whether they'd actually addressed the threat.

## Key facts
- CVE identifiers follow the format **CVE-[year]-[sequence number]**; the year reflects when it was assigned, not necessarily when it was discovered
- **MITRE Corporation** maintains the CVE list; the **National Vulnerability Database (NVD)**, run by NIST, enriches CVEs with **CVSS scores**, patch info, and references
- **CVSS (Common Vulnerability Scoring System)** scores range from 0.0–10.0 and are separate from CVE — CVE identifies the flaw, CVSS quantifies its severity
- **CVE Numbering Authorities (CNAs)** — including major vendors like Microsoft and Google — are authorized to assign CVE IDs directly without going through MITRE
- A vulnerability must be **independently fixable** and affect a single codebase to qualify for its own CVE entry

## Related concepts
[[CVSS Scoring]] [[National Vulnerability Database]] [[Patch Management]] [[Vulnerability Scanning]] [[Zero-Day Vulnerability]]