# Impact

## What it is
Like a wrecking ball versus a thrown pebble — both hit something, but only one brings down the building. In cybersecurity risk analysis, **impact** is the measured harm to an organization if a threat successfully exploits a vulnerability, expressed in terms of data loss, financial damage, operational disruption, or reputational harm. It is one of two core variables in risk calculation: **Risk = Likelihood × Impact**.

## Why it matters
In the 2017 NotPetya attack, the malware's *likelihood* of spreading was high — but it was the *impact* that made it catastrophic: Maersk lost an estimated $300 million because their global shipping operations halted entirely. Security teams who had not assessed the operational dependency on those systems failed to prioritize patching, because they underestimated what a successful compromise would actually cost them.

## Key facts
- Impact is formally assessed across three CIA Triad dimensions: **Confidentiality** (data exposure), **Integrity** (data corruption), and **Availability** (system downtime)
- NIST SP 800-30 defines impact ratings as **Low, Moderate, or High** based on the extent of harm to organizational operations, assets, or individuals
- A **Business Impact Analysis (BIA)** identifies critical systems and quantifies impact through two metrics: **RTO** (Recovery Time Objective) and **RPO** (Recovery Point Objective)
- **Qualitative impact** uses descriptive scales (Low/Medium/High); **quantitative impact** uses dollar figures — both appear on Security+/CySA+ exams
- High likelihood + low impact ≠ high risk; a ransomware attack on an air-gapped test server has minimal impact despite high exploitability

## Related concepts
[[Risk Assessment]] [[Business Impact Analysis]] [[Likelihood]] [[CIA Triad]] [[Vulnerability Management]]