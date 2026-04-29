# CVE and NVD

## What it is
Think of CVE as the universal barcode system for vulnerabilities — every known flaw gets a unique SKU so every vendor, scanner, and analyst is talking about the same thing. CVE (Common Vulnerabilities and Exposures) is a standardized identifier system maintained by MITRE that assigns unique IDs (e.g., CVE-2021-44228) to publicly disclosed vulnerabilities. The NVD (National Vulnerability Database), maintained by NIST, enriches those CVE records with severity scores (CVSS), patch information, and affected product lists.

## Why it matters
When Log4Shell (CVE-2021-44228) dropped in December 2021, security teams globally used that single CVE identifier to immediately cross-reference their asset inventories, query their vulnerability scanners, and prioritize patching — without ambiguity about which flaw was being discussed. Without CVE, one vendor might call it "Apache Remote Code Execution Bug #7" while another calls it "Log4j Critical Flaw," creating dangerous confusion during incident response.

## Key facts
- CVE IDs follow the format **CVE-[YEAR]-[SEQUENCE]**; MITRE assigns them through authorized CVE Numbering Authorities (CNAs)
- NVD uses **CVSS (Common Vulnerability Scoring System)** to score severity from 0.0–10.0; scores above 9.0 are Critical
- CVE entries contain minimal data (description, ID, references); NVD adds CVSS scores, CPE (affected products), and remediation guidance
- A vulnerability can exist in CVE without yet appearing in NVD — there is a processing lag
- Security tools like Nessus, Qualys, and OpenVAS map scan findings directly to CVE IDs for standardized reporting

## Related concepts
[[CVSS Scoring]] [[Vulnerability Management]] [[Patch Management]] [[Threat Intelligence]] [[MITRE ATT&CK]]