# patch management

## What it is
Think of software vulnerabilities like cracks forming in a dam — patch management is the crew that inspects, prioritizes, and seals those cracks before the water breaks through. Precisely, it is the systematic process of identifying, acquiring, testing, deploying, and verifying software updates (patches) that fix security flaws, bugs, or functionality gaps across an organization's systems.

## Why it matters
In May 2017, the WannaCry ransomware attack infected over 200,000 systems across 150 countries — yet Microsoft had released patch MS17-010 fixing the EternalBlue vulnerability a full two months earlier. Organizations that had applied the patch were immune; those that hadn't faced catastrophic downtime and data loss. This single event made patch management a board-level conversation overnight.

## Key facts
- **Patch Tuesday**: Microsoft releases patches on the second Tuesday of each month; attackers often release exploits shortly after ("Exploit Wednesday"), creating a narrow remediation window.
- **CVSS scoring** is used to prioritize patches — critical vulnerabilities (CVSS ≥ 9.0) should be patched within 24–72 hours per most compliance frameworks.
- **Testing before deployment** is essential: patches should be validated in a staging environment to avoid breaking production systems (patch-induced outages are real).
- **End-of-life (EOL) systems** cannot receive patches and represent permanent unmitigated risk — compensating controls like network segmentation become mandatory.
- Patch management is a core requirement in frameworks like **NIST SP 800-40**, **PCI DSS Requirement 6**, and **CIS Control 7**.

## Related concepts
[[vulnerability management]] [[configuration management]] [[change management]] [[CVE]] [[CVSS scoring]]