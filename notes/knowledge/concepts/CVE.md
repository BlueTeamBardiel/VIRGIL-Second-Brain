# CVE

## What it is
Think of CVE like a universal part number at an auto parts store — every mechanic worldwide uses the same code to identify the exact same broken component, no matter what brand manual they're reading. A CVE (Common Vulnerabilities and Exposures) is a standardized identifier assigned to a publicly known security vulnerability, formatted as CVE-YEAR-NUMBER (e.g., CVE-2021-44228), maintained by MITRE and sponsored by CISA.

## Why it matters
When Log4Shell was discovered in December 2021, security teams worldwide immediately queried their asset inventories for CVE-2021-44228 — the single identifier let defenders, vendors, and threat intelligence platforms speak the same language instantly. Without this shared numbering system, patching coordination across thousands of enterprise tools would collapse into vendor-specific chaos, dramatically slowing response time.

## Key facts
- CVE IDs are assigned by **CVE Numbering Authorities (CNAs)** — over 300 organizations including Microsoft, Google, and Red Hat can mint their own IDs for their products
- A CVE entry intentionally contains **minimal data**: just an ID, description, and references — severity scoring lives in the **NVD (National Vulnerability Database)**, not CVE itself
- CVSS scores (0–10) attached to CVEs in the NVD measure severity; a CVSS of **9.0+** is Critical — Log4Shell scored a 10.0
- CVEs only cover **publicly disclosed** vulnerabilities; zero-days being actively exploited in secret have no CVE until disclosure
- The **CVE List** and **NVD** are related but distinct: MITRE owns CVE IDs; NIST's NVD enriches them with CVSS scores, CWE mappings, and CPE applicability data

## Related concepts
[[CVSS]] [[NVD]] [[Zero-Day Vulnerability]] [[Patch Management]] [[Vulnerability Scanning]]