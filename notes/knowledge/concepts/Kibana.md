# Kibana

## What it is
Think of Kibana as the cockpit dashboard for a jumbo jet — all the raw flight data (altitude, speed, fuel) flowing in from sensors gets transformed into visual gauges a pilot can actually act on. Kibana is the open-source visualization and analytics front-end for the Elastic Stack (ELK), allowing security analysts to query, visualize, and explore log data stored in Elasticsearch through dashboards, charts, and search interfaces.

## Why it matters
During a ransomware investigation, a SOC analyst uses Kibana to pivot through millions of Windows Event Logs and network flow records — filtering on Event ID 4688 (process creation) to trace the exact patient-zero workstation that executed a malicious PowerShell command at 2:47 AM. Without Kibana's query and visualization layer, correlating those logs manually across hundreds of endpoints would be practically impossible under incident-response time pressure.

## Key facts
- Kibana is the **"K"** in the ELK Stack (Elasticsearch, Logstash, Kibana) — a common open-source SIEM-adjacent platform used in enterprise SOCs
- The **Kibana Query Language (KQL)** allows analysts to filter logs rapidly; example: `event.code: 4625 AND source.ip: 192.168.1.*` hunts for failed logins from a subnet
- Kibana itself has had critical CVEs (e.g., **CVE-2019-7609**, a prototype pollution RCE) — misconfigured or unpatched Kibana instances exposed to the internet are active attack targets
- Default Kibana port is **5601/TCP** — a key indicator during network reconnaissance or firewall rule audits
- Kibana **Canvas and SIEM app (Elastic Security)** provide pre-built detection rules mapped to the **MITRE ATT&CK framework**

## Related concepts
[[ELK Stack]] [[SIEM]] [[Log Analysis]] [[Elasticsearch]] [[MITRE ATT&CK]]