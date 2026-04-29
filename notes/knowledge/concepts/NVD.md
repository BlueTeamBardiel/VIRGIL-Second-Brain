# NVD

## What it is
Think of it as the Library of Congress for software vulnerabilities — every known flaw gets catalogued, indexed, and enriched with standardized metadata so anyone can look it up. The National Vulnerability Database (NVD) is a U.S. government repository maintained by NIST that builds upon CVE entries by adding severity scores (CVSS), weakness classifications (CWE), and affected product data (CPE). It transforms a raw vulnerability ID into an actionable intelligence record.

## Why it matters
When Log4Shell (CVE-2021-44228) dropped in December 2021, security teams worldwide raced to the NVD entry to pull its CVSS score (10.0 — maximum), affected versions, and patch guidance within hours. Without NVD's standardized enrichment, every organization would have independently researched the same vulnerability instead of spending time patching it. Defenders use NVD feeds to automate vulnerability prioritization in scanners like Tenable Nessus and Qualys.

## Key facts
- NVD is maintained by **NIST** and syncs with MITRE's CVE list, adding enrichment data CVE itself doesn't include
- Each NVD entry includes a **CVSS score** (v2, v3.x, or v4.0), which quantifies severity across Base, Temporal, and Environmental metrics
- **CPE (Common Platform Enumeration)** within NVD entries identifies exactly which vendor products/versions are affected — critical for automated asset matching
- **CWE (Common Weakness Enumeration)** tags identify the underlying flaw class (e.g., CWE-79 = XSS), enabling trend analysis across vulnerability types
- NVD offers a **public API** that security tools use to pull real-time vulnerability data for continuous monitoring programs

## Related concepts
[[CVE]] [[CVSS]] [[CWE]] [[CPE]] [[Vulnerability Management]]