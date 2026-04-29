# MISP

## What it is
Think of MISP as a neighborhood watch group chat where every security team shares exactly what the suspicious van looks like, its license plate, and when it was spotted — so everyone benefits from one person's experience. MISP (Malware Information Sharing Platform) is an open-source threat intelligence platform that allows organizations to collect, store, correlate, and share structured indicators of compromise (IoCs) in a standardized format. It enables automated ingestion and distribution of threat data across trusted communities.

## Why it matters
During the 2017 WannaCry ransomware outbreak, organizations using MISP were able to receive real-time IoCs — including the kill-switch domain and malicious file hashes — from peer organizations and government CERTs within hours of initial detection. Security teams could immediately push those indicators into their SIEMs and firewalls to block propagation before WannaCry reached their networks. Without a platform like MISP, each organization would have been discovering the threat independently and reactively.

## Key facts
- MISP uses a structured data format called **MISP Objects** and supports **STIX/TAXII** for cross-platform threat intelligence sharing and interoperability
- IoCs in MISP are organized into **Events**, which contain **Attributes** (IP addresses, hashes, domains) tagged with context like threat actor, campaign, or TTP
- Supports **trust circles** called Sharing Groups, allowing granular control over who sees which intelligence feeds
- Integrates natively with SIEMs, IDS/IPS, and firewalls via APIs, enabling automated blocking based on shared IoCs
- Aligns with the **Diamond Model** and **MITRE ATT&CK** framework for contextualizing adversary behavior beyond raw indicators

## Related concepts
[[Threat Intelligence]] [[STIX/TAXII]] [[Indicators of Compromise]] [[SIEM]] [[MITRE ATT&CK]]