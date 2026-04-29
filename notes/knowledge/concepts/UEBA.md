# UEBA

## What it is
Think of it like a casino pit boss who memorizes every regular gambler's habits — how they bet, when they play, how much they spend — and immediately spots the moment someone starts acting "off." User and Entity Behavior Analytics (UEBA) is a security approach that establishes behavioral baselines for users and devices, then uses machine learning and statistical analysis to detect anomalous deviations that may indicate compromise or insider threat.

## Why it matters
A privileged sysadmin suddenly downloads 40GB of files at 2 AM, then VPNs out from a country they've never accessed before — traditional SIEM rules miss this because no single action triggers a signature. UEBA correlates the unusual hour, the abnormal data volume, and the impossible travel into a high-risk score, alerting analysts before exfiltration completes. This is precisely how organizations catch credential-based attacks where an attacker is technically "authorized."

## Key facts
- UEBA extends legacy DLP and SIEM by adding **behavioral context** — it answers *how* someone acts, not just *what* they access
- Detects **insider threats, compromised credentials, and lateral movement** — categories that signature-based tools routinely miss
- Uses techniques including **peer group analysis** (comparing a user against similar roles), time-series modeling, and risk scoring
- A **risk score** (not a binary alert) is the primary output; analysts investigate users exceeding defined thresholds
- UEBA is often embedded within **SIEM platforms** (e.g., Splunk UBA, Microsoft Sentinel) rather than deployed standalone — a frequent exam distinction
- Relevant CySA+ domain: **Threat and Vulnerability Management** and **Security Operations**

## Related concepts
[[SIEM]] [[Insider Threat]] [[Lateral Movement]] [[Behavioral Analytics]] [[DLP]]