# Software Development Lifecycle

## What it is
Like building a skyscraper — you don't weld steel before drawing blueprints, and you don't skip inspections before tenants move in. The Software Development Lifecycle (SDLC) is a structured framework of phases (planning, requirements, design, development, testing, deployment, maintenance) that governs how software is built, secured, and retired. Each phase has defined entry and exit criteria, ensuring security isn't bolted on at the end but woven throughout.

## Why it matters
The 2017 Equifax breach exploited an Apache Struts vulnerability that had a patch available for months — but no SDLC process enforced timely patching or dependency scanning before deployment. A mature SDLC with a Security Development Lifecycle (SDL) overlay would have flagged the vulnerable component during the build/test phase, preventing exposure of 147 million records. This is exactly why CySA+ emphasizes integrating security gates at each SDLC phase.

## Key facts
- **Waterfall vs. Agile vs. DevSecOps**: Waterfall is sequential (hard to patch mid-phase); Agile uses sprints enabling continuous security feedback; DevSecOps automates security checks in CI/CD pipelines
- **Security activities by phase**: Requirements → threat modeling; Design → architecture review; Development → SAST (static analysis); Testing → DAST and penetration testing; Maintenance → patch management
- **SAST vs. DAST**: Static Application Security Testing analyzes source code without execution; Dynamic Application Security Testing tests running applications — both are SDLC controls
- **Shift Left**: Moving security testing earlier in the SDLC reduces remediation cost by ~30x compared to fixing vulnerabilities post-deployment
- **EOL/EOS risk**: Software past End-of-Life in maintenance phase becomes an attack surface; SDLC retirement planning is a formal security control

## Related concepts
[[Secure Coding Practices]] [[Threat Modeling]] [[DevSecOps]] [[Static Application Security Testing]] [[Vulnerability Management]]