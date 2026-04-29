# Logstash

## What it is
Think of Logstash as a universal airport baggage handler — it picks up luggage (logs) from dozens of different airlines (sources), slaps the right tags on each bag, and routes everything to the correct carousel (destination). Precisely: Logstash is an open-source data pipeline tool in the ELK Stack that ingests logs from multiple sources, transforms and normalizes them using filter plugins, and forwards the structured output to destinations like Elasticsearch for indexing and analysis.

## Why it matters
During a ransomware investigation, an analyst receives raw logs from Windows Event IDs, Apache web servers, and a Cisco firewall — all in different formats and timestamps. Logstash's `grok` filter parses these disparate formats into a unified schema, making it possible to correlate a phishing email arrival, a PowerShell execution event, and lateral movement — all within a single timeline in Kibana. Without this normalization step, cross-source correlation is effectively impossible at scale.

## Key facts
- **Pipeline architecture**: Logstash operates on three stages — **Input → Filter → Output** — each configurable with plugins (e.g., `beats`, `syslog`, `jdbc` for input; `grok`, `mutate`, `date` for filtering)
- **Grok is the workhorse**: The `grok` filter uses regex-based pattern matching to parse unstructured log data into named fields — critical for SIEM normalization
- **Listens on port 5044** by default when receiving logs from Beats agents (e.g., Filebeat, Winlogbeat)
- **Part of the ELK/Elastic Stack**: Logstash + Elasticsearch + Kibana form the core; Beats agents act as lightweight log shippers feeding into Logstash
- **Security relevance**: Misconfigured Logstash pipelines can expose sensitive log data or allow injection via untrusted input fields — classified as a data exposure risk

## Related concepts
[[ELK Stack]] [[SIEM]] [[Log Management]] [[Filebeat]] [[Security Monitoring]]