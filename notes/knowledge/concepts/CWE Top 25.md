# CWE Top 25

## What it is
Think of it as the FBI's Most Wanted list, but for software weaknesses — the 25 most dangerous, most exploited coding flaws ranked by severity and frequency. The CWE (Common Weakness Enumeration) Top 25 is an annual list published by MITRE that identifies the most critical software vulnerabilities based on CVE data analysis from the NVD.

## Why it matters
In 2021, attackers exploited an out-of-bounds write vulnerability (CWE-787) — the #1 ranked weakness — in Apple's iOS kernel to achieve full device compromise with zero user interaction. Organizations that audit their codebases against the CWE Top 25 can systematically eliminate the vulnerability classes that attackers rely on most, reducing attack surface before code ever ships.

## Key facts
- **CWE-79 (XSS)**, **CWE-89 (SQL Injection)**, and **CWE-787 (Out-of-bounds Write)** are perennial top-ranked entries — memorize these for exams
- The list is recalculated annually using a scoring formula applied to NVD CVE data, weighting both frequency and severity
- CWE is a *weakness* classification (coding flaw categories); CVE is a specific *vulnerability* instance — they are complementary, not interchangeable
- CISA uses the CWE Top 25 to drive Secure by Design guidance and vendor accountability frameworks
- The list maps to SANS/CWE categories and feeds into OWASP Top 10, but they are separate efforts with different methodologies (OWASP focuses exclusively on web applications)

## Related concepts
[[OWASP Top 10]] [[CVE]] [[Common Vulnerability Scoring System (CVSS)]] [[Secure Software Development Lifecycle (SSDLC)]] [[SQL Injection]]