# Supply Chain Security

## What it is
Like a restaurant that sources ingredients from dozens of farms — if one farm ships contaminated lettuce, every dish on the menu becomes a vector — software and hardware supply chains mean your trusted vendor can unknowingly deliver a compromised product. Supply chain security is the practice of ensuring that every component, library, firmware, or service integrated into a system maintains its integrity from origin to deployment.

## Why it matters
In the 2020 SolarWinds attack, threat actors (APT29/Cozy Bear) injected malicious code into SolarWinds' Orion build process, causing the legitimate, digitally-signed update to deliver a backdoor (SUNBURST) to ~18,000 organizations — including U.S. federal agencies. The update's valid signature meant traditional integrity checks passed without raising alerts, demonstrating that a trusted vendor relationship is itself an attack surface.

## Key facts
- **NIST SP 800-161** provides the formal framework for Cyber Supply Chain Risk Management (C-SCRM) and is directly referenced on Security+/CySA+ exams
- **Software Bill of Materials (SBOM)** is a machine-readable inventory of all components in a software product; U.S. Executive Order 14028 (2021) mandates SBOMs for federal software vendors
- **Typosquatting** (e.g., `colourama` vs `colorama` on PyPI) is a common supply chain attack vector targeting developers who mistype package names
- **Code signing** and **hash verification** (SHA-256 checksums) are key countermeasures to detect tampering during distribution
- Third-party risk is assessed through **vendor questionnaires**, **right-to-audit clauses**, and continuous monitoring of vendor security posture

## Related concepts
[[Code Signing]] [[Software Bill of Materials (SBOM)]] [[Third-Party Risk Management]] [[Zero Trust Architecture]] [[Integrity Verification]]