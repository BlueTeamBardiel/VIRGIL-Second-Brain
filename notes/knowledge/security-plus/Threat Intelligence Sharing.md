# Threat Intelligence Sharing

## What it is
Like hospitals sharing outbreak data so every clinic can recognize a new pathogen before it walks through their door, threat intelligence sharing is the structured exchange of indicators of compromise (IOCs), tactics, techniques, and procedures (TTPs), and contextual threat data between organizations, sectors, or governments. The goal is to shrink the window between a threat actor's first strike and the rest of the world's ability to detect or block it.

## Why it matters
In 2020, during the SolarWinds supply chain attack, early victims who shared network IOCs through ISACs allowed downstream organizations to hunt for the same malicious Sunburst beacon traffic *before* being compromised. Without that sharing, each organization would have been a first responder discovering the same fire independently — burning days or weeks of detection time they didn't have.

## Key facts
- **STIX/TAXII** is the dominant standard pairing: STIX (Structured Threat Information eXpression) formats the data; TAXII (Trusted Automated eXchange of Intelligence Information) is the transport protocol.
- **ISACs** (Information Sharing and Analysis Centers) are sector-specific sharing communities — FS-ISAC for financial, H-ISAC for healthcare — and are a common CySA+ exam topic.
- The **Traffic Light Protocol (TLP)** governs how shared intelligence can be redistributed: TLP:RED (no sharing), TLP:AMBER (limited sharing), TLP:GREEN (community-wide), TLP:CLEAR (public).
- Intelligence comes in three tiers: **strategic** (trends for executives), **operational** (campaign context), and **tactical** (IOCs for tools/signatures).
- MISP (Malware Information Sharing Platform) is a widely-used open-source platform for operationalizing threat intelligence sharing.

## Related concepts
[[Indicators of Compromise]] [[MITRE ATT&CK Framework]] [[Security Information and Event Management (SIEM)]]