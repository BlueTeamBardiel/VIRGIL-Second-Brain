# Software Supply Chain

## What it is
Like a restaurant sourcing ingredients from dozens of farms — if one farm ships contaminated produce, every dish using it becomes dangerous — software supply chains describe all the third-party code, libraries, build tools, and vendors that flow into a finished application. Precisely: it is the end-to-end set of components, processes, and dependencies involved in developing, building, and delivering software to end users. A compromise at any upstream link poisons everything downstream.

## Why it matters
In the 2020 SolarWinds attack, adversaries inserted malicious code into the Orion software build process itself — not the final product's source code. The trojanized update was digitally signed and distributed to ~18,000 organizations, including U.S. federal agencies, because defenders trusted the vendor's legitimate signing certificate. This demonstrated that trusting a vendor's binary is insufficient without verifying the integrity of the entire build pipeline.

## Key facts
- **SolarWinds (SUNBURST)** is the canonical supply chain attack: malicious code injected into a CI/CD pipeline, signed with a legitimate cert, and pushed as a trusted update.
- **Dependency confusion** attacks exploit package managers (npm, PyPI) by publishing malicious public packages with the same name as private internal ones, causing automatic downloads.
- The **SLSA framework** (Supply-chain Levels for Software Artifacts) provides a tiered model (Levels 1–4) for hardening build pipelines and ensuring provenance.
- **Software Bill of Materials (SBOM)** — a formal inventory of all components and dependencies — is now mandated for software sold to U.S. federal agencies (NIST EO 14028).
- Attackers target **build servers and CI/CD tools** (Jenkins, GitHub Actions) because compromising the pipeline produces legitimately signed malicious artifacts.

## Related concepts
[[Software Bill of Materials (SBOM)]] [[Dependency Confusion]] [[CI/CD Pipeline Security]]