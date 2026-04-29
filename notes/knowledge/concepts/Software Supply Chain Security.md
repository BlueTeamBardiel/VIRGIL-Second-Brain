# Software Supply Chain Security

## What it is
Like a restaurant that sources ingredients from dozens of farms — if one farm ships contaminated produce, every dish using it gets poisoned — software supply chain security addresses the risk that malicious or vulnerable code enters your application through third-party libraries, build tools, or update mechanisms. It encompasses the integrity of every component, dependency, and process involved in building and delivering software, from source code to end-user deployment.

## Why it matters
In the 2020 SolarWinds attack, threat actors compromised the build system of SolarWinds' Orion platform and injected a backdoor (SUNBURST) into a legitimate, digitally signed software update. Approximately 18,000 organizations — including US government agencies — installed the trojanized update, trusting the vendor's signature as proof of integrity. The attack demonstrated that a valid digital signature guarantees origin, not purity.

## Key facts
- **SBOMs (Software Bill of Materials)** are machine-readable inventories of all components in a software product; Executive Order 14028 (2021) mandated their use for federal software vendors
- **Dependency confusion attacks** exploit package managers (npm, PyPI) by publishing malicious public packages with the same name as a target organization's internal private package
- **Typosquatting** places malicious packages with near-identical names (e.g., `reqeusts` vs `requests`) in public repositories to catch developer typos
- **Code signing** provides authenticity but not integrity of the build pipeline itself — attackers can compromise signing infrastructure directly, as seen in SolarWinds
- **SLSA (Supply-chain Levels for Software Artifacts)** is a NIST-aligned framework with four maturity levels (1–4) for hardening build and release pipelines

## Related concepts
[[Code Signing]] [[Dependency Management]] [[Zero Trust Architecture]] [[Vulnerability Management]] [[Integrity Verification]]