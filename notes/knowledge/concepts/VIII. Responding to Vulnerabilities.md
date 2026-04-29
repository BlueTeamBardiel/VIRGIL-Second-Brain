# VIII. Responding to Vulnerabilities

## What it is
Like a hospital's triage system — some patients get immediate surgery, others get bandaged and sent home — vulnerability response is the structured process of prioritizing, remediating, or accepting discovered weaknesses based on risk. Precisely: it is the coordinated workflow that moves a vulnerability from discovery through patching, mitigation, or formal risk acceptance, with documented accountability at each stage.

## Why it matters
In 2021, the Apache Log4Shell vulnerability (CVE-2021-44228) forced security teams worldwide to execute emergency response within hours — organizations without a defined process scrambled blindly, while mature teams used established runbooks to identify affected assets, apply vendor patches, and deploy WAF rules as interim mitigations within the same day. The difference in outcomes was entirely procedural, not technical.

## Key facts
- **Remediation options** follow a hierarchy: patch (preferred), mitigate via compensating controls, transfer risk (insurance/vendor), or formally *accept* risk with documented business justification
- **CVSS scoring** (Common Vulnerability Scoring System) provides a 0–10 severity baseline, but organizations must layer in **asset criticality** and **exploitability context** — a CVSS 9.8 on an air-gapped system may rank below a CVSS 6.5 on an internet-facing payment server
- **SLA targets** define maximum remediation timelines by severity: Critical ≤ 15 days, High ≤ 30 days, Medium ≤ 90 days are common frameworks
- **Inhibitors to remediation** recognized by CompTIA include: MOA/MOU constraints, legacy system dependencies, organizational governance, and business process disruption concerns
- **Validation** closes the loop — after patching, a rescan must confirm the vulnerability no longer exists before the ticket closes

## Related concepts
[[Vulnerability Scanning]] [[Risk Management]] [[Patch Management]] [[CVSS Scoring]] [[Compensating Controls]]