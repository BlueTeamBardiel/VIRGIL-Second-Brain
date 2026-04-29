# Behavioral Anomaly Detection

## What it is
Like a bank that flags your card when you buy coffee in Tokyo an hour after swiping it in Dallas, behavioral anomaly detection establishes a baseline of "normal" activity and alerts when observed behavior deviates significantly from that baseline. It is a security monitoring approach that uses statistical modeling or machine learning to identify unusual patterns in user, network, or system behavior — without relying on known attack signatures.

## Why it matters
In the 2020 SolarWinds supply chain attack, compromised software sat dormant for weeks before executing — meaning traditional signature-based tools saw nothing. Behavioral detection systems could flag the anomaly when SolarWinds' Orion binary suddenly began making DNS queries to attacker-controlled domains at unusual hours, a pattern outside its established baseline, potentially catching the intrusion before lateral movement escalated.

## Key facts
- **UEBA (User and Entity Behavior Analytics)** is the enterprise implementation of this concept, tracking deviations in login times, data access volumes, and geographic locations
- A baseline period (typically 7–30 days) must be established before detection becomes reliable; alerts during this period are noise-heavy
- **False positive rate** is the primary operational challenge — overly sensitive thresholds create alert fatigue and cause analysts to ignore genuine threats
- Anomaly detection complements signature-based IDS/IPS; neither approach alone provides sufficient coverage (defense in depth principle)
- On the CySA+ exam, behavioral anomaly detection is closely tied to **threat hunting** and **continuous monitoring** within the SOC workflow

## Related concepts
[[UEBA]] [[Signature-Based Detection]] [[Threat Hunting]] [[SIEM]] [[Baseline Configuration]]