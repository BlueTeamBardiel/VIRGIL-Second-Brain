# Security Operations Center

## What it is
Think of it like an air traffic control tower — dozens of flights (events) happening simultaneously, and trained controllers (analysts) watching every blip on radar to prevent collisions (breaches). A Security Operations Center (SOC) is a centralized team and facility where security analysts monitor, detect, analyze, and respond to cybersecurity incidents 24/7 using a combination of technology, processes, and people.

## Why it matters
During the 2013 Target breach, attackers moved laterally from HVAC vendor credentials to payment systems over several weeks — alerts fired in the SOC but were deprioritized and never escalated. A mature SOC with proper triage procedures and alert thresholds could have detected the Command & Control traffic and lateral movement before 40 million credit cards were exfiltrated.

## Key facts
- SOCs are typically structured in **three tiers**: Tier 1 (alert triage), Tier 2 (incident investigation), Tier 3 (threat hunting and advanced analysis)
- The core technology stack includes a **SIEM** (Security Information and Event Management) for log aggregation and correlation, often paired with SOAR for automated response
- Mean Time to Detect (MTTD) and Mean Time to Respond (MTTR) are the primary **KPIs** used to measure SOC effectiveness
- SOCs operate on a **"assume breach" mentality** — the goal is rapid containment, not just prevention
- A **Fusion SOC** integrates physical security, IT security, and intelligence feeds into a single operational picture — increasingly common in critical infrastructure environments

## Related concepts
[[SIEM]] [[Incident Response]] [[Threat Hunting]] [[SOAR]] [[Log Management]]