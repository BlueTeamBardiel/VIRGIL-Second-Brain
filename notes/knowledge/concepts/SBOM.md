# SBOM

## What it is
Like a nutrition label on packaged food listing every ingredient and additive, an SBOM (Software Bill of Materials) is a formal, machine-readable inventory of every component, library, and dependency included in a software product. It documents the exact versions, licenses, and relationships between all constituent parts so organizations can audit what they're actually running.

## Why it matters
When Log4Shell (CVE-2021-44228) dropped in December 2021, organizations scrambled for days or weeks just to answer "do we even *have* Log4j in our environment?" Companies with SBOMs answered that question in hours — they queried their inventory, identified affected products, and began patching while others were still doing manual discovery. The difference was measured in attacker dwell time.

## Key facts
- **Executive Order 14028** (May 2021) mandated SBOMs for software sold to the U.S. federal government, making them a compliance requirement, not just a best practice
- Common SBOM formats include **SPDX** (Linux Foundation) and **CycloneDX** (OWASP); both are recognized by NTIA and CISA
- SBOMs enable **vulnerability correlation**: once a new CVE is published, you can cross-reference it against your inventory to find affected systems automatically
- An SBOM should capture: component name, version, supplier, cryptographic hash, dependency relationships, and license information
- SBOMs support **supply chain risk management (SCRM)** by revealing transitive dependencies — third-party libraries that *your* libraries depend on — which are often the actual attack surface

## Related concepts
[[Software Supply Chain Attack]] [[Vulnerability Management]] [[CVE]] [[Log4Shell]] [[Zero-Day Vulnerability]]