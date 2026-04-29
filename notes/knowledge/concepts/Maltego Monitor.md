# Maltego Monitor

## What it is
Like a security camera that never blinks — automatically re-running your reconnaissance queries and alerting you when the picture changes — Maltego Monitor is a continuous intelligence-tracking feature within Maltego that watches specified entities (domains, IPs, email addresses, organizations) and notifies analysts when new relationships or data points emerge over time.

## Why it matters
During a threat intelligence operation, a SOC analyst sets up Maltego Monitor to track a threat actor's known infrastructure. When the actor registers a new domain using the same registrant email, Monitor flags it automatically — enabling proactive blocking before the domain is weaponized in a phishing campaign, shrinking the attacker's window of opportunity.

## Key facts
- Maltego Monitor operates on **scheduled re-execution of transforms**, meaning it reruns OSINT queries (DNS lookups, WHOIS, social media pivots) at defined intervals rather than requiring manual analyst input
- It tracks **entity-level changes** — not just IP addresses, but relationships between entities, making it suitable for mapping evolving threat actor infrastructure
- Alerts are triggered by **delta detection**: new nodes or edges appearing in the graph since the last run, enabling change-focused rather than noise-heavy alerting
- Relevant to **CySA+** objectives around continuous monitoring, threat intelligence operationalization, and reducing mean time to detect (MTTD)
- Monitor is a **Maltego Enterprise/Professional feature**, not available in the free Community Edition — relevant when discussing tooling limitations in organizational contexts
- Supports integration with **threat intelligence platforms (TIPs)** and SIEM workflows by exporting findings for correlation with internal telemetry

## Related concepts
[[Maltego Transforms]] [[Open Source Intelligence (OSINT)]] [[Threat Intelligence Lifecycle]] [[Continuous Monitoring]] [[Indicator of Compromise (IOC)]]