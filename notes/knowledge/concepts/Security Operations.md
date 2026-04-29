# Security Operations

## What it is
Think of a Security Operations Center (SOC) as an air traffic control tower — analysts are constantly watching radar screens (dashboards), coordinating responses when something unexpected enters the airspace, and following strict protocols to prevent collisions. Precisely, Security Operations is the continuous practice of monitoring, detecting, analyzing, and responding to cybersecurity threats in real time using people, processes, and technology working in concert.

## Why it matters
In the 2020 SolarWinds supply chain attack, organizations with mature security operations were able to detect anomalous outbound traffic from the SUNBURST backdoor by correlating network logs with threat intelligence feeds — something that only works if your SOC has established baselines and alert tuning in place. Organizations lacking those capabilities went months without knowing they were compromised.

## Key facts
- A SOC typically operates across three tiers: Tier 1 (alert triage), Tier 2 (incident investigation), and Tier 3 (threat hunting and advanced analysis)
- **Mean Time to Detect (MTTD)** and **Mean Time to Respond (MTTR)** are the primary KPIs used to measure SOC effectiveness
- SIEMs (Security Information and Event Management systems) are the core technology in most SOCs, aggregating logs and correlating events across systems
- The **1-10-60 rule** (CrowdStrike benchmark) states defenders should detect in 1 minute, investigate in 10, and contain in 60
- Security Operations relies heavily on **playbooks** — documented, repeatable response procedures that reduce human error during high-pressure incidents

## Related concepts
[[SIEM]] [[Incident Response]] [[Threat Hunting]] [[Log Management]] [[SOC Analyst Roles]]