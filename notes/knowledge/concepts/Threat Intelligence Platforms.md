# Threat Intelligence Platforms

## What it is
Think of a TIP like a war room that automatically aggregates enemy dispatches from dozens of scouts, cross-references them, and pins the most actionable intel on a single map. A Threat Intelligence Platform (TIP) is a centralized system that collects, aggregates, normalizes, and correlates threat data from multiple internal and external sources — including ISACs, OSINT feeds, and dark web monitors — so analysts can prioritize and act on it efficiently.

## Why it matters
During the 2020 SolarWinds supply chain attack, organizations using TIPs were able to ingest newly published IOCs (malicious IP addresses, file hashes, and C2 domains) from CISA and FireEye reports and automatically push those indicators into SIEMs and firewalls within hours. Organizations without TIPs had to manually hunt through PDFs and update rules by hand, losing critical response time while SUNBURST backdoors continued beaconing.

## Key facts
- TIPs consume structured threat data in formats like **STIX** (Structured Threat Information eXpression) and transport it via **TAXII** (Trusted Automated eXchange of Intelligence Information)
- They enrich raw IOCs with **context** (threat actor TTPs, campaign history, confidence scores) — distinguishing a TIP from a simple blocklist feed
- TIPs integrate with **SIEM, SOAR, and firewalls** to enable automated blocking or alerting based on ingested indicators
- The intelligence lifecycle a TIP supports: **Direction → Collection → Processing → Analysis → Dissemination → Feedback**
- Key TIP vendors include **Recorded Future, ThreatConnect, MISP (open source), and Anomali** — MISP is commonly referenced in exam scenarios for open-source environments

## Related concepts
[[STIX/TAXII]] [[SIEM]] [[SOAR]] [[Indicators of Compromise]] [[MITRE ATT&CK]]