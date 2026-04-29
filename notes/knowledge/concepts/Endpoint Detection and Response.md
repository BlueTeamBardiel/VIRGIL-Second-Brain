# endpoint detection and response

## What it is
Think of EDR like a black box flight recorder combined with an air traffic controller — it doesn't just log what happened after a crash, it watches every maneuver in real time and can radio a warning before impact. Endpoint Detection and Response (EDR) is a security solution deployed as an agent on individual hosts that continuously monitors endpoint activity, records behavioral telemetry, detects threats using analytics, and enables active response actions. Unlike traditional antivirus, EDR focuses on *behavior* rather than signatures alone.

## Why it matters
During the SolarWinds supply chain attack (2020), attackers used legitimate tools and "living off the land" techniques specifically designed to evade signature-based AV. Organizations with mature EDR deployments were able to detect anomalous process chains — such as `svchost.exe` spawning unexpected network connections — and isolate compromised hosts before lateral movement reached critical assets.

## Key facts
- EDR agents collect telemetry including process creation, file system changes, registry modifications, network connections, and memory activity
- Core EDR capabilities: **detect, investigate, contain, and remediate** — often mapped to the NIST incident response framework
- EDR differs from EPP (Endpoint Protection Platform): EPP prevents known threats; EDR hunts and responds to unknown or advanced threats
- Many EDR tools use **MITRE ATT&CK** framework mappings to classify and contextualize detected behaviors
- "Isolation" is a key EDR response action — network-isolating a host while preserving forensic state without reimaging
- EDR generates significant alert volume; Security+ and CySA+ exam questions often focus on tuning to reduce **false positives**

## Related concepts
[[threat hunting]] [[MITRE ATT&CK]] [[security information and event management]] [[indicators of compromise]] [[living off the land attacks]]