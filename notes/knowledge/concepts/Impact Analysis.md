# Impact Analysis

## What it is
Like a doctor estimating how bad a wound is before deciding whether to call a surgeon or apply a bandage, impact analysis measures the potential damage a threat could cause to an organization before (or after) a security incident. Precisely: it is the process of evaluating the consequences of a vulnerability, incident, or change on the confidentiality, integrity, and availability of assets, used to prioritize response and resource allocation.

## Why it matters
During the 2017 WannaCry ransomware outbreak, organizations that had performed prior impact analysis knew immediately which systems were mission-critical — hospitals that hadn't done this work shut down operating rooms unnecessarily while still-functional backup systems sat idle. A proper impact analysis would have identified that legacy Windows XP medical devices carried the highest business impact, enabling faster, smarter triage decisions.

## Key facts
- Impact is typically rated on a scale (High/Medium/Low or 1–10) and combined with **likelihood** to calculate overall **risk** — a core formula for Security+ and CySA+
- Impact categories map directly to **CIA Triad**: data exposure = confidentiality impact; data corruption = integrity impact; system downtime = availability impact
- **Quantitative impact** uses financial figures (ALE = ARO × SLE); **qualitative impact** uses descriptive scales — both appear on Security+ exams
- Impact analysis is a required phase of **Business Impact Analysis (BIA)**, which feeds directly into **Business Continuity Planning (BCP)** and **Disaster Recovery Planning (DRP)**
- Maximum Tolerable Downtime (**MTD**) and Recovery Time Objective (**RTO**) are outputs that depend directly on impact severity scores

## Related concepts
[[Risk Assessment]] [[Business Impact Analysis]] [[Vulnerability Scoring (CVSS)]] [[Disaster Recovery Planning]] [[Threat Modeling]]