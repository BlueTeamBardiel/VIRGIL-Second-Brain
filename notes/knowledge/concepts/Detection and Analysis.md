# Detection and Analysis

## What it is
Like a doctor who first notices symptoms, then runs tests to diagnose the disease before prescribing treatment — Detection and Analysis is the second phase of the NIST incident response lifecycle where security teams identify that an incident has occurred and investigate its scope, origin, and impact. It transforms raw alerts and log data into actionable understanding of *what* is happening and *why*.

## Why it matters
During the 2020 SolarWinds supply chain attack, defenders who had detection tooling in place began noticing anomalous lateral movement and unusual outbound DNS traffic — but organizations without mature analysis capabilities took months to recognize they were compromised at all. Proper detection and analysis capability shortened the gap between initial compromise and containment from months to days for prepared organizations.

## Key facts
- The **mean time to detect (MTTD)** a breach is a critical KPI; industry average historically exceeds 200 days without mature detection tooling
- Detection sources include **SIEM alerts, IDS/IPS logs, antivirus, NetFlow data, and threat intelligence feeds** — correlation across multiple sources reduces false positives
- **Event vs. Incident**: not every event is an incident; analysts must triage using severity classifications (P1–P4) to prioritize response resources
- **Indicators of Compromise (IoCs)** — such as malicious hashes, IP addresses, and domain names — are the primary artifacts examined during analysis
- The **Pyramid of Pain** (David Bianco) illustrates that detecting adversary TTPs (MITRE ATT&CK) is far more impactful than blocking individual IoCs, which attackers can change in minutes

## Related concepts
[[SIEM]] [[Indicators of Compromise]] [[NIST Incident Response Lifecycle]] [[MITRE ATT&CK Framework]] [[Mean Time to Detect]]