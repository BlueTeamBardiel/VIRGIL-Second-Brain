# OpenSearch

## What it is
Think of OpenSearch as a giant, real-time filing cabinet with a turbo-charged search engine built in — you can dump millions of log entries into it and instantly find the ones that match "failed SSH login from IP 192.168.1.5." Precisely, OpenSearch is an open-source, distributed search and analytics engine forked from Elasticsearch (by AWS in 2021) used to index, search, and visualize large volumes of log and event data. It is the backbone of many SIEM pipelines and security dashboards.

## Why it matters
Organizations running OpenSearch as their log aggregation backend must secure its API endpoints — by default, early Elasticsearch/OpenSearch deployments were unauthenticated, and attackers actively scanned for exposed port 9200 to exfiltrate or wipe entire log databases (the "Meow" attacks of 2020 destroyed thousands of such instances). Defenders use OpenSearch with OpenSearch Dashboards (formerly Kibana) to build real-time alerting rules that trigger on anomalous patterns like brute-force attempts or privilege escalation sequences.

## Key facts
- Default OpenSearch HTTP REST API runs on **port 9200**; nodes communicate on **port 9300**
- Forked from Elasticsearch 7.10 in 2021 by AWS under the **Apache 2.0 license** after Elastic's license change
- Supports **role-based access control (RBAC)** and TLS encryption via the OpenSearch Security plugin — not enabled by default in all configurations
- Commonly deployed as the storage and search layer in **SIEM stacks** alongside Logstash/Fluentd (ingest) and OpenSearch Dashboards (visualization)
- Misconfigured public-facing instances with no authentication are a known **CWE-306** (Missing Authentication for Critical Function) finding frequently flagged in penetration tests

## Related concepts
[[SIEM]] [[Elasticsearch]] [[Log Aggregation]] [[Port Security]] [[Role-Based Access Control]]