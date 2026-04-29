# Threat Detection

## What it is
Like a smoke detector that distinguishes between burnt toast and a house fire, threat detection is the process of identifying malicious activity within an environment by distinguishing abnormal behavior from normal noise. Precisely, it is the continuous monitoring and analysis of system, network, and user activity to identify indicators of compromise (IoCs) or indicators of attack (IoAs) before or during an incident.

## Why it matters
In the 2020 SolarWinds supply chain attack, malicious code sat dormant for weeks before activating — organizations with behavior-based detection caught anomalous outbound traffic to SUNBURST command-and-control servers, while those relying solely on signature-based tools saw nothing. This attack demonstrated that modern threats specifically evade signature detection, making behavioral and anomaly-based detection non-negotiable.

## Key facts
- **Two primary detection models**: Signature-based (known bad patterns) vs. Anomaly-based (deviations from baseline); CySA+ expects you to know when each fails
- **Mean Time to Detect (MTTD)** is the key metric — industry average historically exceeds 200 days for sophisticated breaches
- **SIEM platforms** (Splunk, Microsoft Sentinel) aggregate logs and apply correlation rules to surface threats; they are the primary threat detection tool in enterprise environments
- **MITRE ATT&CK framework** maps adversary techniques to detection opportunities — CySA+ heavily tests this framework as a detection engineering resource
- **Threat hunting** is *proactive* detection (humans searching for hidden threats), while SIEM alerting is *reactive* detection — Security+ distinguishes these concepts

## Related concepts
[[SIEM]] [[Indicators of Compromise]] [[MITRE ATT&CK]] [[Anomaly-Based Detection]] [[Threat Hunting]]