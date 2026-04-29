# Antivirus and EDR

## What it is
Think of antivirus as a bouncer with a photo ID list — it checks every file against a known list of bad actors and turns them away at the door. Endpoint Detection and Response (EDR) is the upgrade: a full-time surveillance team that watches behavior in real time, records everything, and can actively hunt threats even after they get inside. Together they form the core of endpoint security, with AV focusing on signature-based prevention and EDR adding behavioral analytics, telemetry collection, and incident response capabilities.

## Why it matters
During the 2020 SolarWinds attack, traditional AV was essentially blind — the malicious code was digitally signed and behaved normally until it phoned home weeks later. Organizations running EDR solutions were able to detect the anomalous outbound connections and lateral movement patterns that signature-based AV completely missed, making EDR the difference between containment and catastrophic breach in that campaign.

## Key facts
- **AV detection methods**: Signature-based (hash matching), heuristic (behavioral rules), and sandboxing (dynamic execution analysis)
- **EDR core functions**: continuous endpoint telemetry, threat hunting, automated containment (isolating a host), and forensic investigation support
- **MITRE ATT&CK integration**: Modern EDR platforms map detected behaviors directly to ATT&CK techniques and tactics for faster analyst triage
- **AV evasion techniques** attackers use: polymorphic code, process hollowing, living-off-the-land (LOLBins), and fileless malware — all designed to bypass signature detection
- **XDR (Extended Detection and Response)** expands EDR beyond endpoints to cover network, cloud, and email telemetry in a unified platform

## Related concepts
[[Indicators of Compromise]] [[MITRE ATT&CK Framework]] [[Fileless Malware]] [[Threat Hunting]] [[Sandboxing]]