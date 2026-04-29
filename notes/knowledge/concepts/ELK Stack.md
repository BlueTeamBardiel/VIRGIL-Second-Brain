# ELK Stack

## What it is
Think of it like a hospital's central monitoring system: every machine, ward, and sensor feeds its data into one dashboard where doctors can spot a patient crashing in real time. ELK Stack (Elasticsearch, Logstash, Kibana) is an open-source log aggregation and analysis platform where Logstash collects and parses logs, Elasticsearch indexes and stores them for fast querying, and Kibana visualizes the data through dashboards and alerts. Together they function as a centralized SIEM-adjacent tool for security monitoring and threat hunting.

## Why it matters
During the 2020 SolarWinds breach, defenders who had centralized logging could correlate anomalous SAML token activity across identity providers — those relying on siloed logs missed the pattern entirely. An ELK Stack deployment would allow a SOC analyst to write a Kibana query surfacing all authentication events from privileged accounts outside business hours across thousands of endpoints simultaneously, turning a needle-in-a-haystack problem into a filtered, actionable alert.

## Key facts
- **Elasticsearch** uses an inverted index structure, enabling sub-second full-text searches across terabytes of log data
- **Logstash** uses a pipeline of *inputs → filters → outputs*; the Grok filter parses unstructured text (like Apache logs) into structured fields
- **Kibana** provides the visualization layer — dashboards, time-series graphs, and the Discover tab for raw log queries using KQL (Kibana Query Language)
- The modern stack is often called the **Elastic Stack**, adding **Beats** (lightweight shippers like Filebeat and Winlogbeat) as edge collectors
- ELK is commonly deployed as a **SIEM alternative or complement** — it handles log aggregation but requires manual rule-building unlike commercial SIEMs with built-in threat intelligence

## Related concepts
[[SIEM]] [[Log Aggregation]] [[Threat Hunting]] [[Security Monitoring]] [[Beats]]