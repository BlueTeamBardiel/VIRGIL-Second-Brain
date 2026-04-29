# Threat Intelligence Services

## What it is
Think of it like a neighborhood watch program that's been professionalized — instead of neighbors texting about suspicious cars, thousands of security teams worldwide pool observations about active attackers, malicious IPs, and malware signatures into a shared feed you can subscribe to. Threat Intelligence Services are commercial or open-source platforms that collect, analyze, and distribute structured data about current threats, threat actors, TTPs (tactics, techniques, and procedures), and indicators of compromise (IOCs) to help defenders act proactively rather than reactively.

## Why it matters
In 2020, during the SolarWinds supply chain attack, organizations subscribed to threat intelligence feeds from providers like Mandiant and ISAC groups received early IOC data — malicious domains and hashes associated with SUNBURST malware — allowing them to hunt for compromises and isolate affected systems days before public disclosure. Without that shared intelligence, most affected organizations would have remained blind indefinitely.

## Key facts
- **STIX/TAXII** are the dominant standards: STIX (Structured Threat Information eXpression) formats the data; TAXII (Trusted Automated eXchange of Intelligence Information) is the transport protocol used to share it.
- Threat intelligence is classified by **strategic** (executive-level trends), **tactical** (TTPs for defenders), **operational** (specific campaign details), and **technical** (raw IOCs like IPs and hashes) tiers.
- Common sources include **ISACs** (Information Sharing and Analysis Centers — sector-specific, e.g., FS-ISAC for finance), **OSINT feeds**, and commercial vendors like CrowdStrike, Recorded Future, and Mandiant.
- The **MITRE ATT&CK framework** is frequently used alongside threat intel services to map reported TTPs to known adversary behaviors.
- Intelligence feeds can be **automated into SIEMs** to trigger real-time alerts when an IOC appears in network traffic or logs.

## Related concepts
[[Indicators of Compromise]] [[MITRE ATT&CK Framework]] [[SIEM]] [[STIX TAXII]] [[Information Sharing and Analysis Centers]]