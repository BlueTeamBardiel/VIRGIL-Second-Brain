# Palo Alto Networks Cortex XDR

## What it is
Think of it as a security operations center compressed into a single platform — like replacing a dozen separate specialists who never talk to each other with one analyst who reads everyone's notes simultaneously. Cortex XDR (Extended Detection and Response) is a cloud-native security platform that ingests and correlates telemetry from endpoints, networks, cloud environments, and third-party sources to detect, investigate, and respond to threats across the entire attack surface.

## Why it matters
During a supply chain attack like SolarWinds, attackers moved laterally across networks for months by blending into normal traffic — tools that only watched endpoints or only watched the network missed the full picture. Cortex XDR's cross-source correlation would stitch together the suspicious DNS beacon, the unusual service account login, and the abnormal endpoint process tree into a single unified incident, dramatically compressing detection time and analyst workload.

## Key facts
- Uses **behavioral analytics and machine learning** to baseline normal activity and surface anomalies without relying solely on signature-based detection
- Employs a **causality chain** (Causality Analysis Engine) that reconstructs the full attack sequence — mapping parent-child process relationships to expose fileless malware and living-off-the-land techniques
- Integrates with **MITRE ATT&CK** framework, automatically tagging alerts to specific tactics and techniques for faster triage
- Cortex XDR agent provides **preventive capabilities** (exploit protection, behavioral threat protection) in addition to detection — blurring the line between EDR and traditional AV/EPP
- Data is stored and queried in **Cortex Data Lake**, a centralized cloud repository enabling long-retention threat hunting across months of normalized telemetry

## Related concepts
[[Endpoint Detection and Response]] [[SIEM]] [[MITRE ATT&CK Framework]] [[Threat Hunting]] [[Security Orchestration Automation and Response]]