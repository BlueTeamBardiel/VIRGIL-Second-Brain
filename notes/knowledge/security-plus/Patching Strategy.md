# Patching Strategy

## What it is
Like a ship's crew constantly plugging hull leaks before water floods the compartments, a patching strategy is an organization's systematic plan for identifying, testing, prioritizing, and deploying software fixes to close known vulnerabilities. It defines *who* patches *what*, *how fast*, and *in what order* — turning reactive firefighting into disciplined maintenance.

## Why it matters
In May 2017, the WannaCry ransomware tore through 200,000+ systems globally — but Microsoft had already released patch MS17-010 two months earlier. Organizations without a functioning patching strategy simply never applied it, leaving the EternalBlue exploit wide open. A mature strategy with defined SLAs (e.g., critical patches within 24-72 hours) would have stopped this entirely.

## Key facts
- **Patch SLA tiers** are defined by CVSS score: Critical (9.0–10.0) → patch within 24-72 hrs; High (7.0–8.9) → 7-30 days; Medium/Low → 30-90 days
- **Patch Tuesday** (Microsoft's second Tuesday monthly cycle) is a known adversary window — attackers reverse-engineer patches to weaponize exploits before slow organizations apply them ("Exploit Wednesday")
- **Test before deploy**: patches should flow through Dev → Staging → Production to avoid breaking critical systems; untested patches caused the 2010 McAfee DAT file outage that bricked millions of machines
- **Legacy/EOL systems** (End-of-Life, no vendor patches available) require compensating controls: network segmentation, WAFs, or virtual patching via IPS signatures
- **Vulnerability scanners** (Nessus, Qualys) feed patch prioritization by correlating CVEs to asset criticality — not all vulnerabilities require equal urgency

## Related concepts
[[Vulnerability Management]] [[Change Management]] [[Risk Prioritization]] [[CVSS Scoring]] [[Compensating Controls]]