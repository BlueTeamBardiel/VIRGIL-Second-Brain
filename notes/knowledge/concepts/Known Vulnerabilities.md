# Known Vulnerabilities

## What it is
Like a published recall notice for a car's faulty brakes — except ignoring it means attackers can crash your systems on demand. A known vulnerability is a publicly documented security flaw in software, hardware, or firmware that has been identified, assigned a CVE identifier, and disclosed to the security community. Unlike zero-days, these weaknesses already have patches or mitigations available; the danger lies entirely in delayed remediation.

## Why it matters
In 2017, the WannaCry ransomware attack devastated organizations worldwide by exploiting EternalBlue (CVE-2017-0144), a Windows SMB vulnerability — for which Microsoft had released patch MS17-010 *two months earlier*. Organizations that hadn't applied the patch handed attackers the keys. This remains the canonical example of why patch management velocity directly determines breach exposure.

## Key facts
- CVE (Common Vulnerabilities and Exposures) provides standardized identifiers; CVSS scores (0–10) rate severity, with 9.0+ considered Critical
- CISA's Known Exploited Vulnerabilities (KEV) catalog tracks flaws actively being weaponized in the wild — federal agencies are mandated to patch KEV entries within specific deadlines
- The average time-to-exploit for a new vulnerability is under 15 days; organizations typically take 60–150 days to patch
- Vulnerability scanners (Nessus, OpenVAS, Qualys) compare system fingerprints against CVE databases to surface unpatched flaws
- Prioritization frameworks like SSVC and CVSS Environmental scores help teams remediate the *riskiest* vulnerabilities first rather than chasing every finding

## Related concepts
[[CVE and CVSS Scoring]] [[Patch Management]] [[Vulnerability Scanning]] [[Zero-Day Vulnerabilities]] [[CISA KEV Catalog]]