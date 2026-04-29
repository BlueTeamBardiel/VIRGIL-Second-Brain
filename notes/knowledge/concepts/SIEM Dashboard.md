# SIEM Dashboard

## What it is
Think of a SIEM dashboard like an air traffic control tower display — dozens of aircraft (log sources) are tracked simultaneously, and controllers see any deviation from normal flight paths in real time. A Security Information and Event Management (SIEM) dashboard is the visual interface that aggregates, correlates, and displays security event data from across an organization's infrastructure — firewalls, endpoints, servers, and cloud services — in a single pane of glass. It transforms raw log noise into prioritized, actionable alerts and trend visualizations.

## Why it matters
During the 2020 SolarWinds supply chain attack, organizations with mature SIEM dashboards that monitored for anomalous lateral movement and unusual authentication patterns from trusted software had a measurable advantage in detecting the compromise earlier. A SOC analyst watching a SIEM dashboard might catch a spike in failed logins followed by a successful authentication from an unusual geolocation — classic indicators of credential stuffing transitioning into account takeover — before the attacker achieves their objective.

## Key facts
- SIEM dashboards rely on **log normalization** (converting disparate log formats into a common schema) to enable cross-source correlation
- **Correlation rules** trigger alerts when multiple events match a defined pattern (e.g., 5 failed logins + 1 success within 60 seconds = brute force alert)
- Key dashboard metrics include **Mean Time to Detect (MTTD)** and **Mean Time to Respond (MTTR)** — both are CySA+ exam favorites
- **Tuning** is critical: an untuned SIEM produces excessive false positives, causing alert fatigue and missed genuine threats
- Popular SIEM platforms include Splunk, IBM QRadar, and Microsoft Sentinel — all use **SPL, AQL, or KQL** query languages respectively

## Related concepts
[[Log Aggregation]] [[Security Operations Center (SOC)]] [[Correlation Rules]] [[Alert Fatigue]] [[Threat Intelligence Feeds]]