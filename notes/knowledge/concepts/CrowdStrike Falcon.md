# Crowdstrike Falcon

## What it is
Think of it as a security camera system that doesn't just record footage but actively tackles intruders — and calls headquarters the moment something looks wrong. CrowdStrike Falcon is a cloud-native Endpoint Detection and Response (EDR) platform that deploys a lightweight agent on endpoints to monitor process behavior, detect threats in real time, and stream telemetry to a cloud-based threat intelligence backend. It uses AI/ML models and behavioral indicators of attack (IoAs) rather than relying solely on signature-based detection.

## Why it matters
In the 2020 SolarWinds supply chain attack, organizations using traditional AV missed the SUNBURST backdoor for months because no signature existed. EDR platforms like Falcon, which monitor behavioral anomalies such as unusual parent-child process relationships and lateral movement patterns, are specifically designed to catch this class of "living off the land" attack that leaves minimal traditional indicators behind.

## Key facts
- Uses **Indicators of Attack (IoAs)** — behavioral patterns — rather than relying exclusively on **Indicators of Compromise (IoCs)** like file hashes, making it effective against zero-days
- The Falcon agent operates with minimal footprint and does **not** require on-premises infrastructure; all analysis leverages CrowdStrike's **Threat Graph** cloud database
- Provides **threat hunting** capability through its **Overwatch** managed service, where human analysts augment automated detection
- Relevant to **CySA+**: Falcon maps detections directly to **MITRE ATT&CK** framework techniques, enabling structured incident response
- In July 2024, a faulty Falcon **content configuration update** caused a global Windows BSOD outage — a landmark case study in update validation and third-party software risk

## Related concepts
[[Endpoint Detection and Response]] [[MITRE ATT&CK Framework]] [[Indicators of Compromise]] [[Living Off the Land Attacks]] [[Security Information and Event Management]]