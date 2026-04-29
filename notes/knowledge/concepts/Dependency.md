# Dependency

## What it is
Like a restaurant that trusts its food supplier without inspecting the ingredients, software dependencies are third-party libraries or packages your application imports and blindly trusts to execute. Precisely: a dependency is any external code component that an application requires to function, typically managed through package ecosystems like npm, PyPI, or Maven.

## Why it matters
In 2020, the SolarWinds attack exploited the build pipeline dependency chain — attackers poisoned a legitimate software update (Orion), which thousands of organizations had declared a trusted dependency. This supply chain attack compromised U.S. government agencies precisely because downstream consumers automatically trusted and deployed the tampered package without independent verification.

## Key facts
- **Dependency confusion attacks** trick package managers into downloading a malicious public package with the same name as a private internal one, exploiting version resolution precedence
- **Transitive dependencies** (dependencies of your dependencies) are the highest-risk category — the average Node.js project has hundreds of indirect dependencies the developer never reviewed
- **CVE tracking** applies to dependencies: using a library with a known CVE (e.g., Log4Shell in Log4j) makes your application vulnerable even if your own code is flawless
- **Software Bill of Materials (SBOM)** is the mandated defense — Executive Order 14028 (2021) requires vendors supplying the U.S. government to provide an SBOM listing all dependencies
- **Typosquatting** targets dependencies by registering packages with names one keystroke away from popular libraries (e.g., `lodahs` instead of `lodash`) to intercept careless developers

## Related concepts
[[Supply Chain Attack]] [[Software Bill of Materials (SBOM)]] [[Typosquatting]] [[Vulnerability Management]] [[Log4Shell]]