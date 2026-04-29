# Wazuh

## What it is
Think of Wazuh as a security guard who never sleeps, reads every log in the building, and immediately radios dispatch when something looks wrong. Precisely, Wazuh is an open-source Security Information and Event Management (SIEM) and Extended Detection and Response (XDR) platform that performs log analysis, file integrity monitoring, intrusion detection, and vulnerability assessment across endpoints and cloud environments.

## Why it matters
During a ransomware incident, attackers often spend days performing lateral movement before deploying their payload — modifying registry keys, adding scheduled tasks, and disabling security tools. Wazuh's file integrity monitoring (FIM) and rule-based alerting can flag these behaviors in near-real-time, giving defenders a window to contain the threat before encryption begins.

## Key facts
- Wazuh deploys as a **manager-agent architecture**: lightweight agents run on monitored endpoints and forward events to a central Wazuh Manager for correlation and alerting.
- It integrates natively with **OpenSearch/Elasticsearch** (via the Wazuh Indexer) for log storage and the **Wazuh Dashboard** (based on Kibana) for visualization.
- Wazuh maps detections to the **MITRE ATT&CK framework**, making it directly relevant to threat-hunting and CySA+ exam scenarios involving TTPs.
- The **File Integrity Monitoring (FIM)** module detects unauthorized changes to critical system files — a key control against both malware persistence and insider threats.
- Wazuh can perform **active response**: automatically blocking an IP via firewall rules or killing a malicious process when a rule threshold is triggered.

## Related concepts
[[SIEM]] [[File Integrity Monitoring]] [[MITRE ATT&CK]] [[Intrusion Detection System]] [[Log Analysis]]