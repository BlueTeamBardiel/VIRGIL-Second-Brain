# Indicator of Compromise

## What it is
Like finding muddy boot prints and a broken window lock after a burglary — even if the thief is gone, evidence of their presence remains. An Indicator of Compromise (IoC) is a forensic artifact or observable piece of evidence that suggests a system or network has been breached, such as a suspicious IP address, malicious file hash, unusual registry key, or anomalous outbound traffic pattern.

## Why it matters
During the 2020 SolarWinds supply chain attack, security teams used IoCs — specifically malicious DLL file hashes and command-and-control domain names published by FireEye — to hunt through thousands of enterprise networks and identify compromised systems within hours of disclosure. Without those concrete, shareable IoCs, the scope of the breach would have taken weeks longer to establish.

## Key facts
- **Types of IoCs** fall into categories: network-based (suspicious IPs, domains, URLs), host-based (file hashes, registry changes, unusual processes), and behavioral (lateral movement patterns, large data exfiltration volumes)
- **STIX/TAXII** are the standardized formats/protocols used to share IoCs between organizations and threat intelligence platforms
- IoCs feed directly into **SIEM rules and threat intelligence platforms (TIPs)** like MISP or ThreatConnect for automated detection
- The **Pyramid of Pain** (by David Bianco) ranks IoCs by attacker cost to change: hash values are easiest for attackers to modify; TTPs (tactics, techniques, procedures) are hardest
- IoCs differ from **Indicators of Attack (IoAs)**: IoCs are retrospective (breach already happened), while IoAs detect active attack behaviors in progress

## Related concepts
[[Threat Intelligence]] [[SIEM]] [[Pyramid of Pain]] [[STIX TAXII]] [[Forensic Analysis]]