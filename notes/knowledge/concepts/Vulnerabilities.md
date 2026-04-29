# Vulnerabilities

## What it is
Think of a vulnerability like a cracked window latch in an otherwise locked house — the house has security, but that one flaw is all an attacker needs to get inside. Precisely defined, a vulnerability is a weakness in a system, application, configuration, or process that can be exploited by a threat actor to compromise confidentiality, integrity, or availability. It is not the attack itself — it is the precondition that makes the attack possible.

## Why it matters
In 2021, the Apache Log4Shell vulnerability (CVE-2021-44228) demonstrated how a single unpatched library embedded deep in thousands of products could expose millions of systems to remote code execution. Organizations that had conducted regular vulnerability scanning and maintained accurate software inventories were able to patch or mitigate within hours, while those without visibility scrambled for weeks. This event became the definitive case for continuous vulnerability management over point-in-time assessments.

## Key facts
- Vulnerabilities are categorized by CVSS (Common Vulnerability Scoring System) scores from 0–10; a score ≥ 9.0 is **Critical** and typically demands immediate remediation.
- The CVE (Common Vulnerabilities and Exposures) system provides standardized identifiers (e.g., CVE-2021-44228) used universally for tracking and communication.
- Vulnerability types include software bugs, misconfigurations, weak credentials, missing patches, and insecure defaults — not just code flaws.
- A vulnerability becomes a **risk** only when paired with a credible threat and an asset worth protecting (Risk = Threat × Vulnerability × Asset Value).
- Zero-day vulnerabilities are unpatched flaws unknown to the vendor, making them especially dangerous because no CVE or patch yet exists.

## Related concepts
[[Threat vs. Risk]] [[CVE and CVSS Scoring]] [[Patch Management]] [[Zero-Day Exploits]] [[Vulnerability Scanning]]