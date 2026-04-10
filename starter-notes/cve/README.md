# CVE Notes

This directory contains individual notes for CVEs (Common Vulnerabilities and Exposures), ingested automatically from the [NVD v2 API](https://nvd.nist.gov/developers/vulnerabilities).

## What Is the CVE Pipeline?

Every morning at 7am, `ingest/cve-ingest.py` pulls recently published high-severity CVEs from the National Vulnerability Database and generates a structured note for each one containing:

- CVSS score and severity rating
- Affected software and versions
- Vulnerability description
- Mitigation recommendations
- ATT&CK technique mappings (where applicable)
- References and advisories

## Usage

```bash
# Pull recent high-severity CVEs (runs automatically at 7am)
virgil-cve --recent

# Search for CVEs by keyword
virgil-cve --keyword apache
virgil-cve --keyword "log4j"
virgil-cve --keyword "windows smb"

# Look up a specific CVE
virgil-cve CVE-2021-44228
virgil-cve CVE-2024-3400
```

## Output Format

Each CVE gets its own note: `notes/cve/CVE-YYYY-NNNNN.md`

Notes include wiki links to related techniques, affected software, and vendor advisories so your CVE library connects to your ATT&CK notes and knowledge base.

## Exam Relevance

For CySA+ candidates: understanding CVE severity scoring (CVSS), the difference between CVE/CWE/CPE identifiers, and how to use NVD for vulnerability prioritization are tested topics. Reading actual CVE notes regularly builds the mental model exam questions test.

## Tags

#cve #vulnerability-management #nvd #cysa-plus
