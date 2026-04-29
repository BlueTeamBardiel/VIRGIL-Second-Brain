# CWE

## What it is
Think of it as a universal taxonomy for code defects — like the Dewey Decimal System, but instead of cataloging books, it catalogs the *types of mistakes* developers make that lead to vulnerabilities. The Common Weakness Enumeration (CWE) is a community-developed list maintained by MITRE that categorizes software and hardware weaknesses by their root cause, not by specific instances of exploitation.

## Why it matters
When a developer introduces an unchecked buffer in C code, that flaw gets classified as CWE-120 (Buffer Copy Without Checking Size of Input). Security tools like static analyzers use CWE identifiers to flag this weakness *before* deployment — preventing it from becoming a CVE that attackers exploit in the wild. Organizations use CWE to prioritize secure coding training by identifying which weakness classes appear most frequently in their codebase.

## Key facts
- CWE is maintained by MITRE and is distinct from CVE: CWE describes *weakness types*, CVE describes *specific vulnerabilities* in specific products
- The **CWE Top 25 Most Dangerous Software Weaknesses** is published annually and is directly relevant to secure development programs and exam scenarios
- CWE entries map to CAPEC (attack patterns) and CVE (specific instances), forming a connected knowledge chain
- CWE-79 (Cross-Site Scripting) and CWE-89 (SQL Injection) consistently appear in the Top 25 and are foundational to application security testing
- CVSS scores for CVEs often reference the underlying CWE to explain the *nature* of the vulnerability, aiding in remediation prioritization

## Related concepts
[[CVE]] [[CVSS]] [[CAPEC]] [[OWASP Top 10]] [[Static Analysis]]