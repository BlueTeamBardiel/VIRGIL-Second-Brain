# Elasticsearch Query DSL

## What it is
Like SQL for a library where every book is a JSON document — instead of `SELECT * WHERE author='Smith'`, you send structured JSON payloads to search, filter, and aggregate data. Elasticsearch Query DSL (Domain Specific Language) is a JSON-based query language used to interact with Elasticsearch indexes via its REST API, enabling complex full-text search, filtering, and analytics operations.

## Why it matters
SIEM platforms like the Elastic Stack (formerly ELK Stack) use Query DSL to hunt threats — a SOC analyst might write a `bool` query combining `must` (threat actor IP) and `filter` (timeframe) clauses to isolate lateral movement events across millions of log entries. Attackers who gain access to an exposed Elasticsearch instance (default port 9200, historically no auth required) can use the same DSL to exfiltrate entire indexes containing credentials, PII, or internal logs with a single HTTP GET request.

## Key facts
- Elasticsearch historically shipped with **no authentication by default** — thousands of databases were publicly exposed and indexed by Shodan, leading to massive data breaches (e.g., 2019 exposure of 250M Microsoft customer records stored in Elasticsearch)
- Query DSL runs over **HTTP/HTTPS on port 9200** (REST API) and port 9300 (node communication), both should be firewalled from public access
- A `_search` endpoint with an empty query body (`{}`) returns **all documents** — equivalent to `SELECT *` with no WHERE clause
- **NoSQL injection** is possible if user input is interpolated directly into Query DSL JSON without sanitization, allowing query manipulation analogous to SQL injection
- The `_cat/indices` API endpoint reveals **all index names** without authentication on unprotected instances — a recon goldmine

## Related concepts
[[NoSQL Injection]] [[SIEM Architecture]] [[Shodan Reconnaissance]] [[API Security]] [[Data Exposure]]