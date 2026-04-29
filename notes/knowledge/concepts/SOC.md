# SOC

## What it is
Think of it as an air traffic control tower for your network — analysts watch every "flight" (data packet, login, alert) 24/7 and scramble when something goes off-course. A Security Operations Center (SOC) is a centralized team and facility responsible for continuously monitoring, detecting, analyzing, and responding to cybersecurity incidents across an organization's infrastructure.

## Why it matters
During the 2020 SolarWinds supply chain attack, organizations *with* mature SOCs were able to detect anomalous SUNBURST beacon traffic to command-and-control domains and isolate affected hosts within days — organizations without SOC capabilities went months without knowing they were compromised. The SOC's ability to correlate SIEM alerts with threat intelligence made the difference between rapid containment and prolonged dwell time.

## Key facts
- A SOC operates across **three tiers**: Tier 1 triages alerts, Tier 2 performs deeper investigation, Tier 3 handles advanced threat hunting and incident response
- The primary tool stack includes a **SIEM** (log aggregation/correlation), **SOAR** (automated response playbooks), and **EDR** (endpoint telemetry)
- **Mean Time to Detect (MTTD)** and **Mean Time to Respond (MTTR)** are the key KPIs used to measure SOC effectiveness
- A **SOC as a Service (SOCaaS)** model outsources these functions to an MSSP — relevant for organizations lacking in-house capability
- SOC analysts follow a **runbook/playbook** for repeatable incident types (e.g., phishing triage), ensuring consistent, documented response procedures

## Related concepts
[[SIEM]] [[Incident Response]] [[Threat Hunting]] [[SOAR]] [[MSSP]]