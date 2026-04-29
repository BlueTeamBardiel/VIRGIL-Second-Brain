# Collection

## What it is
Like a thief who doesn't just grab the cash register but methodically photographs every document in the office before leaving, Collection is the phase where an attacker gathers the target data they actually came for. Formally, it is MITRE ATT&CK Tactic TA0009 — the stage after gaining access where adversaries identify, stage, and prepare sensitive data for exfiltration.

## Why it matters
During the 2020 SolarWinds campaign, after establishing persistent access, attackers used Collection techniques to harvest emails, documents, and credentials from compromised networks before moving data out. Defenders who monitor for unusual internal file access patterns, bulk archive creation (e.g., sudden ZIP file generation), or clipboard monitoring activity can catch this phase before exfiltration completes — stopping the breach at its most recoverable point.

## Key facts
- Collection precedes **Exfiltration** in the ATT&CK kill chain; data must be gathered and staged before it can be sent out
- Common sub-techniques include **Screen Capture**, **Keylogging**, **Email Collection**, **Clipboard Data**, and **Data from Local System**
- Attackers frequently **compress and encrypt** collected data (e.g., using 7-Zip or RAR) to reduce size and evade DLP tools during staging
- **Data Staged** (T1074) is a key sub-tactic where collected files are aggregated in one location — often a temp folder — before exfiltration
- Detection focus: look for abnormal access to file shares, mass file reads by a single account, or archiving tools run by unusual processes

## Related concepts
[[Exfiltration]] [[Data Loss Prevention]] [[MITRE ATT&CK]] [[Insider Threat]] [[Digital Forensics]]