# Security Hardening

## What it is
Like a medieval blacksmith reinforcing a castle gate — removing decorative weak points, adding iron bars, and narrowing the opening — hardening means systematically eliminating unnecessary attack surface from a system. It is the process of configuring systems, services, and applications to reduce vulnerabilities by disabling unused features, applying least privilege, and enforcing secure defaults.

## Why it matters
The 2017 Equifax breach exploited an unpatched Apache Struts vulnerability on an internet-facing server — a server that almost certainly had no business being publicly accessible with default configurations intact. Proper hardening would have included disabling that component entirely if unused, or isolating it behind strict network controls, potentially stopping the breach before 147 million records were exposed.

## Key facts
- **Baselines and benchmarks**: CIS Benchmarks and DISA STIGs provide configuration standards used as hardening baselines for OS, cloud, and application environments
- **Disable, don't just ignore**: Unused services, ports, and protocols must be explicitly disabled — open ports are attack surface even if "nobody uses them"
- **Patch management is part of hardening**: Applying security patches reduces known CVEs; unpatched systems fail hardening audits regardless of other controls
- **Principle of Least Privilege (PoLP)** is foundational — accounts and services should run with minimum permissions required, limiting blast radius if compromised
- **Configuration drift**: Hardened systems can drift back to insecure states over time; continuous compliance monitoring (SCAP, SIEM) is required to detect unauthorized changes

## Related concepts
[[Attack Surface Reduction]] [[Principle of Least Privilege]] [[Patch Management]] [[CIS Benchmarks]] [[Configuration Management]]