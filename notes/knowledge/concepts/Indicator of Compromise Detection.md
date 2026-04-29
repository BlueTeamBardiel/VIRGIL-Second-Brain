# Indicator of Compromise Detection

## What it is
Like a detective finding muddy boot prints, broken glass, and a pried-open window *after* a burglary — IoC detection involves examining artifacts left behind by attackers to confirm a system has been breached. Indicators of Compromise (IoCs) are forensic evidence such as malicious IP addresses, file hashes, domain names, registry keys, or unusual network traffic patterns that signal a host or network has been compromised.

## Why it matters
During the 2020 SolarWinds supply chain attack, organizations used IoCs — specifically the malicious SUNBURST DLL hash and C2 domain `avsvmcloud[.]com` — to rapidly scan their environments and determine exposure. Without pre-distributed IoC feeds, defenders would have had no systematic way to triage which of thousands of potentially affected networks had actually been exploited.

## Key facts
- **Types of IoCs** include file hashes (MD5/SHA-256), IP addresses, URLs, domain names, mutex names, registry keys, and anomalous user-agent strings
- **STIX/TAXII** is the standardized language (STIX) and transport protocol (TAXII) used to share IoCs between organizations and threat intelligence platforms
- **IoCs vs. IoAs**: IoCs are *retrospective* (evidence of past compromise); Indicators of Attack (IoAs) are *behavioral* and detect attacks in progress — IoAs are harder to evade
- **False positive management** is critical — blocking a legitimate CDN IP because it appeared in a threat feed can cause widespread outages
- Tools like **SIEM platforms, EDR solutions, and threat intelligence platforms (TIPs)** automate IoC ingestion and matching against log/telemetry data at scale

## Related concepts
[[Threat Intelligence Feeds]] [[SIEM]] [[STIX TAXII]] [[Endpoint Detection and Response]] [[Cyber Kill Chain]]