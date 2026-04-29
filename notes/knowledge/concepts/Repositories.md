# Repositories

## What it is
Think of a repository like a communal kitchen pantry where developers grab pre-made ingredients (code libraries) instead of cooking from scratch — except anyone can stock the shelves. Precisely, a repository is a centralized storage location for software packages, source code, or container images that systems pull from during builds, deployments, or updates. Examples include npm (JavaScript), PyPI (Python), Docker Hub (containers), and package managers like apt or yum.

## Why it matters
In the 2021 **dependency confusion attack**, researcher Alex Birsan uploaded malicious packages with the same names as internal Apple, Microsoft, and Tesla packages to public repositories like npm and PyPI. Build systems automatically pulled the *public* version over the private one due to version number manipulation, achieving remote code execution inside corporate networks without any phishing or exploitation required.

## Key facts
- **Dependency confusion** exploits the fact that package managers often prioritize public repos over private ones when namespace collisions exist
- **Typosquatting attacks** register packages with misspelled names (e.g., `reequests` instead of `requests`) hoping developers mistype during installation
- **Supply chain integrity** is verified using signed packages, hash verification (SHA-256 checksums), and tools like SigStore or Cosign for container images
- **SBOM (Software Bill of Materials)** documents all dependencies pulled from repositories, required under U.S. Executive Order 14028 for federal software vendors
- Malicious packages in repos have included **crypto miners, credential stealers, and reverse shells** embedded in install scripts (`setup.py`, `postinstall` hooks)

## Related concepts
[[Supply Chain Attacks]] [[Software Bill of Materials (SBOM)]] [[Dependency Management]] [[Container Security]] [[Code Signing]]