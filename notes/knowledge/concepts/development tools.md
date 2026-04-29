# development tools

## What it is
Like a mechanic's garage full of diagnostic equipment, compilers, and wrenches — development tools are the specialized software suite that programmers use to write, test, debug, and build applications. Precisely: development tools include IDEs (Integrated Development Environments), debuggers, compilers, package managers, version control systems, and static analysis tools that collectively form the software creation pipeline.

## Why it matters
In the 2020 SolarWinds attack, threat actors compromised the **build environment itself** — injecting malicious code into the Orion software during the compilation phase. This illustrates that development tools are a high-value attack surface; if an adversary controls your compiler or CI/CD pipeline, every application you ship becomes a weapon against your own customers.

## Key facts
- **IDE plugins and extensions** are increasingly weaponized — malicious VS Code extensions have harvested credentials and exfiltrated environment variables
- **Software Composition Analysis (SCA)** tools (e.g., Snyk, OWASP Dependency-Check) scan third-party libraries for CVEs — critical because 80%+ of modern codebases are open-source components
- **Static Application Security Testing (SAST)** tools analyze source code without executing it, identifying vulnerabilities like SQL injection or buffer overflows at development time
- **Dynamic Application Security Testing (DAST)** tools (e.g., OWASP ZAP) attack a *running* application — complementary to SAST, catching runtime flaws SAST misses
- **Secrets in version control** is a persistent critical failure: developers accidentally committing API keys, passwords, or certificates to public GitHub repos — tools like `git-secrets` or TruffleHog detect and prevent this

## Related concepts
[[SAST vs DAST]] [[supply chain attacks]] [[CI/CD pipeline security]] [[software composition analysis]] [[secrets management]]