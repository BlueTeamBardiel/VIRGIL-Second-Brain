# Dependency List

## What it is
Like reading the ingredient label on a food product — except each ingredient also has its own ingredients — a dependency list catalogs every external library, package, or component that a software application relies on to function. Precisely, it is a manifest (e.g., `package.json`, `requirements.txt`, `pom.xml`) that enumerates all third-party code a project imports, including transitive dependencies pulled in by those imports.

## Why it matters
In the 2021 Log4Shell attack, organizations that lacked accurate dependency lists had no idea they were running the vulnerable `log4j` library buried four layers deep in their transitive dependencies — and couldn't patch what they couldn't find. Maintaining a current, complete dependency list is the foundation of Software Composition Analysis (SCA) and enables rapid response when a CVE drops for a component you use.

## Key facts
- A **Software Bill of Materials (SBOM)** is the formal, standardized version of a dependency list — U.S. Executive Order 14028 (2021) mandates SBOMs for software sold to the federal government.
- **Transitive dependencies** (dependencies of dependencies) are the hidden attack surface; direct dependencies are only the first layer.
- Tools like **OWASP Dependency-Check**, **Snyk**, and **GitHub Dependabot** automate vulnerability scanning against dependency lists using known CVE databases.
- **Dependency confusion attacks** exploit the resolution order of package managers — an attacker publishes a malicious public package with the same name as a private internal one, causing the manager to pull the wrong one.
- Dependency lists should be version-pinned and hash-verified (lock files) to prevent **supply chain substitution** attacks.

## Related concepts
[[Software Bill of Materials (SBOM)]] [[Supply Chain Attack]] [[Software Composition Analysis]] [[Dependency Confusion]] [[CVE]]