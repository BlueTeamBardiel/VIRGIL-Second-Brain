# third-party software

## What it is
Like hiring a contractor to rewire your house — you trust their work, but you don't control where they bought their materials or what else they've built. Third-party software is any application, library, or component developed outside your organization and integrated into your environment, meaning you inherit its vulnerabilities, trust assumptions, and update cadence along with its functionality.

## Why it matters
In the 2020 SolarWinds attack, threat actors compromised the build pipeline of a trusted IT monitoring vendor and pushed a backdoored update (SUNBURST) to ~18,000 organizations, including U.S. federal agencies. Defenders who assumed "trusted vendor = safe software" had no compensating controls to detect the malicious DLL communicating with attacker infrastructure. This single supply chain compromise cascaded into one of the most damaging espionage operations in history.

## Key facts
- Third-party risk is a core concern of **supply chain attacks** — attackers target vendors specifically because they provide authenticated access to many downstream victims simultaneously
- **Software Bill of Materials (SBOM)** is a formal inventory of components, libraries, and dependencies; required by U.S. Executive Order 14028 for federal software procurement
- Unpatched third-party components are among the **top causes of breaches** — e.g., the 2017 Equifax breach exploited Apache Struts, an open-source library
- **Vendor risk management** programs evaluate third parties via questionnaires, right-to-audit clauses, and continuous monitoring before granting integration access
- **Dependency confusion attacks** trick package managers (npm, PyPI) into downloading attacker-controlled packages with names matching internal libraries

## Related concepts
[[supply chain attack]] [[software bill of materials]] [[vendor risk management]] [[dependency confusion]] [[patch management]]