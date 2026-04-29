# EDR - Endpoint Detection and Response

## What it is
Think of EDR like a black-box flight recorder combined with an air traffic controller — it continuously logs everything happening on an endpoint *and* actively intervenes when something looks wrong. Precisely: EDR is a security solution that collects and analyzes endpoint telemetry (process execution, file changes, network connections, registry modifications) in real time to detect, investigate, and respond to threats that traditional antivirus misses.

## Why it matters
During the SolarWinds supply chain attack (2020), threat actors used legitimate signed binaries and "living off the land" techniques to evade signature-based AV entirely. Organizations with mature EDR deployments could correlate behavioral anomalies — such as `svchost.exe` spawning unexpected child processes — and detect lateral movement even without a known malware signature.

## Key facts
- EDR differs from traditional AV in that it uses **behavioral analysis and telemetry** rather than relying solely on signature matching
- Core EDR functions map to four pillars: **Detect, Investigate, Contain, Remediate** — expect these on CySA+ exams
- EDR agents typically perform **process injection detection**, monitoring for techniques like DLL hollowing, reflective loading, and credential dumping (e.g., LSASS access)
- Many EDR platforms integrate **MITRE ATT&CK framework** tagging, labeling alerts by tactic and technique ID for faster analyst triage
- EDR is distinct from **XDR** (Extended Detection and Response), which aggregates telemetry across endpoints, network, email, and cloud — a common exam comparison point

## Related concepts
[[XDR - Extended Detection and Response]] [[SIEM - Security Information and Event Management]] [[Threat Hunting]] [[MITRE ATT&CK Framework]] [[Indicators of Compromise]]