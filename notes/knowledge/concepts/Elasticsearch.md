# Elasticsearch

## What it is
Think of it as a supercharged library index card system — instead of searching shelf by shelf, you can instantly find any book mentioning a specific word across millions of volumes simultaneously. Precisely, Elasticsearch is an open-source, distributed search and analytics engine built on Apache Lucene, commonly used to store, search, and analyze large volumes of log data, metrics, and security events in near real-time.

## Why it matters
Exposed Elasticsearch instances have been responsible for some of the largest data breaches in history — in 2019, over 1.2 billion personal records were found in an unauthenticated, publicly accessible Elasticsearch cluster. By default, older versions of Elasticsearch require **no authentication**, meaning any attacker who finds port 9200 open on Shodan can read, modify, or delete the entire database with a simple HTTP GET request.

## Key facts
- Default port is **9200** (HTTP REST API) and **9300** (inter-node cluster communication)
- Versions prior to 6.8/7.1 had **no built-in authentication or TLS** by default — security features required a paid X-Pack license
- Elasticsearch is the **"E"** in the ELK Stack (Elasticsearch, Logstash, Kibana), a common SIEM-adjacent log aggregation platform
- Data is exposed via a **RESTful API**, meaning curl or a browser can retrieve sensitive data if access controls are absent
- Misconfigurations are indexed by search engines like **Shodan and Censys**, making exposed clusters trivially discoverable by attackers

## Related concepts
[[SIEM]] [[Shodan]] [[Log Management]] [[Kibana]] [[Data Exposure]]