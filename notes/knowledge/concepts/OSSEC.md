# OSSEC

## What it is
Think of OSSEC as a paranoid building manager who reads every log file, checks every door lock, and screams when someone rearranges the furniture — it watches your systems constantly for signs of tampering. OSSEC (Open Source Security Event Correlator) is a free, open-source Host-based Intrusion Detection System (HIDS) that performs log analysis, file integrity monitoring, rootkit detection, and real-time alerting across multiple platforms. It operates in agent/server or agentless modes, aggregating data from endpoints back to a central manager.

## Why it matters
During the 2013 Target breach, attackers modified system files and moved laterally for weeks before detection — exactly the scenario OSSEC is designed to catch. If OSSEC had been deployed on those Windows endpoints, its file integrity monitoring would have flagged unauthorized changes to critical system files and its log analysis would have correlated the anomalous network activity, potentially shrinking the attacker's dwell time from weeks to hours.

## Key facts
- **File Integrity Monitoring (FIM)**: OSSEC creates cryptographic checksums of monitored files and alerts when unauthorized changes occur — directly maps to CySA+ integrity monitoring objectives
- **Log Analysis Engine**: Correlates logs from Windows Event Logs, syslog, Apache, and others using rule sets to identify attack patterns
- **Active Response**: Can automatically block offending IP addresses via firewall rules when specific alert thresholds are triggered
- **Deployment Modes**: Supports agent-based (for local monitoring) and agentless (for routers/switches via SSH/syslog) configurations
- **OSSEC vs. Wazuh**: Wazuh is the actively maintained fork/successor of OSSEC, adding features like a REST API and ELK Stack integration — expect exam questions to reference both

## Related concepts
[[Host-based Intrusion Detection System]] [[File Integrity Monitoring]] [[Security Information and Event Management]] [[Log Analysis]] [[Wazuh]]