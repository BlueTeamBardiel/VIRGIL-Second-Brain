# Endpoint Prevention and Response

## What it is
Think of EPR like a security guard who not only checks IDs at the door (prevention) but also watches security cameras 24/7 and tackles anyone acting suspiciously inside the building (response). Endpoint Prevention and Response (EPR) — often called EDR — is a category of security tooling deployed directly on devices (laptops, servers, mobile phones) that combines proactive threat blocking with continuous behavioral monitoring, detection, and incident response capabilities.

## Why it matters
In the 2020 SolarWinds attack, traditional antivirus failed because the malware used legitimate signed binaries and blended into normal network traffic. Organizations with EDR solutions could query endpoint telemetry to hunt for anomalous process chains — like *SolarWinds.Orion.exe* spawning unexpected child processes — and isolate compromised hosts before lateral movement escalated.

## Key facts
- **EDR vs. Traditional AV**: Legacy antivirus uses signature-based detection; EDR uses behavioral analysis and telemetry, catching fileless malware and living-off-the-land (LOtL) attacks that have no static signature.
- **Core functions (DIRT)**: EDR platforms **D**etect threats, **I**nvestigate root cause, **R**espond to incidents, and **T**rack endpoint telemetry continuously.
- **MDR (Managed Detection and Response)** outsources EDR operations to a third-party SOC — important distinction for CySA+ exam scenarios involving resource-constrained organizations.
- **XDR (Extended Detection and Response)** aggregates telemetry beyond endpoints — adding network, cloud, and email data — for correlated, cross-layer threat detection.
- Endpoint isolation (network quarantine) is a key automated response action: the agent cuts the host's network connections while preserving forensic data for investigation.

## Related concepts
[[Behavioral Analysis]] [[Threat Hunting]] [[Security Information and Event Management (SIEM)]] [[Indicators of Compromise (IoC)]] [[Fileless Malware]]