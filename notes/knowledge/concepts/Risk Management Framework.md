# Risk Management Framework

## What it is
Think of it like a hospital triage system: not every patient gets a surgeon immediately — you assess severity, allocate resources, and treat in priority order. A Risk Management Framework (RMF) is a structured, repeatable process for identifying, assessing, prioritizing, and responding to security risks so organizations allocate limited resources where they matter most. NIST SP 800-37 defines the authoritative federal RMF as a six-step lifecycle used to authorize information systems.

## Why it matters
In 2020, the SolarWinds breach exposed thousands of organizations because vendors were implicitly trusted without risk assessment — no one had formally evaluated the supply chain as a threat vector. A properly executed RMF would have flagged third-party software update mechanisms as high-risk assets requiring continuous monitoring and stricter authorization controls, potentially catching anomalous behavior earlier.

## Key facts
- **NIST RMF has six steps**: Categorize → Select → Implement → Assess → Authorize → Monitor (mnemonic: *C-SIAM*)
- **FIPS 199** is used in the Categorize step to assign information systems a security impact level: Low, Moderate, or High
- **ATO (Authorization to Operate)** is the formal approval issued after the Assess step — without it, federal systems cannot legally go live
- **Continuous monitoring** (step 6) is not optional or periodic — it's ongoing and feeds back into re-categorization when the threat landscape changes
- RMF integrates with **NIST SP 800-53** (security controls catalog) and **SP 800-30** (risk assessment guide) — knowing which doc does what is a common exam trap

## Related concepts
[[NIST SP 800-53]] [[Security Controls]] [[Authorization to Operate]] [[Continuous Monitoring]] [[Threat Modeling]]