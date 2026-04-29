# Patching

## What it is
Like a tailor sewing a tear in a jacket before rain gets in, patching is the act of applying vendor-released code updates that close specific security vulnerabilities in software or firmware. Patches fix bugs, eliminate exploitable flaws, and harden systems against known attack vectors without replacing the entire application.

## Why it matters
In May 2017, WannaCry ransomware spread to over 200,000 systems in 150 countries — but Microsoft had released patch MS17-010 two months earlier, fixing the EternalBlue SMB vulnerability it exploited. Organizations that skipped or delayed patching paid the price; those with disciplined patch management were largely unaffected. This single event demonstrates that unpatched systems are low-hanging fruit for attackers.

## Key facts
- **Patch Tuesday** is Microsoft's monthly cadence for releasing security updates; out-of-band patches are released for critical zero-day vulnerabilities between cycles
- **Mean Time to Patch (MTTP)** is the key metric for patch management maturity; industry benchmarks target critical patches within 30 days, often 72 hours for actively exploited flaws
- **Compensating controls** (firewall rules, network segmentation, IDS signatures) are used when a patch cannot be immediately applied — this is called **virtual patching**
- Patches must be tested in a staging environment before production deployment to avoid breaking functionality; this is why automated patch management tools (WSUS, SCCM, Ansible) are used in enterprises
- **CVE scores (CVSS)** are used to prioritize patching — critical (9.0–10.0) vulnerabilities are patched first; organizations consult CISA's Known Exploited Vulnerabilities (KEV) catalog for mandatory patching priorities

## Related concepts
[[Vulnerability Management]] [[CVE and CVSS]] [[Configuration Management]] [[Zero-Day Vulnerability]] [[Change Management]]