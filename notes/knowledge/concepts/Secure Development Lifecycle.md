# Secure Development Lifecycle

## What it is
Like building fire suppression into a skyscraper's blueprints rather than retrofitting sprinklers after the building burns down, the SDL embeds security at every phase of software development. It is a structured process that integrates security requirements, threat modeling, code review, and testing throughout design, implementation, verification, and release — not just at the end.

## Why it matters
The 2017 Equifax breach exploited Apache Struts, a known vulnerability (CVE-2017-5638) with a patch available for months. Had Equifax practiced a mature SDL, patch management and dependency scanning would have been baked into their release pipeline, closing the window attackers used to exfiltrate 147 million records. SDL doesn't just write better code — it creates organizational habits that shrink the attack surface continuously.

## Key facts
- **Microsoft's SDL** (2004) is the canonical industry model; it introduced mandatory threat modeling and banned functions like `strcpy()` from approved code lists
- SDL phases map to: **Training → Requirements → Design → Implementation → Verification → Release → Response**
- **Threat modeling** (e.g., using STRIDE) is the SDL's highest-leverage activity — flaws found in design cost ~30x less to fix than those found post-deployment
- **Security requirements** must be defined before coding; regulators like PCI-DSS and HIPAA expect documented SDL evidence during audits
- **Penetration testing and static/dynamic analysis (SAST/DAST)** are verification-phase requirements, not optional extras — CySA+ explicitly tests this distinction

## Related concepts
[[Threat Modeling]] [[SAST and DAST]] [[DevSecOps]] [[STRIDE Framework]] [[Common Vulnerability Scoring System]]